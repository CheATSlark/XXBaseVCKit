//
//  HTTPInterfaceManager+SMMidRequset.m
//  aiai
//
//  Created by FaDeve on 2019/4/1.
//  Copyright © 2019 yangdeger@gmail.com. All rights reserved.
//

#import "HTTPInterfaceManager+SMMidRequset.h"

@implementation HTTPInterfaceManager (SMMidRequset)

-(id)postMidSettingConfig:(NSDictionary *)settingDic{
    NSDictionary* dict = settingDic;
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:SMMidSettingConfig parameters:final_params userInfo:nil];
}

-(id)fetchVoiceListPage:(int)page userInfo:(NSDictionary *)userInfo{
    NSDictionary* dict = @{@"page":@(page),@"limit":@(20)};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:SMVoiceList parameters:final_params userInfo:nil];
}

-(id)deleteVoiceSig{
    NSDictionary* dict = @{};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIDeleteVoice parameters:final_params userInfo:nil];
}
@end
