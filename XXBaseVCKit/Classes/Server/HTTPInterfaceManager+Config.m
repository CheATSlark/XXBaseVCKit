//
//  HTTPInterfaceManager+Config.m
//  Xiuxiu
//
//  Created by Mac on 15/7/3.
//  Copyright (c) 2015年 yangdeger@gmail.com. All rights reserved.
//

#import "HTTPInterfaceManager+Config.h"
#import <sys/utsname.h>
#import "NSString+ExtraXX.h"

@implementation HTTPInterfaceManager (Config)

-(id)getConfigWithUserInfo:(NSDictionary *)userInfo
{
    CGRect rect_screen = [[UIScreen mainScreen]bounds];
    CGSize size_screen = rect_screen.size;
    CGFloat scale_screen = [UIScreen mainScreen].scale;
    NSDictionary* dict = @{@"client_device_brand":@"Apple",@"client_device_model":[NSString iPhoneTypeString],@"client_os_version":[UIDevice currentDevice].systemVersion,@"client_resolution":[NSString stringWithFormat:@"%.0fx%.0f",size_screen.height*scale_screen,size_screen.width*scale_screen]};
    NSDictionary* params = [self addCommomParameters:dict notToken:YES];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIGetConfig parameters:final_params userInfo:userInfo];
}

-(id)getConnectionIpAddressWithInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIGetConnectionAddr parameters:final_params userInfo:userInfo];
}


-(id)getControlRecordWithOffset:(int)offset userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"offset":@(offset)
                           ,@"limit":@(20)
                           };
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIGetControlRecord parameters:final_params userInfo:userInfo];
}

-(id)deleteSingleControlRecord:(int)recordId userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"id":@(recordId)};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIDeleteSingleControlRecord parameters:final_params userInfo:userInfo];
}

-(id)deleteAllControlRecordWithUserInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIDeleteAllControlRecord parameters:final_params userInfo:userInfo];
    return nil;
}
@end
