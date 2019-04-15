//
//  HTTPInterfaceManager+IDPhoto.m
//  Xiuxiu
//
//  Created by FaDeve on 16/4/16.
//  Copyright © 2016年 yangdeger@gmail.com. All rights reserved.
//

#import "HTTPInterfaceManager+IDPhoto.h"
#import "HTTPWorker.h"
#import "HTTPInterfaceAddress.h"

@implementation HTTPInterfaceManager (IDPhoto)

-(id)getIDPhotoStatusWithUserInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIIDPhotoStatus parameters:final_params userInfo:userInfo];
}

-(id)uploadPhoto:(NSData *)photoData userInfo:(NSDictionary *)userInfo
{
    
    NSDictionary* dict = @{};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params needPercentEscape:NO];
    NSDictionary* final_params = @{@"data":json_value};
    
    NSString* suffix = nil;
    NSString* urlStr = [HTTPInterfaceAddress interfaceAddressWithID:XIFeedComposePictures suffix:&suffix];
    HTTPWorker* worker = [[HTTPWorker alloc] initWithBaseUrl:urlStr parameters:final_params delegate:self];
    [worker multipartPartAddData:photoData contentType:@"image/jpeg" fileName:@"user_avatar.png" forKey:@"new_0"];
    
    worker.integerInfo = XIFeedComposePictures;
    worker.userInfo = userInfo;
    worker.stringInfo = suffix;
    [worker requestAsync:_workingQueue];
    [_workers addObject:worker];
    return worker;
}

-(id)submitIDPhotoUrl:(NSString *)url UserInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"photo_src":url};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIIDPhotoSubmit parameters:final_params userInfo:userInfo];
}

-(id)deleleIDPhotoWithUserInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIIDPhotoDelete parameters:final_params userInfo:userInfo];
}

@end
