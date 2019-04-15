//
//  HTTPInterfaceManager+DidiFunction.h
//  Xiuxiu
//
//  Created by FaDeve on 2017/9/18.
//  Copyright © 2017年 yangdeger@gmail.com. All rights reserved.
//

#import "HTTPInterfaceManager.h"

@interface HTTPInterfaceManager (DidiFunction)

-(id)fetchDidiConfigWithUserInfo:(NSDictionary *)userInfo;

-(id)fetchDidiSettingStateInfo:(NSDictionary *)userInfo;

-(id)grapDidiInfo:(NSDictionary *)didiInfo userInfo:(NSDictionary *)userInfo;

-(id)getFreeMutualFunsCount;

-(id)creatDidiBillInfo:(NSDictionary *)didiInfo userInfo:(NSDictionary *)userInfo;

-(id)changeSwitchStatueByOnOff:(int)isOn OnType:(int)type userInfo:(NSDictionary *)userInfo;

-(id)getJudgeInfoByOrdeId:(NSString *)order userInfo:(NSDictionary *)userInfo;

-(id)publicCommentsInfo:(NSDictionary *)commentInfo userInfo:(NSDictionary *)userInfo;

-(id)closeBillChatByChatInfo:(NSDictionary *)chatInfo userInfo:(NSDictionary *)userInfo;
@end
