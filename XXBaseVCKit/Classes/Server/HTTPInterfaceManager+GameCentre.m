//
//  HTTPInterfaceManager+GameCentre.m
//  Xiuxiu
//
//  Created by FaDeve on 2017/11/27.
//  Copyright © 2017年 yangdeger@gmail.com. All rights reserved.
//

#import "HTTPInterfaceManager+GameCentre.h"

@implementation HTTPInterfaceManager (GameCentre)

-(id)fetchGameCentre:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIGameCentre parameters:final_params userInfo:nil];
}

-(id)fetchGameIconCovertList:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIGameConvertList parameters:final_params userInfo:nil];
}

-(id)buyMemberShip:(int)combo_id userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"combo_id":@(combo_id)};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIGameCovertAction parameters:final_params userInfo:nil];
}

-(id)beanExchangeIcon:(int)beanNum userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"sm_coin_amount":@(beanNum),@"game_category":@"game_lobby"};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIBeanExchangeIcon parameters:final_params userInfo:nil];
}

-(id)fetchCovertHistory:(int)page userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"page":@(page),@"limit":@(15)};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIGameCovertHistory parameters:final_params userInfo:nil];
}
@end
