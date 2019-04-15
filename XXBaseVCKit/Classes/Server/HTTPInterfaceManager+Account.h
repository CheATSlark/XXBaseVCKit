//
//  HTTPInterfaceManager+Login.h
//  Xiuxiu
//
//  Created by Mac on 15/3/19.
//  Copyright (c) 2015年 yangdeger@gmail.com. All rights reserved.
//

#import "HTTPInterfaceManager.h"

/**
 extend for Account Module
 **/
@interface HTTPInterfaceManager (Account)

/**
 * 通过用户名和密码获取到用于取得token的一次性ticket
   其中密码(password)需要经过加盐MD5处理
 */
-(id)getTicketWithUserName:(NSString*)userName password:(NSString*)password userInfo:(NSDictionary*)userInfo;

/**
 * 通过ticket获得用于表示唯一用户的token
 */
-(id)getTokenWithTicket:(NSString*)ticket userInfo:(NSDictionary*)userInfo;

/**
 * 刷新已经获得的token(续期
 */
-(id)refreshTokenWithUserInfo:(NSDictionary*) userInfo;


/**
 * 用户登出
 * 使用token进行用户标示，无需传递其他参数
 */
-(id)logoutWithUserInfo:(NSDictionary*)userInfo;


/**
 * 获取用户相关信息
 * 使用token进行用户标示，无需传递其他参数
 */
-(id)getAccountInformationsWithUserInfo:(NSDictionary*)userInfo;


/**
 * 用户注册
 * 其中密码(password)需要经过加盐MD5处理
 */
-(id)registerWithUserName:(NSString*)userName password:(NSString*)password userInfo:(NSDictionary*)userInfo;

/**
   第三方账号注册
 **/
-(id)thirdRegisterLoginWithAccountInfos:(NSDictionary *)account_info userInfo:(NSDictionary *)userInfo;

-(id)thirdGetTicketWithOpenId:(NSString*)open_id platform:(NSString*)platform userInfo:(NSDictionary*)userInfo;

/**
 * 环信侧用户注册/登录
 **/
-(id)checkHxUserWithAiaiNumber:(NSString*)aiaiNum userinfo:(NSDictionary*)userInfo;


/**
 * 获取短信验证码
 * 
 * @param type 1，注册 2.忘记密码
 * @param userInfo 透传
 */
-(id)getCaptchaCode:(int)type phoneNumber:(NSString*)phoneNum userInfo:(NSDictionary*)userInfo;


/**
 * 用户注册（通过手机号码）
 * 
 * @param phoneNum 注册手机号码
 * @param password 密码，加盐MD5
 * @param captcha 验证码
 * @param userInfo 透传
 */
-(id)registerWithPhoneNumber:(NSString*)phoneNum password:(NSString*)password captcha:(NSString*)captcha userInfo:(NSDictionary*)userInfo;


/**
 * 找回用户密码
 **/
-(id)findPasswordWithUserName:(NSString*)userName userinfo:(NSDictionary*)userInfo;

/**
 * 通过短信直接修改密码
 * 
 * @param phoneNum 电话号码
 * @param captcha 验证码
 * @param password 密码，加盐MD5
 * @param userInfo 透传
 */
-(id)changePasswordWithPhoneNumber:(NSString*)phoneNum captcha:(NSString*)captcha password:(NSString*)password userInfo:(NSDictionary*)userInfo;

/**
 * 将推送相关的信息上报服务器
 * 
 * @param registId jpush id
 * @param dt apple device token
 * @param userInfo 透传
 */
-(id)uploadPushId:(NSString*)registId deviceToken:(NSString*)dt userInfo:(NSDictionary*)userInfo;

- (id)fetchCoinConfig;

@end
