//
//  HTTPInterfaceManager+AudioChat.h
//  Xiuxiu
//
//  Created by FaDeve on 16/6/14.
//  Copyright © 2016年 yangdeger@gmail.com. All rights reserved.
//

#import "HTTPInterfaceManager.h"

@interface HTTPInterfaceManager (AudioChat)

-(id)inviteAudioChatByAIAINumber:(NSString *)countNumber userInfo:(NSDictionary *)userInfo;

-(id)startAudioChatByChatterInfo:(NSDictionary *)chatter userInfo:(NSDictionary *)userInfo;

-(id)endAudioChatByChatterInfo:(NSDictionary *)chatter userInfo:(NSDictionary *)userInfo;

-(id)getAudioChatBalanceByUserInfo:(NSDictionary *)userInfo;

-(id)setChatPrcieByPrice:(int)price Info:(NSDictionary *)userInfo;

-(id)fetchOrderDetailByID:(NSString *)order_id userInfo:(NSDictionary *)userInfo;

- (id)inviteAudioOrVideoChatByDic:(NSDictionary *)dic UserInfo:(NSDictionary *)userInfo;

-(id)getSocialBalanceByCallType:(int)callType userInfo:(NSDictionary *)userInfo;
@end
