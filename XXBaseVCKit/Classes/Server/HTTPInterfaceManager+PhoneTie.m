//
//  HTTPInterfaceManager+PhoneTie.m
//  Xiuxiu
//
//  Created by FaDeve on 16/4/18.
//  Copyright © 2016年 yangdeger@gmail.com. All rights reserved.
//

#import "HTTPInterfaceManager+PhoneTie.h"

@implementation HTTPInterfaceManager (PhoneTie)

-(id)getCode:(int)type phoneNumber:(NSString *)phoneNum userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"phone_num":phoneNum,
                           @"type":@(type)};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIGetCaptcha parameters:final_params userInfo:userInfo];
}

-(id)tieToPhoneNumberWithPhoneNumber:(NSString *)phoneNum captcha:(NSString *)captcha userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"phone_num":phoneNum,
                           @"captcha":captcha};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIPhoneTie parameters:final_params userInfo:userInfo];
}

-(id)modifyPhoneNumberWithPhoneNumber:(NSString *)phoneNum password:(NSString *)password captcha:(NSString *)captcha userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"phone_num":phoneNum,
                           @"captcha":captcha,
                           @"password":password};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIModifyPhone parameters:final_params userInfo:userInfo];
}

@end
