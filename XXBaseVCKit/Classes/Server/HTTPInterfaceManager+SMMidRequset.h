//
//  HTTPInterfaceManager+SMMidRequset.h
//  aiai
//
//  Created by FaDeve on 2019/4/1.
//  Copyright © 2019 yangdeger@gmail.com. All rights reserved.
//

#import "HTTPInterfaceManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface HTTPInterfaceManager (SMMidRequset)

-(id)postMidSettingConfig:(NSDictionary *)settingDic;

-(id)fetchVoiceListPage:(int)page userInfo:(NSDictionary *)userInfo;

-(id)deleteVoiceSig;
@end

NS_ASSUME_NONNULL_END
