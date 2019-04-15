//
//  HTTPInterfaceManager+Login.m
//  Xiuxiu
//
//  Created by Mac on 15/3/19.
//  Copyright (c) 2015年 yangdeger@gmail.com. All rights reserved.
//

#import "HTTPInterfaceManager.h"
#import "HTTPInterfaceManager+Account.h"
#import "IPSelector.h"

@implementation HTTPInterfaceManager (Account)

-(id)getTicketWithUserName:(NSString *)userName password:(NSString *)password userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"username":userName,
                           @"password":password};
    NSDictionary* params = [self addCommomParameters:dict notToken:YES];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIGetTicket parameters:final_params userInfo:userInfo];
}

- (id)getTokenWithTicket:(NSString *)ticket userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"code":ticket};
    NSDictionary* params = [self addCommomParameters:dict notToken:YES];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIGetToken parameters:final_params userInfo:userInfo];
}

-(id)refreshTokenWithUserInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIRefreshToken parameters:final_params userInfo:userInfo];
}

-(id)logoutWithUserInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIUserLogout parameters:final_params userInfo:userInfo];
}

-(id)registerWithUserName:(NSString *)userName password:(NSString *)password userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"username":userName,
                           @"password":password};
    NSDictionary* params = [self addCommomParameters:dict notToken:YES];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIUserRegister parameters:final_params userInfo:userInfo];
}



-(id)getAccountInformationsWithUserInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIGetUserInfo parameters:final_params userInfo:userInfo];
}

-(id)thirdRegisterLoginWithAccountInfos:(NSDictionary *)account_info userInfo:(NSDictionary *)userInfo
{
    NSString* age = account_info[@"age"];
    if ([age length] == 0) {
        age = @"18";
    }
//    unionid
    
    id unionid = [account_info objectForKey:@"unionid"];
    NSDictionary* dict = nil;
    if (unionid == nil) {
        dict = @{
                 @"openToken":[account_info objectForKey:@"openToken"],
                 @"openId": [account_info objectForKey:@"openId"],
                 @"platType": [account_info objectForKey:@"platType"],
                 @"faceUrl": [account_info objectForKey:@"faceUrl"],
                 @"nickName": [account_info objectForKey:@"nickName"],
                 @"gender": [account_info objectForKey:@"gender"],
                 @"age":age};
    } else {
        dict = @{
                 @"openToken":[account_info objectForKey:@"openToken"],
                 @"openId": [account_info objectForKey:@"openId"],
                 @"platType": [account_info objectForKey:@"platType"],
                 @"faceUrl": [account_info objectForKey:@"faceUrl"],
                 @"nickName": [account_info objectForKey:@"nickName"],
                 @"gender": [account_info objectForKey:@"gender"],
                 @"age":age,
                 @"unionid":unionid};
    }
    
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIGetToken3rd parameters:final_params userInfo:userInfo];
}

-(id)thirdGetTicketWithOpenId:(NSString *)open_id platform:(NSString *)platform userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"openid":open_id,
                           @"plattype":platform};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIGetTicket3rd parameters:final_params userInfo:userInfo];
}

-(id)checkHxUserWithAiaiNumber:(NSString *)aiaiNum userinfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"uid":aiaiNum};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XICheckHXUser parameters:final_params userInfo:userInfo];
}

#pragma mark - phone x password

-(id)findPasswordWithUserName:(NSString *)userName userinfo:(NSDictionary *)userInfo
{
    //XIFindPassword
    NSDictionary* dict = @{@"email":userName};
    NSDictionary* params = [self addCommomParameters:dict notToken:YES];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIFindPassword parameters:final_params userInfo:userInfo];
}

-(id)changePasswordWithPhoneNumber:(NSString *)phoneNum captcha:(NSString *)captcha password:(NSString *)password userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"phone_num":phoneNum,
                           @"captcha":captcha,
                           @"password":password};
    NSDictionary* params = [self addCommomParameters:dict notToken:YES];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIChangePasswordViaPhone parameters:final_params userInfo:userInfo];
}

-(id)getCaptchaCode:(int)type phoneNumber:(NSString *)phoneNum userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"phone_num":phoneNum,
                           @"type":@(type)};
    NSDictionary* params = [self addCommomParameters:dict notToken:YES];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIGetCaptcha parameters:final_params userInfo:userInfo];
}

-(id)registerWithPhoneNumber:(NSString *)phoneNum password:(NSString *)password captcha:(NSString *)captcha userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"phone_num":phoneNum,
                           @"captcha":captcha,
                           @"password":password,
                           @"smType":[userInfo objectForKey:@"smType"]
                           };
    NSDictionary* params = [self addCommomParameters:dict notToken:YES];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIUserRegisterViaPhone parameters:final_params userInfo:userInfo];
}

-(id)uploadPushId:(NSString *)registId deviceToken:(NSString *)dt userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"register_id":registId,
                           @"device_token":dt};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIPushTokenUpload parameters:final_params userInfo:userInfo];
}

- (id)fetchCoinConfig {
    NSDictionary* dict = @{};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XICoinConfig parameters:final_params userInfo:@{}];
}

@end
