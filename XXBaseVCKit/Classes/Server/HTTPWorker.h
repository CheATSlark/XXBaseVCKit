//
//  HTTPWorker.h
//  Xiuxiu
//
//  Created by Mac on 15/3/9.
//  Copyright (c) 2015年 yangdeger@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HTTPWorker;

@protocol HTTPWorkerDelegate <NSObject>
-(void)httpWorker:(HTTPWorker *)worker success:(NSData*)responseData;
-(void)httpWorker:(HTTPWorker *)worker fail:(__autoreleasing NSError*)error;
@end

/**
 用于发送http网络请求，允许同步和异步两种模式
 **/
@interface HTTPWorker : NSObject<NSURLConnectionDataDelegate,NSURLConnectionDownloadDelegate> {
    NSMutableData* _buffer;
    int32_t _lock;
    BOOL _cancel;
    //下述为了保存multipart的content内容，包括key（即name），contentType，fileName和data
    NSMutableArray* _postKeys;
    NSMutableArray* _postContentTypes;
    NSMutableArray* _postDatas;
    NSMutableArray* _postFileNames;
    
    NSURLConnection *_connection;
}
@property (nonatomic,strong, readonly) NSURLConnection* connection; //发起请求的实例
@property (nonatomic,strong, readonly) NSURLResponse* response;
@property (nonatomic,weak) id<HTTPWorkerDelegate> delegate;
@property (nonatomic,strong) NSString* method; //GET or POST, default = POST
@property (nonatomic,strong) NSString* baseUrl;
@property (nonatomic,strong) NSDictionary* parameters;
@property (nonatomic,assign) NSTimeInterval timeoutInterval; //default = 20s

@property (nonatomic,weak) id weakInfo; //主要是用于保存manager的delegate
@property (nonatomic,assign) NSInteger integerInfo; //自定义信息，当前保存请求类型id
@property (nonatomic,assign) NSInteger integerInfo2; //自定义信息，当前用于保存请求次数
@property (nonatomic,assign) NSInteger integerInfo3; //自定义信息，当前用于保存地址分类信息
@property (nonatomic,strong) id userInfo;

@property (nonatomic,strong) NSString* stringInfo; //自定义信息，当前用于mta接口上报

-(instancetype)initWithBaseUrl:(NSString*)urlString parameters:(NSDictionary*)parameters delegate:(id<HTTPWorkerDelegate>)delegate_;

-(void)requestAsync:(NSOperationQueue*)workingQueue;

-(void)cancelRequest;

-(void)multipartPartAddData:(NSData*)data contentType:(NSString*)contentType fileName:(NSString*)fileName forKey:(NSString*)key;

@end
