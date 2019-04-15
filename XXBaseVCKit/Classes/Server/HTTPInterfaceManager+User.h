//
//  HTTPInterfaceManager+User.h
//  Xiuxiu
//
//  Created by Mac on 15/4/2.
//  Copyright (c) 2015年 yangdeger@gmail.com. All rights reserved.
//

#import "HTTPInterfaceManager.h"


/**
 extend for User Module
 **/
@interface HTTPInterfaceManager (User)

/**
 * 修改用户密码
 **/
-(id)updateNewPassword:(NSString*)password oldPassword:(NSString*)old_password userInfo:(NSDictionary*)userInfo;


/**
 * 修改用户个人信息
 * 
 * @param information 个人信息，可以只传某个key-value对。比如，只修改昵称就只需要传递nickName
 */
-(id)updateUserInfomation:(NSDictionary*)information userInfo:(NSDictionary*)userInfo;


-(id)updateSMUserInfo:(NSDictionary *)information userInfo:(NSDictionary *)userInfo;
/**
 * 修改用户个人信息
 *
 * @param information 个人信息，可以只传某个key-value对。比如，只修改昵称就只需要传递nickName
 */
-(id)updateUserInfomation:(NSDictionary*)information userInfo:(NSDictionary*)userInfo noTk:(BOOL)flag;

/**
 * 变更用户状态
 *
 */
-(id)changeUserStatus:(int)status userInfo:(NSDictionary*)userInfo;

/**
 * 获取绑定设备的列表
 *
 */
//-(id)getBindDevicesListWithDelegate:(id<HTTPInterfaceManagerDelegate>)delegate_ userInfo:(NSDictionary*)userInfo MethodDeprecated("has removed");


/**
 * 绑定设备
 *
 */
-(id)bindDeviceWithDeviceMac:(NSString*)mac deviceType:(NSString*)type deviceName:(NSString*)name userInfo:(NSDictionary*)userInfo;


/**
 * 解绑设备
 *
 */
//-(id)unbindDeviceWithDeviceMac:(NSString*)mac deviceType:(NSString*)type delegate:(id<HTTPInterfaceManagerDelegate>)delegate_ userInfo:(NSDictionary*)userInfo MethodDeprecated("has removed");

/**
 * 设备断开连接
 **/
-(id)deviceDisconnectWithDeviceMac:(NSString*)mac userInfo:(NSDictionary*)userInfo;

/**
 * 更改用户头像
 **/
-(id)uploadAvatarWithPicList:(NSString*)picList modifyPicIds:(NSArray*)picIds datas:(NSArray*)datas userInfo:(NSDictionary*)userInfo;



/**
 * 通过aiaiNum获取某个用户（包括自己）的用户信息
 **/
-(id)getUserinfoWithAiaiNum:(NSString*)aiaiNum userinfo:(NSDictionary*)userInfo;

/**
 *通过模糊搜索获取用户信息
 */
-(id)getUserInfoWithString:(NSString *)str page:(int)page limit:(int)lit userinfo:(NSDictionary *)userInfo;


/**
 * 获取（发现）用户列表
 **/
-(id)getUserListWithGender:(NSString*)gender page:(int)page userInfo:(NSDictionary*)userInfo;


-(id)zanUserWithAiaiNum:(NSString*)aiaiNum userInfo:(NSDictionary*)userInfo;

/**
 * 关注
 **/
-(id)followUserWithAiaiNum:(NSString*)aiaiNum userInfo:(NSDictionary*)userInfo;

/**
 * 取消关注
 **/
-(id)unfollowUserWithAiaiNum:(NSString*)aiaiNum userInfo:(NSDictionary*)userInfo;

/**
 * 拉黑
 **/
-(id)blockUserWithAiaiNum:(NSString*)aiaiNum userInfo:(NSDictionary*)userInfo;
/**
 * 举报
 **/
-(id)reportUserWithAiaiNum:(NSString*)aiaiNum reason:(NSString*)reason userInfo:(NSDictionary*)userInfo;
/**
 * 举报+拉黑
 **/
-(id)reportAndBlockUserWithAiaiNum:(NSString*)aiaiNum reason:(NSString*)reason userInfo:(NSDictionary*)userInfo;

/**
 * 反拉黑
 **/
-(id)unbanUserWithAiaiNum:(NSString*)aiaiNum userInfo:(NSDictionary*)userInfo;

/**
 * 根据aiaiNum获取一批用户信息
 * 不同aiaiNum之间用逗号','分割
 **/
-(id)getBatchUserInfoWithAiaiNumbers:(NSString*)aiaiNums userInfo:(NSDictionary*)userInfo;

/**
 * 获取到用户的关注列表
 **/
-(id)getUserFollowListWithPage:(int)page  userinfo:(NSDictionary*)userInfo;

-(id)getUserFollowListWithPage:(int)page searchWord:(NSString *)word userinfo:(NSDictionary *)userInfo;
/**
 * 获取到用户的粉丝（即谁关注了当前用户）的列表
 **/
-(id)getUserFansListWithPage:(int)page  userInfo:(NSDictionary*)userInfo;

/**
 * 获取用户获赞（即谁赞了当前用户）的列表
 **/
-(id)getUserPraisedListWithPage:(int)page  userInfo:(NSDictionary*)userInfo;

/**
 * 获取用户拉黑列表（即用户拉黑）的列表
 **/
-(id)getUserBanListWithPage:(int)page searchWord:(NSString *)word userInfo:(NSDictionary *)userInfo;


/**
 * 修改用户隐身状态
 **/
-(id)setUserInvisiableState:(int)state userInfo:(NSDictionary*)userInfo;

/**
 * 获取到用户的全部访客列表
 **/
-(id)getUserVisitorListWithPage:(int)page userInfo:(NSDictionary*)userInfo;
/**
 * 获取到榜单列表
 **/
-(id)getRankTypeList:(int)gender userInfo:(NSDictionary*)userInfo;
/**
 * 获取到具体榜单数据
 **/
-(id)getRankData:(int)rid page:(int)page userInfo:(NSDictionary*)userInfo;
/**
 * 获取每日签到相关
 **/
-(id)getSigninInformations:(NSDictionary*)userInfo;
/**
 * 进行签到
 **/
-(id)doSigninWithActivityId:(int)aid dateString:(NSString*)dateStr userInfo:(NSDictionary*)userInfo;
/**
 * 上传语音签名
 **/
-(id)uploadVoiceSignature:(NSData*)voiceData duration:(int)duration userInfo:(NSDictionary*)userInfo;
/**
 * 删除语音签名
 **/
-(id)removeVoiceSingatureWithUserInfo:(NSDictionary*)userInfo;
/**
 * app反馈
 **/
-(id)feedbackInformations:(NSDictionary *)feedback userInfo:(NSDictionary *)userInfo;

/**
 * 获取ID照片墙信息
 **/
- (id)getIDWallPhotoListWithPage:(NSInteger)page Limit:(NSInteger)limit Tag:(int)tag Time:(NSString *)time Score:(NSString *)scroe userInfo:(NSDictionary *)userInfo;

-(id)getSMIDWallPhotoWithParams:(NSDictionary *)par userInfo:(NSDictionary *)userInfo;
///获取用户权限和服务信息
- (id)getUserPermissionAndService;

- (id)getUserComboPermissionList;

- (id)buyUserPermission:(int)combo_id;//购买套餐

- (id)getHadBuyLit;//购买过的记录

- (id)getUserMissionAndLevel;//获取用户任务内容和等级;

-(id)setAudioChatSwitchByOn:(int)on;    //设置语音开关

-(id)changeVideoChatSwitch:(int)status userInfo:(NSDictionary *)userInfo;  //设置视频通话开关

-(id)pushExpression:(int)face_pack_id express:(int)img_id;
//获取昵称列表

- (id)getUserRemarkList;
//更新昵称
- (id)updateUserRemarkFromAiAiNum:(NSString *)fromAiAiNum ToAiAiNum:(NSString *)toAiAiNum RemarkName:(NSString *)remarkName;
//获取我的页面的活动之类的信息
- (id)fetchUserSettingInfo;

- (id)submitReportWithContent:(NSString *)content ClassId:(NSInteger)classId PicPaths:(NSArray *)picPaths AiaiNum:(NSString *)aiaiNum;

- (id)postCallReport:(NSDictionary *)call_info;
@end
