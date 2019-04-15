//
//  HTTPInterfaceManager+InvitePlay.m
//  Xiuxiu
//
//  Created by xiaoaiai on 2017/2/22.
//  Copyright © 2017年 yangdeger@gmail.com. All rights reserved.
//

#import "HTTPInterfaceManager+InvitePlay.h"

@implementation HTTPInterfaceManager (InvitePlay)

- (id)fetchInvitePlayUsers:(int)limit Page:(int)page {
    NSDictionary *param = [self addCommomParameters:@{@"page":@(page),@"limit":@(limit)}];
    NSString *json_value = [self genPackedJsonStringWithParameters:param];
    NSDictionary *final_value = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIInvitePlayList parameters:final_value userInfo:nil];
}

@end
