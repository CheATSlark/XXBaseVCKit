//
//  HTTPInterfaceManager+Video.h
//  Xiuxiu
//
//  Created by FaDeve on 2017/3/1.
//  Copyright © 2017年 yangdeger@gmail.com. All rights reserved.
//

#import "HTTPInterfaceManager.h"

@interface HTTPInterfaceManager (Video)

-(id)inviteVideoChatByAIAI:(NSString *)aiai_num userInfo:(NSDictionary *)userInfo;

-(id)endVideoChatByInfo:(NSDictionary *)chatInfo userInfo:(NSDictionary *)userInfo;


-(id)startFreeCallByInfo:(NSDictionary *)callInfo userInfo:(NSDictionary *)userInfo;

-(id)endFreeCallByInfo:(NSDictionary *)callInfo userInfo:(NSDictionary *)userInfo;

@end
