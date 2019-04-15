//
//  HTTPInterfaceManager+SMRequest.m
//  aiai
//
//  Created by FaDeve on 2019/3/10.
//  Copyright © 2019 yangdeger@gmail.com. All rights reserved.
//

#import "HTTPInterfaceManager+SMRequest.h"

@implementation HTTPInterfaceManager (SMRequest)

-(id)fetchChatRecommand:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:SMChatRecommand parameters:final_params userInfo:nil];
}

-(id)getActivityImageUrl:(int)type userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"type":@(type)};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:SMActivityImg parameters:final_params userInfo:nil];
}

-(id)fetchInviteUserInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:SMInviteInfo parameters:final_params userInfo:nil];
}

@end
