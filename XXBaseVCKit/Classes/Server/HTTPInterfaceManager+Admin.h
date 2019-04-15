//
//  HTTPInterfaceManager+Admin.h
//  Xiuxiu
//
//  Created by Mac on 15/10/20.
//  Copyright © 2015年 yangdeger@gmail.com. All rights reserved.
//

#import "HTTPInterfaceManager.h"
//#import "Config.h"

@interface HTTPInterfaceManager (Admin)

#ifdef ADMIN_VER

-(id)adminFreezeAccount:(int)aiai_num type:(int)type;

-(id)adminRecommendFeed:(int32_t)fid;

-(id)adminTopFeed:(int32_t)fid type:(int32_t)type;

-(id)adminCancelTopFeed:(int32_t)fid type:(int32_t)type;

-(id)adminFreezeFeed:(int32_t)fid;

-(id)adminFreezeFeedComment:(int32_t)cid;

#endif

@end
