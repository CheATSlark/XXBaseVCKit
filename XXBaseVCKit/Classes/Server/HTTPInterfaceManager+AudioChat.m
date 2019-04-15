//
//  HTTPInterfaceManager+AudioChat.m
//  Xiuxiu
//
//  Created by FaDeve on 16/6/14.
//  Copyright © 2016年 yangdeger@gmail.com. All rights reserved.
//

#import "HTTPInterfaceManager+AudioChat.h"

@implementation HTTPInterfaceManager (AudioChat)

-(id)inviteAudioChatByAIAINumber:(NSString *)countNumber userInfo:(NSDictionary *)userInfo
{
    if (countNumber == nil || [countNumber isEqualToString:@""]) {
        return nil;
    }
    NSDictionary* dict = @{@"to_uid":countNumber};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIAudioChatInvite parameters:final_params userInfo:userInfo];
}

- (id)inviteAudioOrVideoChatByDic:(NSDictionary *)dic UserInfo:(NSDictionary *)userInfo {
    if (dic == nil || dic.count == 0) {
        return nil;
    }
    
    NSDictionary* params = [self addCommomParameters:dic];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIInviteAudioOrVideo parameters:final_params userInfo:userInfo];
    
}

-(id)startAudioChatByChatterInfo:(NSDictionary *)chatter userInfo:(NSDictionary *)userInfo
{
    NSDictionary* params = [self addCommomParameters:chatter];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIDidiCallStart parameters:final_params userInfo:userInfo];
}


-(id)endAudioChatByChatterInfo:(NSDictionary *)chatter userInfo:(NSDictionary *)userInfo
{
    NSDictionary* params = [self addCommomParameters:chatter];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIDidiCallEnd parameters:final_params userInfo:userInfo];
}

-(id)getAudioChatBalanceByUserInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = userInfo;
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIDidiFetchBalance parameters:final_params userInfo:userInfo];
}

-(id)setChatPrcieByPrice:(int)price Info:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"price":@(price)};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIChatPrice parameters:final_params userInfo:userInfo];
}

-(id)fetchOrderDetailByID:(NSString *)order_id userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"order_id":order_id};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIAudioOrderDetail parameters:final_params userInfo:userInfo];
}

-(id)getSocialBalanceByCallType:(int)callType userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"call_type":@(callType)};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XISocailChatBalance parameters:final_params userInfo:userInfo];
}

@end
