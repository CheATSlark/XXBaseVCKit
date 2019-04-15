//
//  HTTPInterfaceManager+NewGifts.m
//  Xiuxiu
//
//  Created by FaDeve on 2017/11/25.
//  Copyright © 2017年 yangdeger@gmail.com. All rights reserved.
//

#import "HTTPInterfaceManager+NewGifts.h"

@implementation HTTPInterfaceManager (NewGifts)

-(id)fetchNewGiftsListUserInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XINewGiftsList parameters:final_params userInfo:nil];
}

@end
