//
//  HTTPInterfaceManager+IDPhoto.h
//  Xiuxiu
//
//  Created by FaDeve on 16/4/16.
//  Copyright © 2016年 yangdeger@gmail.com. All rights reserved.
//

#import "HTTPInterfaceManager.h"

@interface HTTPInterfaceManager (IDPhoto)

-(id)getIDPhotoStatusWithUserInfo:(NSDictionary *)userInfo;

-(id)uploadPhoto:(NSData *)photoData userInfo:(NSDictionary *)userInfo;

-(id)submitIDPhotoUrl:(NSString *)url UserInfo:(NSDictionary *)userInfo;

-(id)deleleIDPhotoWithUserInfo:(NSDictionary *)userInfo;

@end
