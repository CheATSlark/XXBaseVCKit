//
//  HTTPInterfaceManager+ChatRoom.m
//  Xiuxiu
//
//  Created by Mac on 15/12/24.
//  Copyright © 2015年 yangdeger@gmail.com. All rights reserved.
//

#import "HTTPInterfaceManager+ChatRoom.h"

@implementation HTTPInterfaceManager (ChatRoom)

-(id)getChatRoomListWithUserInfo:(id)userInfo
{
    NSDictionary* dict = @{};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIChatRoomList parameters:final_params userInfo:userInfo];
}

-(id)markChatRoomActive:(NSString *)room_id userInfo:(id)userInfo
{
    NSDictionary* dict = @{@"chatroom_id":room_id};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIChatRoomMarkActive parameters:final_params userInfo:userInfo];
}

-(id)leaveChatRoom:(NSString *)room_id userInfo:(id)userInfo
{
    NSDictionary* dict = @{@"chatroom_id":room_id};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIChatRoomLeaved parameters:final_params userInfo:userInfo];
}

@end
