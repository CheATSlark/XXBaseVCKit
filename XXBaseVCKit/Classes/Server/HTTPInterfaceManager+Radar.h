//
//  HTTPInterfaceManager+Radar.h
//  Xiuxiu
//
//  Created by FaDeve on 16/3/8.
//  Copyright © 2016年 yangdeger@gmail.com. All rights reserved.
//

#import "HTTPInterfaceManager.h"

@interface HTTPInterfaceManager (Radar)

-(id)sendTagDetailInfo:(NSDictionary *)tag_info userInfo:(NSDictionary *)userInfo;

-(id)openRadarByDeviceInfo:(NSDictionary *)device_info userInfo:(NSDictionary *)userInfo;

-(id)closeRadarUserInfo:(NSDictionary *)userInfo;


//v5.3 雷达改版新增
- (id)getRadarMoodsList:(NSDictionary *)info UserInfo:(NSDictionary *)userInfo;//获取约聊列表

- (id)sendRadarMoods:(NSDictionary *)info UserInfo:(NSDictionary *)userInfo;//发布约聊

- (id)updateRadarMoodsSwitch:(NSDictionary *)info UserInfo:(NSDictionary *)userInfo;//更新约聊末世

- (id)updateRadarMoods:(NSDictionary *)info UserInfo:(NSDictionary *)userInfo;//更新约聊心情宣言

@end
