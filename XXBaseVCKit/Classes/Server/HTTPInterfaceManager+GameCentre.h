//
//  HTTPInterfaceManager+GameCentre.h
//  Xiuxiu
//
//  Created by FaDeve on 2017/11/27.
//  Copyright © 2017年 yangdeger@gmail.com. All rights reserved.
//

#import "HTTPInterfaceManager.h"

@interface HTTPInterfaceManager (GameCentre)

-(id)fetchGameCentre:(NSDictionary *)userInfo;

-(id)fetchGameIconCovertList:(NSDictionary *)userInfo;

-(id)buyMemberShip:(int)combo_id userInfo:(NSDictionary *)userInfo;

-(id)beanExchangeIcon:(int)beanNum userInfo:(NSDictionary *)userInfo;

-(id)fetchCovertHistory:(int)page userInfo:(NSDictionary *)userInfo;
@end
