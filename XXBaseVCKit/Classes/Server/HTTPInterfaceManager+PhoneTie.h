//
//  HTTPInterfaceManager+PhoneTie.h
//  Xiuxiu
//
//  Created by FaDeve on 16/4/18.
//  Copyright © 2016年 yangdeger@gmail.com. All rights reserved.
//

#import "HTTPInterfaceManager.h"

@interface HTTPInterfaceManager (PhoneTie)

-(id)tieToPhoneNumberWithPhoneNumber:(NSString *)phoneNum captcha:(NSString *)captcha userInfo:(NSDictionary *)userInfo;

-(id)modifyPhoneNumberWithPhoneNumber:(NSString *)phoneNum password:(NSString *)password captcha:(NSString *)captcha userInfo:(NSDictionary *)userInfo;

-(id)getCode:(int)type phoneNumber:(NSString *)phoneNum userInfo:(NSDictionary *)userInfo;
@end
