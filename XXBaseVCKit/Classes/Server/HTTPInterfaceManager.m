//
//  HTTPInterfaceManager.m
//  Xiuxiu
//
//  Created by Mac on 15/3/10.
//  Copyright (c) 2015年 yangdeger@gmail.com. All rights reserved.
//

#import "HTTPInterfaceManager.h"
#import "HTTPWorker.h"
//#import "Config.h"
#import "NSString+ExtraXX.h"
//业务相关
//#import "AccountManager.h"
//#import "MTAHelper.h"
//#import "LocalProfileManager.h"
//#import "XXUserModel.h"
#import "IPSelector.h"
#import "HTTPInterfaceAddress.h"
//#import "UtilityToolkit.h"

#define kIMKey_RequestId @"InterfaceManagerRequestId"

static NSOperationQueue* s_working_queue;

/*
 * 计算tk的函数
 *
 * 将请求根据跟服务器的约定进行计算得到tk的值。该函数原来是Manager的一个方法，现在写成函数，多一点保护
 */
//static NSString* genTokenWithParameters(NSDictionary* parameters) __attribute__((always_inline));
//static NSString* genTokenPlainArray(NSArray* array);
//static NSString* genTokenPlainDictionary(NSDictionary* dct);
//static BOOL isPureNumandCharacters(NSString *string);
//
//NSString* genTokenWithParameters(NSDictionary* parameters)
//{
//    NSMutableString *str = [NSMutableString string];
//    //获取所有key
//    NSArray *keyList = parameters.allKeys;
//    //按字母排序
//    NSArray *sortedArray = [keyList sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
//        return [obj1 compare:obj2];
//    }];
//    //排序后拼接字符串
//    for (NSString *key in sortedArray){
//        id value = parameters[key];
//        NSString* value_str = @"";
//        //根据服务器要求，去除掉空格等字符
//        if ([value isKindOfClass:[NSString class]]) {
//            //去除头尾的空白字符
//            value_str = [(NSString*)value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//        }else if([value isKindOfClass:[NSArray class]]){
//            value_str = genTokenPlainArray(value);
//        }else if([value isKindOfClass:[NSDictionary class]]) {
//            value_str = genTokenPlainDictionary(value);
//        }else{
//            value_str = [NSString stringWithFormat:@"%@",value]; //something like number or other
//        }
//        [str appendString:[NSString stringWithFormat:@"%@",value_str]];
//    }
//    NSString* tk = [str md5Value];
//    return tk;
//}
//
//NSString* genTokenPlainArray(NSArray* array)
//{
//    NSMutableString *str = [NSMutableString string];
//    for (id obj in array) {
//        NSString* value_str = nil;
//        if ([obj isKindOfClass:[NSString class]]) {
//            //去除头尾的空白字符
//            value_str = [(NSString*)obj stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//        }else if([obj isKindOfClass:[NSArray class]]) {
//            value_str = genTokenPlainArray(obj);
//        }else if([obj isKindOfClass:[NSDictionary class]]) {
//            value_str = genTokenPlainDictionary(obj);
//        }else{
//            value_str = [NSString stringWithFormat:@"%@",obj]; //something like number or other
//        }
//        [str appendString:value_str];
//    }
//    return str;
//}
////{"1":3,"21":4,"19":2,"2":0,"18":1} 30124
//NSString* genTokenPlainDictionary(NSDictionary* dct)
//{
//    NSMutableString *str = [NSMutableString string];
//    //获取所有key
//    NSArray *keyList = dct.allKeys;
//    //按字母排序
//    NSArray *sortedArray = [keyList sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
//        
//        if (isPureNumandCharacters(obj2) && isPureNumandCharacters(obj1)) {
//            return [obj1 integerValue] > [obj2 integerValue];
//        } else {
//            return [obj1 compare:obj2];
//        }
//        
//    }];
//    //排序后拼接字符串
//    for (NSString *key in sortedArray){
//        id obj = dct[key];
//        NSString* value_str = @"";
//        //根据服务器要求，去除掉空格等字符
//        if ([obj isKindOfClass:[NSString class]]) {
//            //去除头尾的空白字符
//            value_str = [(NSString*)obj stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//        }else if([obj isKindOfClass:[NSArray class]]) {
//            value_str = genTokenPlainArray(obj);
//        }else if([obj isKindOfClass:[NSDictionary class]]) {
//            value_str = genTokenPlainDictionary(obj);
//        }else{
//            value_str = [NSString stringWithFormat:@"%@",obj]; //something like number or other
//        }
//        [str appendString:value_str];
//    }
//    return str;
//}
//
//BOOL isPureNumandCharacters(NSString *string) {
//    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
//    if(string.length > 0)
//    {
//        return NO;
//    } 
//    return YES;
//}


@interface HTTPInterfaceManager()<HTTPWorkerDelegate>

@end

@implementation HTTPInterfaceManager

+(NSOperationQueue*)getDefaultWorkingQueue
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_working_queue = [[NSOperationQueue alloc] init];
        s_working_queue.maxConcurrentOperationCount = 6;
    });
    return s_working_queue;
}

-(void)dealloc
{
//    DDLogInfo(@" oops..",nil);
}

-(instancetype)init
{
    return [self initWithWorkingQueue:[HTTPInterfaceManager getDefaultWorkingQueue]];
}

-(instancetype)initWithWorkingQueue:(NSOperationQueue*)queue
{
    self = [super init];
    if (self != nil) {
        _workingQueue = queue;
        _workers = [NSMutableArray array];
        _autoRetryTimes = 2; //重试3次
    }
    return self;
}

#pragma mark - public tool method
-(NSDictionary *)commonParseResult:(NSData *)response success:(BOOL *)flag
{
    NSError* error = nil;
    NSDictionary *retDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:&error];

    if (retDic) {
        NSInteger respCode = [retDic[@"ret"] integerValue];
        if (respCode != 0) {
            *flag = NO;
        } else {
            retDic = [retDic objectForKey:@"result"];;
            *flag = YES;
        }
    }else{
        NSString* jstr = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
//        DDLogInfo(@"parse string: %@\n error: %@",jstr,error);
    }
    return retDic;
}

//+(NSString *)genUserAvatarUrlStringWithUserModel:(XXUserModel *)userModel
//{
//    NSArray* picArr = nil;
//    if([userModel.picList length] > 0) {
//        picArr = [userModel.picList componentsSeparatedByString:@","];
//    }
//    if ([picArr count] == 0) {
//        return @""; //返回nil可能会被直接设置到dictionary里边，就返回一个空串
//    }
//    NSString* picId = [picArr objectAtIndex:0];
//    //这里使用缩略图
//    return [LocalProfileManager profileThumbnailImageUrlStringWithPicId:picId];
//}

#pragma mark - for category use

/**
 * 对请求增加公共参数
 * @param orgParams 不含有公共参数的请求参数
 * @return 添加公共参数后的参数
 */
-(NSDictionary*)addCommomParameters:(NSDictionary*)orgParams
{
    return [self addCommomParameters:orgParams notToken:NO];
}

-(NSDictionary *)addCommomParameters:(NSDictionary *)orgParams notToken:(BOOL)noToken
{
    NSMutableDictionary* mdict = nil;
    if ([orgParams respondsToSelector:@selector(setObject:forKey:)]) {
        mdict = (NSMutableDictionary*)orgParams;
    }else{
        mdict = [NSMutableDictionary dictionaryWithDictionary:orgParams];
    }

//    AccountManager* am = [AccountManager sharedManager];
//    [mdict setObject:kSvrProtocolVer forKey:@"ver"];
//    [mdict setObject:kAppID forKey:@"appid"];
//    [mdict setObject:gxxAppVer forKey:@"appver"];
//    [mdict setObject:kAppLaunguage forKey:@"lang"];
//    [mdict setObject:kAppPlatform forKey:@"platform"];
//    [mdict setObject:[am clientId] forKey:@"clientid"];
//    [mdict setObject:gxxIdfa forKey:@"idfa"];
//
//    [mdict setObject:[gxxChannel length] == 0 ? @"" : gxxChannel forKey:@"channel"];
//    if (!noToken) {
//        NSString* token = [am token];
//        [mdict setObject: [token length] > 0 ?  token : @"" forKey:@"token"];
//    }
//    //add check token
//    NSString* token = genTokenWithParameters(mdict);
//    [mdict setObject:token forKey:@"tk"];
    
    return mdict;
}

-(NSString*)genPackedJsonStringWithParameters:(NSDictionary*)params
{
    return [self genPackedJsonStringWithParameters:params needPercentEscape:YES];
}

-(NSString *)genPackedJsonStringWithParameters:(NSDictionary *)params needPercentEscape:(BOOL)encode
{
    NSError* error = nil;
    
    NSData* jdata = [NSJSONSerialization dataWithJSONObject:params options:0 error:&error];
    if (error) {
//        DDLogError(@"gen json string error: %@",error);
    }
    NSString* str = [[NSString alloc] initWithData:jdata encoding:NSUTF8StringEncoding];
//    DDLogDebug(@"parameter before escape %@",str);
    //对整个data字段进行encode
    if (encode) {
        str = [str percentEscapes];
    }
    return str;
}

-(id)sendRequestWithInterfaceId:(XXInterfaceId)iid parameters:(NSDictionary *)params userInfo:(NSDictionary *)userInfo
{
    
    NSString* suffix = nil;
    NSString* urlStr = [HTTPInterfaceAddress interfaceAddressWithID:iid suffix:&suffix];
    HTTPWorker* worker = [[HTTPWorker alloc] initWithBaseUrl:urlStr parameters:params delegate:self];
    worker.userInfo = userInfo;
    worker.integerInfo = iid;
    worker.stringInfo = suffix; //上报
    [worker requestAsync:_workingQueue];
    
    @synchronized(_workers) {
        [_workers addObject:worker];
    }
    
    return worker;
}

-(id)sendRequestWithInterfaceId:(XXInterfaceId)iid parameters:(NSDictionary *)params timeout:(NSTimeInterval)timeout userInfo:(NSDictionary *)userInfo
{
    NSString* suffix = nil;
    NSString* urlStr = [HTTPInterfaceAddress interfaceAddressWithID:iid suffix:&suffix];
    HTTPWorker* worker = [[HTTPWorker alloc] initWithBaseUrl:urlStr parameters:params delegate:self];
    worker.userInfo = userInfo;
    worker.integerInfo = iid;
    worker.stringInfo = suffix; //上报
    if (timeout > 0) {
        worker.timeoutInterval = timeout;
    }
    [worker requestAsync:_workingQueue];
    
    @synchronized(_workers) {
        [_workers addObject:worker];
    }
    
    return worker;
}

-(void)cancelRequestWithInterfaceId:(XXInterfaceId)iid
{
    [self findWorkerWithInterfaceId:iid doSomething:^(HTTPWorker *worker) {
        [worker cancelRequest];
        [_workers removeObject:worker];
    }];
}

-(void)cancelAllRequests
{
    @synchronized(_workers) {
        HTTPWorker* w = nil;
        while ((w = [_workers lastObject]) != nil) {
            [w cancelRequest];
            [_workers removeLastObject];
        }
    }
}

-(void)findWorkerWithInterfaceId:(XXInterfaceId)iid doSomething:( void (^)(HTTPWorker* worker) )block
{
    @synchronized(_workers) {
        HTTPWorker* worker = nil;
        for (HTTPWorker* w in _workers) {
            if (w.integerInfo == iid) {
                worker = w;
                break;
            }
        }
        if (worker != nil && block != nil) {
            block(worker);
        }
    }
}


#pragma mark - http worker delegate
-(void)httpWorker:(HTTPWorker *)worker success:(NSData *)responseData
{
    XXInterfaceId iid = (XXInterfaceId)worker.integerInfo;
    id<HTTPInterfaceManagerDelegate> delegate = _delegate;
    
#ifdef DEBUG
    NSString* jsonObj = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:NULL];
    if (jsonObj) {
//        DDLogVerbose(@"respone for %@:\n%@",worker.baseUrl,jsonObj);
    }else{
//        DDLogVerbose(@"no date %@:\n%@",worker.baseUrl,jsonObj);
    }
#endif
    
    if ([delegate respondsToSelector:@selector(interface:successWithData:userInfo:)]) {
        [delegate interface:iid successWithData:responseData userInfo:worker.userInfo];
    }
    
    NSURL* url = [[worker.connection originalRequest] URL];
    NSString* report_str = [url host];
    int report_port = [[url port] intValue];
    [[IPSelector sharedSelector] reportGoodHost:report_str port:report_port];
    
    //从队列里边移除
    [self findWorkerWithInterfaceId:iid doSomething:^(HTTPWorker *worker) {
        [_workers removeObject:worker];
    }];
}

-(void)httpWorker:(HTTPWorker *)worker fail:(NSError *__autoreleasing)error
{
    XXInterfaceId iid = (XXInterfaceId)worker.integerInfo;
    
    //这里可能有各种错误，包括无法连接到服务器，服务器返回未知内容，服务器返回400或以上的错误码等
    
    //无论如何，先记录失败
    NSInteger errorCode = error.code;
    if (errorCode < NSURLErrorCancelled) {
        NSURL* url = [[worker.connection originalRequest] URL];
        NSString* report_str = [url host];
        int report_port = [[url port] intValue];
        [[IPSelector sharedSelector] reportBadHost:report_str port:report_port];
    }
    //进行重试，如果需要（允许）的话
    NSInteger currentTry = worker.integerInfo2;
    BOOL canRetry = NO;
    //这里对没有自定义链接和上传头像的进行处理。。当前简单判断
    if (currentTry < self.autoRetryTimes && (iid != XICustomUrl && iid != XIUploadAvatar)) {
        canRetry = YES;
    }
    if (canRetry) {
        //从队列里边移除
        [self findWorkerWithInterfaceId:iid doSomething:^(HTTPWorker *worker) {
            [_workers removeObject:worker];
        }];
        
        int state_code = [error.userInfo[@"status"] intValue];
//        DDLogWarn(@"http request %@ fail! status code = %d retry..(#%d)",worker.baseUrl, (int)state_code, (int)currentTry);
        NSString* suffix = nil;
        
        NSString* urlStr = nil;
        urlStr = [HTTPInterfaceAddress interfaceAddressWithID:iid suffix:&suffix];
        HTTPWorker* worker_retry = [[HTTPWorker alloc] initWithBaseUrl:urlStr parameters:worker.parameters delegate:self];
        worker_retry.userInfo = worker.userInfo;
        worker_retry.integerInfo = iid;
        worker_retry.integerInfo2 = worker.integerInfo2 + 1;
        worker_retry.integerInfo3 = worker.integerInfo3;
        worker_retry.stringInfo = suffix;
        [worker_retry requestAsync:_workingQueue];
        @synchronized(_workers) {
            [_workers addObject:worker_retry];
        }
        
    }else{
        id<HTTPInterfaceManagerDelegate> delegate = _delegate;
        if ([delegate respondsToSelector:@selector(interface:failWithError:userInfo:)]) {
            [delegate interface:iid failWithError:error userInfo:worker.userInfo];
        }
        
        int state_code = [error.userInfo[@"status"] intValue];
//        DDLogError(@"http request %@ fail! status code = %d error = %@",worker.baseUrl, (int)state_code, error);
        
        //从队列里边移除
        [self findWorkerWithInterfaceId:iid doSomething:^(HTTPWorker *worker) {
            [_workers removeObject:worker];
        }];
    }
}

#pragma mark -

-(id)getCustomUrl:(NSString *)urlStr withDelegate:(id<HTTPInterfaceManagerDelegate>)delegate_ userinfo:(NSDictionary *)userInfo
{
    HTTPWorker* worker = [[HTTPWorker alloc] initWithBaseUrl:urlStr parameters:nil delegate:self];
    worker.method = @"GET";

    worker.integerInfo = XICustomUrl;
    worker.userInfo = userInfo;
    [worker requestAsync:_workingQueue];
    
    return worker;
}

-(id)checkNewVersionWithUserInfo:(NSDictionary *)userInfo
{
    int ver = [[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"] intValue];
    NSDictionary* dict = @{@"platform":@(1),
                           @"appver":@(ver)};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XICheckNewVersion parameters:final_params userInfo:userInfo];
}

-(id)shopLoginWithUserinfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIShopLogin parameters:final_params userInfo:userInfo];
}


@end
