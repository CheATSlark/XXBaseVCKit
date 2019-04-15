//
//  HTTPInterfaceManager+ChatRoom.h
//  Xiuxiu
//
//  Created by Mac on 15/12/24.
//  Copyright © 2015年 yangdeger@gmail.com. All rights reserved.
//

#import "HTTPInterfaceManager.h"

@interface HTTPInterfaceManager (ChatRoom)

-(id)getChatRoomListWithUserInfo:(id)userInfo;

-(id)markChatRoomActive:(NSString*)room_id userInfo:(id)userInfo;

-(id)leaveChatRoom:(NSString*)room_id userInfo:(id)userInfo;

@end
