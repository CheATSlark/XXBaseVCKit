//
//  HTTPInterfaceManager+DidiFunction.m
//  Xiuxiu
//
//  Created by FaDeve on 2017/9/18.
//  Copyright © 2017年 yangdeger@gmail.com. All rights reserved.
//

#import "HTTPInterfaceManager+DidiFunction.h"

@implementation HTTPInterfaceManager (DidiFunction)

-(id)fetchDidiConfigWithUserInfo:(NSDictionary *)userInfo;

{
    NSDictionary* dict = @{};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIDidiConfig parameters:final_params userInfo:userInfo];
}

-(id)fetchDidiSettingStateInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIDidiSetting parameters:final_params userInfo:userInfo];
}

-(id)grapDidiInfo:(NSDictionary *)didiInfo userInfo:(NSDictionary *)userInfo
{
    NSDictionary* params = [self addCommomParameters:didiInfo];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIDidiGrap parameters:final_params userInfo:userInfo];
}

-(id)getFreeMutualFunsCount
{
    NSDictionary* dict = @{};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIDidiFreeFllow parameters:final_params userInfo:nil];
}

-(id)creatDidiBillInfo:(NSDictionary *)didiInfo userInfo:(NSDictionary *)userInfo
{
    NSDictionary* params = [self addCommomParameters:didiInfo];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIDidiCreate parameters:final_params userInfo:userInfo];
}

-(id)changeSwitchStatueByOnOff:(int)isOn OnType:(int)type userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"business_type":@(type),@"switch_value":@(isOn)};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIDidiUserSwitch parameters:final_params userInfo:userInfo];
}

-(id)getJudgeInfoByOrdeId:(NSString *)order userInfo:(NSDictionary *)userInfo
{
    NSDictionary *dict = @{@"order_no":order};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIDidiJudgeInfo parameters:final_params userInfo:userInfo];
}

-(id)publicCommentsInfo:(NSDictionary *)commentInfo userInfo:(NSDictionary *)userInfo
{
    NSDictionary* params = [self addCommomParameters:commentInfo];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIDidiComment parameters:final_params userInfo:userInfo];
}

-(id)closeBillChatByChatInfo:(NSDictionary *)chatInfo userInfo:(NSDictionary *)userInfo
{
    NSDictionary* params = [self addCommomParameters:chatInfo];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIDidiNumCallEnd parameters:final_params userInfo:userInfo];
}
@end
