//
//  HTTPWorker.m
//  Xiuxiu
//
//  Created by Mac on 15/3/9.
//  Copyright (c) 2015年 yangdeger@gmail.com. All rights reserved.
//

#import "HTTPWorker.h"
#import <libkern/OSAtomic.h>
#import "NSString+ExtraXX.h"

@interface HTTPWorker()<NSStreamDelegate,NSURLConnectionDelegate> {
    //以下成员变量用于multipart-upload时候的计数
    NSString* _boundary;
    int32_t _itemPart;  //当前item的部分，0表示参数部分，1表示二进制内容部分
    int32_t _itemSubPart; //二进制的子部分
    NSInteger _itemIdx; //当前发布的item index
    NSInteger _itemLengthOffset; //当前发布的item 长度offset
    
    //用于上报统计
    uint64_t _startTime;
}
@property (nonatomic,strong) NSURLConnection* connection;
@property (nonatomic,strong) NSURLResponse* response;

/**
 * 对接到httpBodyStream的输出流，用于往里边写入multipart-upload的内容
 */
@property (nonatomic,strong) NSOutputStream* outputStream;

@end

@implementation HTTPWorker

-(void)dealloc
{
    [self.outputStream close];
    [self.outputStream setDelegate:nil];
//    DDLogDebug(@"%@ dealloc",self);
}

-(instancetype)initWithBaseUrl:(NSString *)urlString delegate:(id<HTTPWorkerDelegate>)delegate_
{
    self = [super init];
    if (self != nil) {
        [self doInitWithBaseUrl:urlString parameters:nil delegate:delegate_];
    }
    return self;
}

-(instancetype)initWithBaseUrl:(NSString *)urlString parameters:(NSDictionary *)parameters delegate:(id<HTTPWorkerDelegate>)delegate_
{
    self = [super init];
    if (self != nil) {
        [self doInitWithBaseUrl:urlString parameters:parameters delegate:delegate_];
    }
    return self;
}

-(void)doInitWithBaseUrl:(NSString*)baseUrl parameters:(NSDictionary*)parameters delegate:(id<HTTPWorkerDelegate>)delegate_
{
    _baseUrl = baseUrl;
    _parameters = parameters;
    _delegate = delegate_;
    _buffer = [NSMutableData data];
    //some default ..
    self.method = @"POST";
    self.timeoutInterval = 45;
}

-(void)requestAsync:(NSOperationQueue*)workingQueue
{
    NSURLRequest* request = [self buildURLRequest];
    
    //mta stat
    if(self.stringInfo != nil) {
        _startTime = [NSString sysTimeInMilliseconds];
    }
    
    self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
    
//    DDLogDebug(@"send url: %@",[request.URL absoluteString]);
    [workingQueue addOperationWithBlock:^{
        OSAtomicIncrement32(&_lock);
        NSRunLoop* loop = [NSRunLoop currentRunLoop];
        [_connection scheduleInRunLoop:loop forMode:NSDefaultRunLoopMode];
        [_connection start];
        
        while (_lock > 0) {
            @try {
                [loop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];

            } @catch (NSException *exception) {
                NSLog(@"reason ==== %@",exception);
            } @finally {
             
            }

            
        }
    }];
}

-(void)cancelRequest
{
    [_connection cancel];
    _cancel = YES;
    //由于cancel之后就不再有delegate回调了，这里减少计数器
    OSAtomicDecrement32(&_lock);
}

-(void)multipartPartAddData:(NSData *)data contentType:(NSString *)contentType fileName:(NSString *)fileName forKey:(NSString *)key
{
    //lazy init
    if (_postDatas == nil) {
        _postDatas = [NSMutableArray array];
        _postFileNames = [NSMutableArray array];
        _postContentTypes = [NSMutableArray array];
        _postKeys = [NSMutableArray array];
    }
    
    [_postDatas addObject:data];
    [_postFileNames addObject:fileName];
    [_postContentTypes addObject:contentType];
    [_postKeys addObject:key];
}

#pragma mark - private

/**
 * 使用之前设置的parameters来构造请求,这里parameters的key和value都被认为是NSString类型的
 * 
 * @return 构造好的请求
 */
-(NSMutableURLRequest*)buildURLRequest

{
    NSURL* url = [[NSURL alloc] initWithString:_baseUrl];
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:_timeoutInterval];
    request.HTTPMethod = _method;
    
    if ([_postKeys count] > 0 && [_method isEqualToString:@"POST"]) { //multipart build
        [self setHeaderAndParametersForMultipartPostToRequest:request];
//        [self prepareForMultipartUpload:request];
    }else{ //default part
        [self setParametersToRequest:request];
    }
    return request;
}

-(void)setHeaderAndParametersForMultipartPostToRequest:(NSMutableURLRequest*)request
{
//    DDLogInfo(@"use HTTPBody to send.",nil);
    //gen a ramdon boundary
    NSString* boundary = [NSString stringWithFormat:@"yuchaonan%i",arc4random_uniform(10000)];
    boundary = [NSString stringWithFormat:@"-------------------------%@",[boundary md5Value]];
    
    //set boundary to header
    [request setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary] forHTTPHeaderField:@"Content-Type"];
    
    //build body with parameters.
    NSMutableData* body = [NSMutableData data];
    NSArray* keys = [_parameters allKeys];
    NSInteger count = [keys count];
    for (NSInteger i = 0; i < count; i++) {
        NSString* key = keys[i];
        NSString* value = _parameters[key];
        NSString* ctx = [NSString stringWithFormat:@"--%@\r\nContent-Disposition: form-data; name=\"%@\"\r\n\r\n%@\r\n",boundary,key,value];
        [body appendData:[ctx dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    //build binary parameters
    count = [_postKeys count];
    for (NSInteger i = 0; i < count; i++) {
        NSString* key = _postKeys[i];
        NSString* fileName = _postFileNames[i];
        NSString* contentType = _postContentTypes[i];
        NSString* ctx = [NSString stringWithFormat:@"--%@\r\nContent-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n",boundary,key,fileName];
        [body appendData:[ctx dataUsingEncoding:NSUTF8StringEncoding]];
        ctx = [NSString stringWithFormat:@"Content-Type: %@\r\n\r\n",contentType];
        [body appendData:[ctx dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:_postDatas[i]];
        [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    //ending of body
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:body];
}

-(void)prepareForMultipartUpload:(NSMutableURLRequest*)request
{
//    DDLogInfo(@"use HTTPBodyStream to send.",nil);
    //gen a ramdon boundary
    NSString* boundary = [NSString stringWithFormat:@"yuchaonan%i",arc4random_uniform(10000)];
    boundary = [NSString stringWithFormat:@"-------------------------%@",[boundary md5Value]];
    
    //set boundary to header
    [request setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary] forHTTPHeaderField:@"Content-Type"];
    //save it for stream using
    _boundary = boundary;
    
    //create bi-way stream
    CFIndex buffer_size = 16*1024;
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    CFStreamCreateBoundPair(kCFAllocatorDefault, &readStream, &writeStream, buffer_size);
    
    request.HTTPBodyStream = CFBridgingRelease(readStream);
    self.outputStream = CFBridgingRelease(writeStream);
    self.outputStream.delegate = self;
    
    //schedule them
    [self.outputStream scheduleInRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    [self.outputStream open];
    //Note> inputStream will be opened and scheduled by the request!
    
    //reset item counters
    _itemIdx = 0;
    _itemLengthOffset = 0;
    if ([self.parameters count] == 0 && [_postKeys count] > 0) { //没有字符型参数，直接跳到二进制型参数
        _itemPart = 1;
    }else{
        _itemPart = 0;
    }
}

/**
 * 将paramters根据不同的请求method拼装到适当位置：对于GET，是附加在url链接后，对于POST，放到body中
 * 
 * @param request 待修改请求
 */
-(void)setParametersToRequest:(NSMutableURLRequest*)request

{
    if ([_method isEqualToString:@"GET"]) {
        //no implement
    }else if([_method isEqualToString:@"POST"]) {
        NSString* pStr = [self buildParameterString:_parameters];
        request.HTTPBody = [pStr dataUsingEncoding:NSUTF8StringEncoding];
    }
}

/**
 * 将字典内容拼接成字符串格式，形如"key1=value1&key2=value2"
 * 
 * @param params 需要转换的字典
 * @return 拼接好的字符串
 */
-(NSString*)buildParameterString:(NSDictionary*)params
{
    NSMutableString* str = [NSMutableString string];
    NSArray* keys = [params allKeys];
    NSInteger count = [keys count];
    for (NSInteger i = 0; i < count; i++) {
        NSString* key = keys[i];
        NSString* value = params[key];
        //TODO: url encode.
        [str appendFormat:@"%@=%@&",key,value];
    }
    if ([str length] > 0) { //remove last '&' mark
        [str replaceCharactersInRange:NSMakeRange(str.length-1, 1) withString:@""];
    }
    return str;
}

-(NSMutableURLRequest*)buildPostRequestWithData:(NSData*)data
{
    NSURL* url = [[NSURL alloc] initWithString:_baseUrl];
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:_timeoutInterval];
    request.HTTPMethod = @"POST";
    request.HTTPBody = data;

    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    return request;
}

#pragma mark - NSURLConnection Delegate

- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    //1)获取trust object
    SecTrustRef trust = challenge.protectionSpace.serverTrust;
    SecTrustResultType result;
    
    //2)SecTrustEvaluate对trust进行验证
    OSStatus status = SecTrustEvaluate(trust, &result);
    if (status == errSecSuccess &&
        (result == kSecTrustResultProceed ||
         result == kSecTrustResultUnspecified)) {
            
            //3)验证成功，生成NSURLCredential凭证cred，告知challenge的sender使用这个凭证来继续连接
            NSURLCredential *cred = [NSURLCredential credentialForTrust:trust];
            [challenge.sender useCredential:cred forAuthenticationChallenge:challenge];
            
        } else {
            
            //5)验证失败，取消这次验证流程
            [challenge.sender cancelAuthenticationChallenge:challenge];
            
        }
}

-(NSInputStream *)connection:(NSURLConnection *)connection needNewBodyStream:(NSURLRequest *)request
{
//    DDLogInfo(@"ask a new stream!",nil);
    return nil;
}

//-(void)connection:(NSURLConnection *)connection didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite
//{
//    DDLogInfo(@"connection send %d bytes, total: %d",bytesWritten,totalBytesWritten);
//}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_buffer appendData:data];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    //由于各大网络框架都不做类型判断，并且发现，可能这里真有可能即使HTTP请求，这里也不能被识别为HTTP类型的response，这里不再判断。
//    if (![response isKindOfClass:[NSHTTPURLResponse class]]) { //something we don't know
//        DDLogInfo(@"connection %@ return a unknown response: %@",response);
//        
//        if ([_delegate respondsToSelector:@selector(httpWorker:fail:)]) {
//            NSError* error = [[NSError alloc] initWithDomain:@"Unknown Response" code:-1 userInfo:nil];
//            [_delegate httpWorker:self fail:error];
//        }
//        return ;
//    }
    self.response = response;
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    //mta stat
    if (self.stringInfo != nil) {
        uint64_t endTime = [NSString sysTimeInMilliseconds];
//        MTAAppMonitorStat* ams = [[MTAAppMonitorStat alloc] init];
//        ams.interface = self.stringInfo;
//        ams.consumedMilliseconds = endTime - _startTime;
//        ams.resultType = MTA_FAILURE;
//        mta_track_network_request(ams);
    }
    
    if ([_delegate respondsToSelector:@selector(httpWorker:fail:)]) {
        [_delegate httpWorker:self fail:error];
    }
    OSAtomicDecrement32(&_lock);

}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSHTTPURLResponse* hr = (NSHTTPURLResponse*)self.response;
    int code = 200;
    if ([hr isKindOfClass:[NSHTTPURLResponse class]]) {
        code = (int)hr.statusCode;
    }
    if (code < 400) {
        //mta stat
        if (self.stringInfo != nil) {
            uint64_t endTime = [NSString sysTimeInMilliseconds];
//            MTAAppMonitorStat* ams = [[MTAAppMonitorStat alloc] init];
//            ams.interface = self.stringInfo;
//            ams.consumedMilliseconds = endTime - _startTime;
//            ams.resultType = MTA_SUCCESS;
//            ams.responsePackageSize = (uint32_t)[_buffer length];
//            mta_track_network_request(ams);
        }
        
        if ([_delegate respondsToSelector:@selector(httpWorker:success:)]) {
            [_delegate httpWorker:self success:[_buffer copy]];
        }
    }else{
        //mta stat
        if (self.stringInfo != nil) {
            uint64_t endTime = [NSString sysTimeInMilliseconds];
//            MTAAppMonitorStat* ams = [[MTAAppMonitorStat alloc] init];
//            ams.interface = self.stringInfo;
//            ams.consumedMilliseconds = endTime - _startTime;
//            ams.resultType = MTA_FAILURE;
//            ams.responsePackageSize = (uint32_t)[_buffer length];
//            mta_track_network_request(ams);
        }
        
        if ([_delegate respondsToSelector:@selector(httpWorker:fail:)]) {
            NSError* error = [[NSError alloc] initWithDomain:@"HTTP Response Error" code:-2 userInfo:@{@"status":@(code)}];
            [_delegate httpWorker:self fail:error];
        }
    }
    OSAtomicDecrement32(&_lock);
}


#pragma mark - streams

-(void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode
{
    NSOutputStream* os = (NSOutputStream*)aStream;
    
    if (![os isKindOfClass:[NSOutputStream class]]) {//WTF ?!
        return ;
    }
    
    if (_cancel) {
        [os close];
        return ;
    }
    
    switch (eventCode) {
        case NSStreamEventOpenCompleted: {
//            DDLogDebug(@"upload stream opend.",nil);
        }   break;
        case NSStreamEventHasSpaceAvailable: {
//            DDLogDebug(@"can write more data now...",nil);
            [self fillStreamBody:os];
        }   break;
        default:
            break;
    }
    
}

/**
 * <#Description#>
 * 
 * @return <#return value description#>
 */
-(void)fillStreamBody:(NSOutputStream*)os
{
    if (_itemPart == 0) {
        BOOL hasSpaceToWrite = os.hasSpaceAvailable;
        NSInteger itCount = [_parameters count];
        while (_itemIdx < itCount && hasSpaceToWrite) {
            hasSpaceToWrite = [self fillStreamBody:os usingTextValue:_itemIdx];
        }
        //如果都写完了，并且还有空间，就继续写
        if (_itemIdx >= itCount && hasSpaceToWrite) {
//            DDLogInfo(@"all text parameters finished.(PART I)",nil);
            _itemIdx = 0;
            _itemPart = 1;
        }
    }
    
    if(_itemPart == 1) {
        BOOL hasSpaceToWrite = os.hasSpaceAvailable;
        NSInteger itCount = [_postKeys count];
        while (_itemIdx < itCount && hasSpaceToWrite) {
            hasSpaceToWrite = [self fillStreamBody:os usingBinaryValue:_itemIdx];
        }
        
        //如果都写完了，并且还有空间，就继续写
        if (_itemIdx >= itCount && hasSpaceToWrite) {
//            DDLogInfo(@"all binary parameters finished.(PART II)",nil);
            _itemIdx = 0;
            _itemPart = 2;
        }
    }
    
    if (_itemPart == 2) {
        BOOL written = [self fillStreamBodyEndMark:os];
        if (written) { //已经完成了包体的写入
            [os close];
        }
    }
}

-(BOOL)fillStreamBody:(NSOutputStream*)os usingTextValue:(NSInteger)itemIndex
{
    if (itemIndex >= [_parameters count]) {
        return os.hasSpaceAvailable;
    }
    NSArray* keys = [_parameters allKeys];
    NSString* key = keys[itemIndex];
    NSString* value = _parameters[key];
    NSString* ctx = [NSString stringWithFormat:@"--%@\r\nContent-Disposition: form-data; name=\"%@\"\r\n\r\n%@\r\n",_boundary,key,value];
    NSData* data_to_write = [ctx dataUsingEncoding:NSUTF8StringEncoding];
    const char* byte_to_write = [data_to_write bytes];
    
    NSInteger offset = [os write:byte_to_write maxLength:[data_to_write length]];
//    DDLogDebug(@"%ld bytes written.",(long)offset);
    
    if (offset == [data_to_write length]) {
        _itemIdx += 1;
        return YES;
    }else{
        //TODO: 记录offset偏移
        return NO;
    }
}

-(BOOL)fillStreamBody:(NSOutputStream*)os usingBinaryValue:(NSInteger)itemIndex
{
    if (itemIndex >= [_postKeys count]) {
        return os.hasSpaceAvailable;
    }
    
    if (_itemSubPart == 0) { //trailing
        //build item
//        DDLogInfo(@"binary part 1 -> %ld",_itemLengthOffset);
        NSString* key = _postKeys[itemIndex];
        NSString* fileName = _postFileNames[itemIndex];
        NSString* contentType = _postContentTypes[itemIndex];
        NSString* ctx = [NSString stringWithFormat:@"--%@\r\nContent-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\nContent-Type: %@\r\n\r\n",_boundary,key,fileName,contentType];
        NSData* data_to_write = [ctx dataUsingEncoding:NSUTF8StringEncoding];
        BOOL written = [self writeToStream:os data:data_to_write offset:&_itemLengthOffset];
        if (written) {
//            DDLogInfo(@"binary part 1 finished!",nil);
            _itemSubPart = 1;
            _itemLengthOffset = 0;
        }
        return written;
    }

    if (_itemSubPart == 1) { //binary
//        DDLogInfo(@"binary part 2 -> %ld",(long)_itemLengthOffset);
        NSData* data_to_write = _postDatas[itemIndex];
        BOOL written = [self writeToStream:os data:data_to_write offset:&_itemLengthOffset];
        if (written) {
//            DDLogInfo(@"binary part 2 finished!",nil);
            _itemSubPart = 2;
            _itemLengthOffset = 0;
        }
        return written;
    }
    
    if (_itemSubPart == 2) { //tailing
//        DDLogInfo(@"binary part 3 -> %d",_itemLengthOffset);
        NSData* data_to_write = [@"\r\n" dataUsingEncoding:NSUTF8StringEncoding];
        BOOL written = [self writeToStream:os data:data_to_write offset:&_itemLengthOffset];
        if (written) {
//            DDLogInfo(@"binary part 3 finished!",nil);
            _itemSubPart = 0; //finished
            _itemLengthOffset = 0;
            _itemIdx += 1;
        }
        return written;
    }
    
    return os.hasSpaceAvailable;
}

-(BOOL)fillStreamBodyEndMark:(NSOutputStream*)os
{
//    DDLogInfo(@"will set end mark",nil);
    NSData* data_to_write = [[NSString stringWithFormat:@"--%@--\r\n",_boundary] dataUsingEncoding:NSUTF8StringEncoding];
    const unsigned char* byte_to_write = [data_to_write bytes];
    
    NSInteger offset = [os write:byte_to_write maxLength:[data_to_write length]];
    return offset == [data_to_write length];
    
}


-(BOOL)writeToStream:(NSOutputStream*)os data:(NSData*)data_to_write offset:(NSInteger*)write_offset
{
    const unsigned char* bytes_to_write = [data_to_write bytes];
    bytes_to_write += *write_offset;
    
    NSInteger offset = [os write:bytes_to_write maxLength:[data_to_write length]-*write_offset];
    *write_offset += offset;
    if (*write_offset == [data_to_write length]) {
        return YES;
    }else{
        return NO;
    }
}
@end
