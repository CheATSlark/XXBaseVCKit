//
//  HTTPInterfaceManager+SMRequest.h
//  aiai
//
//  Created by FaDeve on 2019/3/10.
//  Copyright © 2019 yangdeger@gmail.com. All rights reserved.
//

#import "HTTPInterfaceManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface HTTPInterfaceManager (SMRequest)

-(id)fetchChatRecommand:(NSDictionary *)userInfo;

-(id)getActivityImageUrl:(int)type userInfo:(NSDictionary *)userInfo;


-(id)fetchInviteUserInfo:(NSDictionary *)userInfo;
@end

NS_ASSUME_NONNULL_END
