//
//  HTTPInterfaceManager+Video.m
//  Xiuxiu
//
//  Created by FaDeve on 2017/3/1.
//  Copyright © 2017年 yangdeger@gmail.com. All rights reserved.
//

#import "HTTPInterfaceManager+Video.h"

@implementation HTTPInterfaceManager (Video)

-(id)inviteVideoChatByAIAI:(NSString *)aiai_num userInfo:(NSDictionary *)userInfo
{
    if (aiai_num == nil || [aiai_num isEqualToString:@""]) {
        return nil;
    }
    NSDictionary *dic = @{@"to_uid":aiai_num};
    NSDictionary* params = [self addCommomParameters:dic];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIVideoChatInvite parameters:final_params userInfo:userInfo];
}

-(id)endVideoChatByInfo:(NSDictionary *)chatInfo userInfo:(NSDictionary *)userInfo
{
    NSDictionary* params = [self addCommomParameters:chatInfo];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIDidiCallEnd parameters:final_params userInfo:userInfo];
}

-(id)startFreeCallByInfo:(NSDictionary *)callInfo userInfo:(NSDictionary *)userInfo
{
    NSDictionary* params = [self addCommomParameters:callInfo];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XICallFreeStart parameters:final_params userInfo:userInfo];
}

-(id)endFreeCallByInfo:(NSDictionary *)callInfo userInfo:(NSDictionary *)userInfo{
    NSDictionary* params = [self addCommomParameters:callInfo];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XICallFreeEnd parameters:final_params userInfo:userInfo];
}
@end
