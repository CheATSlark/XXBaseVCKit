//
//  HTTPInterfaceManager+Radar.m
//  Xiuxiu
//
//  Created by FaDeve on 16/3/8.
//  Copyright © 2016年 yangdeger@gmail.com. All rights reserved.
//

#import "HTTPInterfaceManager+Radar.h"

@implementation HTTPInterfaceManager (Radar)

-(id)sendTagDetailInfo:(NSDictionary *)tag_info userInfo:(NSDictionary *)userInfo
{
    NSDictionary* params = [self addCommomParameters:tag_info];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIRadarTagInfo parameters:final_params userInfo:userInfo];
    
}

-(id)openRadarByDeviceInfo:(NSDictionary *)device_info userInfo:(NSDictionary *)userInfo
{
    NSDictionary* params = [self addCommomParameters:device_info];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIRadarOpen parameters:final_params userInfo:userInfo];
}

-(id)closeRadarUserInfo:(NSDictionary *)userInfo
{
    NSDictionary* params = [self addCommomParameters:nil];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIRadarClose parameters:final_params userInfo:userInfo];
}

- (id)getRadarMoodsList:(NSDictionary *)info UserInfo:(NSDictionary *)userInfo {
    NSDictionary* params = [self addCommomParameters:info];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:SMUserList parameters:final_params userInfo:userInfo];
}

- (id)updateRadarMoods:(NSDictionary *)info UserInfo:(NSDictionary *)userInfo {
    NSDictionary* params = [self addCommomParameters:info];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIRadarUpdateMoodsFeeling parameters:final_params userInfo:userInfo];
}

- (id)updateRadarMoodsSwitch:(NSDictionary *)info UserInfo:(NSDictionary *)userInfo {
    NSDictionary* params = [self addCommomParameters:info];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIRadarUpdateMoods parameters:final_params userInfo:userInfo];
}
//
//- (id)sendRadarMoods:(NSDictionary *)info UserInfo:(NSDictionary *)userInfo {
//
//}

@end
