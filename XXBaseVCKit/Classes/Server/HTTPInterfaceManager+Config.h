//
//  HTTPInterfaceManager+Config.h
//  Xiuxiu
//
//  Created by Mac on 15/7/3.
//  Copyright (c) 2015年 yangdeger@gmail.com. All rights reserved.
//

#import "HTTPInterfaceManager.h"

/**
 * Extend for configuation fetch
 *
 */
@interface HTTPInterfaceManager (Config)

/**
 * 全局配置接口，应该在app启动时候拉取
 * 
 * @param userInfo 透传信息
 * @return 请求
 */
-(id)getConfigWithUserInfo:(NSDictionary *)userInfo;


-(id)getConnectionIpAddressWithInfo:(NSDictionary *)userInfo;

-(id)getControlRecordWithOffset:(int)offset userInfo:(NSDictionary*)userInfo;

-(id)deleteSingleControlRecord:(int)recordId userInfo:(NSDictionary*)userInfo;

-(id)deleteAllControlRecordWithUserInfo:(NSDictionary*)userInfo;

@end
