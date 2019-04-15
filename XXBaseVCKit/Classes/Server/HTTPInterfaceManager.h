//
//  HTTPInterfaceManager.h
//  Xiuxiu
//
//  Created by Mac on 15/3/10.
//  Copyright (c) 2015年 yangdeger@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(uint32_t, XXInterfaceId)
{
    XICustomUrl,
    XIGetTicket,
    XIGetToken,
    XIGetTicket3rd,
    XIGetToken3rd,
    XIRefreshToken,
    XIGetUserInfo,
    XIGetUserInfoByAiaiNum,
    XIGetBatchUserInfoByAiaiNum, //批量获取用户信息
    XIUserLogin,
    XIUserLogout,
    XIDownloadAvatar,
    XIUploadAvatar,
    XIFindPassword,
    XIChangePasswordViaPhone, //根据手机号码修改密码
    XIGetCaptcha,
    XIUserRegisterViaPhone, //根据手机号码注册
    XIUserRegister,
    XIUserChangeStatus,
    XIUserModifyInfo,
    XIUserModifyPassword,
    XICheckNewVersion,
    XIShopLogin, //商店登录
    XI3rdRegister,
    XI3rdLogin,  //第三方登录
    XIBindDevice, //绑定设备
    XIUnbindDevice, //解绑设备
    XIDisconnectDevice, //设备断开链接
    XIGetBindedDeviceList, //绑定设备列表
    XICheckHXUser, //鉴定是否环信用户（若不是 ，则后台负责弄成是
    XIGetUserList, //获取用户列表（发现界面）
    XIZanUser,  //赞
    XIFollowUser, //关注
    XIUnFollowUser, //取消关注
    XIBanUser, //拉黑
    XIReportUser, //举报
    XIReportAndBlockUser, //举报并拉黑
    XIUnbanUser, //取消拉黑
    XIGetMyFollowList, //获取本用户关注列表
    XIGetMyFansList, //获取本用户的粉丝列表
    XIGetMyPraisedList, //获取本用户获赞列表
    XIGetMyVisitorList, //获取本用户访客列表
    XIUserModifyInvisiable, //设置隐身
    XIGetMyBlockList, //获取用户的拉黑名单（该用户拉黑了谁）
    XIGetConfig,
    XIGetConnectionAddr, //获取ip地址列表
    XIGetControlRecord, //获取控制信息
    XIDeleteSingleControlRecord, //删除单条控制记录
    XIDeleteAllControlRecord, //删除全部控制记录
    XIFeedTopicList, //feed话题列表
    XIFeedCompose, //feed发表动态
    XIFeedComposePictures, //feed（发表时）上传图片
    XIFeedDelete, //feed删除一条记录
    XIFeedDetail, //feed获取单条详情
    XIFeedCommentList, //feed获取评论列表
    XIFeedDoComment, //feed进行评论
    XIFeedDeleteComment, //feed删除评论
    XIFeedReport, //feed举报一条记录
    XIFeedReportComment, //feed举报一条评论
    XIFeedAlert, //feed新消息提醒
    XIFeedPraise, //feed赞一条记录
    XIFeedListFixed, //feed获取固定列表的内容
    XIFeedListCustom, //feed获取指定话题或指定人物的内容
    XIFeedComposeComment, //feed进行评论或评论回复
    XIFeedPraiseList, //feed点赞某个feed的列表
    XIFeedTipsNum, //feed获取新消息个数
    XIFeedAdConfig, //feed 广告配置
    XIFeedAllTipsList, // feed 全部提醒
    XIFeedClearAllTips, // 删除所有提醒
    XIFeedDeleteOneTips, // 删除单条提醒
    XIFeedListStickToNorth, //feed个人置顶
    XIAdminFeedRecommend, // 管理员推荐feed
    XIAdminFreezeAccount, //管理员封账号
    XIAdminFeedTop,  //管理员feed置顶
    XIAdminFeedUndoTop,  //管理员feed取消置顶
    XIAdminFreezeFeed,  //管理员封feed
    XIAdminFreezeFeedComment, //管理员封feed评论
    XIPushTokenUpload, //上报jpush和device token
    XIRankTypeList, //榜单类型列表
    XIRankData, //榜单具体数据
    XIGiftExchangeList, //礼物兑换记录
    XIGiftExchangeMakeOrder, //生成兑换订单
    SMGiftExchangeMakeOrder,
    XIGiftAccountList, //礼物收入赠送列表
    XIGiftListByAiaiNum, //根据aiai号获取可(赠送)礼物列表
    XIGiftExchangeInfo, //获取兑换相关信息
    XIGiftSendPresentOrder, //赠送礼物
    XIGiftExchangeOrderDetail, //订单详情
    XISigninInfos, //每日签到信息
    XISigninAction, //进行签到
    XIGiftPublicshList, //送礼公告列表
    XIGiftAddValueConfig, //充值项目配置
    XIGiftAddValueList, //充值订单列表
    XIGiftAddValueMakeOrder, //生成充值订单
    XIGiftAddValueValidTransaction, //验证appstore支付订单
    SMAddMemberVaildTransaction, // 购买会员套餐
    XIUploadVoiceSignature, //上传语音签名
    XIRemoveVoiceSignature, //删除语音签名
    XIChatGroupList, //群组列表
    XIChatGroupInfos, //群组信息
    XIChatGroupApply, //群组申请加入
    XIChatGroupDealApply, //群组处理申请
    XIChatGroupApplyList, //群组申请列表
    XIChatGroupUpdateInfos, //更新群组信息
    XIChatGroupMemberList, //群组成员列表
    XIChatGroupMsgSetting, //群组消息设置
    XIChatGroupUpdateAnnouncement, //群组更新公告
    XIChatGroupKick, //群组踢人
    XIChatGroupBlackAndKick, //群组拉黑及踢人
    XIChatGroupLeave, //群组退出
    XIChatGroupCancelApply, //群组取消申请
    XIChatGroupInfoViaHx, //环信id获取群组信息
    XIChatGroupRecommendList, //群组推荐列表
    XIChatGroupCategoryList, //群组分类列表
    XIChatGroupJoinedList, //已加入群组列表
    XIChatGroupOffical,  //官方群组
    XIChatRoomList,  //聊天室获取到聊天室列表
    XIChatRoomMarkActive, //聊天室标记活跃
    XIChatRoomLeaved, //聊天室退出
    XIRedPacketUpload, //上传微信礼包
    XIRedPacketRecordList, //红包记录列表
    XIRedPacketInfo,    //获取红包信息
    XIRedPacketKnock,   //抢红包
    XIRedPointInfo, //红点信息,取代XIFeedTipsNum
    XIRadarTagInfo,     //雷达标签搜索
    XIRadarOpen,        //打开雷达
    XIRadarClose,       //关闭雷达
    XIFeedback,         //反馈

    XIGetIDWallList,  //获取id照片墙

    XIIDPhotoStatus,   //获取ID照审核状态
    XIIDPhotoSubmit,    //提交ID照片
    XIIDPhotoDelete,     //删除ID照

    XIDiscoverMineMoments,//我的圈子数据
    XIDiscoverRecommondMoments,//推荐的圈子
    
    XIDiscoverTopicList,//所有圈子右边列表
    XIDiscoverTopicClassList,//所有圈子 左边列表
    XIDiscoverFocusTopic,//关注圈子
    XIDiscoverCancelFocusTopic,//取消关注圈子

    XIRadarMoodList,//约聊列表
    XIRadarAddMoods,//发布约聊
    XIRadarUpdateMoods,//更新约聊末世的开关
    XIRadarUpdateMoodsFeeling,//更新约聊心情宣言

    XIPhoneTie,         //绑定手机
    XIModifyPhone,      //更换手机号
    
    XIAudioChatInvite,  //邀请语音聊天
    XIAudioChatStart,   //开始聊天
    XIAudioChatEnd,     //结束聊天
    XIAudioChatBalance,     //获取余额
    XIAudioSetSwith,    //设置语音开关
    
    XIChatPrice,    //设置通话计费
    
    XIGetUserPermission, //获取用户权限服务之类的
    XIGetUserComboPermissionList,//获取套餐列表
    XIBuyUserPermission,//购买套餐
    XIGetHadBuyList,//已经买过的套餐记录
    XIGetUserLevel,//获取用户的任务。等级之类的
    
    XIFilterTopicList,//过滤无权限话题列表
    XICheckAddFeed,//能不能发布的权限

    
    XISubmitFeedback,//提交新的反馈
    XIFeedbackList,//反馈记录列表
    XIFeedbackDetail,//反馈记录详情
    XIFeedbackComment,//增加反馈评论
    
    XIGetGroupBlackList,    //获取群组拉黑列表
    XICancelGroupBlack,     //取消拉黑群成员

    
    XIAddExchangeAccount,//添加账户
    XIDelExchangeAccount,//删除账户
    XIUpdateExchangeAccount,//更新账户
    XIGetAccountList,//获取账户列表
    XICancelExcOrder,


    
    XIAddManager,       // 在群组添加管理员
    XIRemoveManager,    // 移除管理员
    
    XIInviteJoinGroup,  //邀请加入聊天群组
    XIAcceptJoinGroup,  //接受邀请加入群组
    
    XIGetFacePacket,    //获取聊天动图
    XIUpExpressionl,    //上传动图的选择
    XINewSearch,    //新的搜索
    
    XIFaceViewList,//表情包下载列表
    XIFaceManagerList,//我的表情包管理列表

    XISortFaceViewList,//排序表情包
    XIDeleteFaceView,//删除表情包

    XIFacePackageDown, //下载表情包

    XIHotTalkRecommend, //热门话题推荐列表
    XIHotTalkList,      //热门话题列表
    
    XIWishPoolList,//许愿池
    XIWishPrizeList,//那三个许愿开奖
    
    XIWishPrizeListAll,//许愿开奖全部内容列表
    XIWishPrizeDetial,//获取奖品详情
    XIOrderList,//许愿树其他人的列表
    XIMyWishList,//我的许愿表单
    XIHisPrizeList,//历史开奖
    XIMyWishRecList,//我的许愿记录
    XIMyDrawRecList,//我的中奖纪录
    XICheckWishBuy,//检测购买数量是否够
    XIPrizeAdressList,//领奖地址管理
    XIPrizeAdressAdd,//增加地址管理
    XIPrizeAdressUpdate,//更新地址
    XIPrizeAdressDelete,//删除地址
    XIDefaultAddress,//获取默认地址
    XIConfirmPrize,//确认领奖
    XIDrawedPrize,//已经领过奖
    XICreateWishOrder,//下单
    
    XICoinConfig,//获取圈圈豆和经验
    XISendSpecialGift,  //在群组里分发特殊的礼物
    XISpecialGiftInfo,    //选取特殊礼物
    XIGrabSpecialGift,      //抢特殊礼物
    XISpecialGiftList,      //特殊红包列表

    
    XIInvitePlayList,//邀请越跳的 横向滚动列表

    
    XIVideoChatSwitch,  //视频开关
    XIVideoChatInvite,  //发起视频通话
    XIVideoChatEnd,     //结束视频通话
    
    XIGetUserRemarkList,//获取用户昵称列表
    XIUpdateRemarkName,//更新用户昵称
    

    XIChatGroupSearch,  //群组模糊搜索
    XIChatGroupClassSearch,  //特定类别下的群组搜索
    
    //v6.3 获取七牛token
    XIGetQiniuToken,
    XIGetQnVoiceToken,
    XIDeleteVoice,
    
    //获取小视频列表
    XIGetShortVideoList,
    XIGetShortVideoDetail,
    XIGetMyShortVideoList,
    XIBanUserList,      //拉黑列表
    XIAllCircleList,    //所有圈子列表
    XIRecommandCircle,  //推荐圈子
    //获取赠送礼物列表
    XIFetchSendGiftList,
    
    XIGetShortVideoMusicList,   //获取小视频音乐列表
    XIAudioOrderDetail,         //获取语音通话账单
    XIDeleteShortVideo,    //删除视频
    
    //v6.4
    XIDidiConfig,       //获取didi功能的配置信息
    XIDidiGrap,         //didi接单请求
    XIDidiFreeFllow,    //didi免费互粉次数
    XIDidiComment,      //didi评价发表
    XIDidiJudgeInfo,  //didi待评价信息
    XIDidiSetting,      //didi设置界面
    XIDidiUserSwitch,   //didi开关设置
    XIDidiCallStart,    //didi通话开始
    XIDidiCallEnd,      //didi通话结束
    XIDidiFetchBalance,    //didi余额查询
    XIDidiCreate,          //didi创建订单
    XIGetSettingConf, //设我的页面配置的那些活动之类的信息
    XICallReport, //通话上报
    
    XICallFreeStart,    //免费通话开始
    XICallFreeEnd,      //免费通话结束
    XIInviteAudioOrVideo, // 免费语音或者视频
    XIDidiNumCallEnd,      //关闭通话

    //v6.4.2 获取不走回调的七牛token
    XIGetOSSQiniuToken,
    XISubmitReportMsg,//提交举报

    
    XIMarketCategory,   //商品分类
    XIMarketList,       //商品列表
    XIMarketDetail,     //商品详情
    XIMarketOrder,      //商品订单，未购买
    XIMarketPay,        //商品付款
    XIMarketBuyList,    //商品付款列表
    XIMarketOrderInfo,  //商品订单详情，已购买
    
    XISocailChatBalance,    //计费通话余额查询
    XINewGiftsList,        //礼物列表
    XIGameCentre,          //游戏大厅
    XIGameConvertList,      //游戏兑换中心
    XIGameCovertAction,     //游戏币买会员
    XIGameCovertHistory,    //游戏币兑换历史
    XIBeanExchangeIcon,     //圈圈豆换游戏币

    XIMarketItemsList,  //商品列表
    XIMarketItemDetail, //商品详情
    XIMarketCartList,   //购物车列表
    XIMarketAddCart,    //添加到购物车
    XIMarketModifyCart, //修改购物车
    XIMarketPushBill,   //确认订单
    XIMarketCreateOrder,  //生成订单
    XIMarketSearchBill,    //各种订单
    XIMarketBillInfo,   // 订单详情
    XIMarketBillPay,
    XIMarketRecieve,  //确认收货
    XIMarketUser,     //商城个人中心
    
    SMUserCompeletInfo, // 完善个人信息
    SMUserCertify,  // 用户认证
    SMUserList,   // 用户列表
    SMChatRecommand, //推荐
    SMActivityImg, // 获取相关图片
    SMInviteInfo, // 邀请奖励信息
    SMExchange, // 兑换
    
    SMMidSettingConfig, // 通话状态
    SMVoiceList,  //
};



@protocol HTTPInterfaceManagerDelegate <NSObject>
-(void)interface:(XXInterfaceId)interfaceId successWithData:(NSData*)data userInfo:(NSDictionary*)userInfo;
/**
 * 错误回调
 * 
 * @param interfaceId 接口id
 * @param error 错误信息。error code为-2时表示服务器返回了超过400的HTTP代码。这时代码的值可以在userinfo的status字段中找到
 * @param userInfo 透传信息
 */
-(void)interface:(XXInterfaceId)interfaceId failWithError:(NSError*)error userInfo:(NSDictionary*)userInfo;

@end

@interface HTTPInterfaceManager : NSObject {
    NSOperationQueue* _workingQueue;
    NSMutableArray* _workers;
}
@property (nonatomic,weak) id<HTTPInterfaceManagerDelegate> delegate;
/**
 * 当请求出现网络问题时，自动重试的次数
 *
 * 将此参数设置为0可以禁用自动试
 */
@property (nonatomic,assign) int autoRetryTimes;


-(instancetype)initWithWorkingQueue:(NSOperationQueue*)queue;

/**
 * 将请求成功返回的数据解析为json对象，并根据json内容返回适当的数据。
 * 数据可能为result中的内容（请求成功），或整个包含错误的内容（请求失败）
 * @param response [IN] 请求结果数据
 * @param flag [OUT]  是否请求成功。
 * @return json对象
 */
-(NSDictionary*)commonParseResult:(NSData*)response success:(BOOL*)flag;

/**
 * 对请求增加公共参数
 *
 * 实际效果等同于-addCommomParameters:orgParams notToken:NO;
 * @param orgParams 不含有公共参数的请求参数
 * @return 添加公共参数后的参数
 */
-(NSDictionary*)addCommomParameters:(NSDictionary*)orgParams;

/**
 * 对请求增加公共参数
 * 
 * @param orgParams 不含有公共参数的请求参数
 * @param noToken 不加token这个参数。对于少数请求（如获取ticket，获取token等）必须设置为YES
 * @return 添加公共参数后的参数
 */
-(NSDictionary*)addCommomParameters:(NSDictionary *)orgParams notToken:(BOOL)noToken;


-(NSString*)genPackedJsonStringWithParameters:(NSDictionary*)params;

/**
 * 将字典内容构造成json字符串
 * 
 * @param params 待构造字典
 * @param encode 是否需要对返回值进行percentEscape
 */
-(NSString*)genPackedJsonStringWithParameters:(NSDictionary*)params needPercentEscape:(BOOL)encode;


-(id)sendRequestWithInterfaceId:(XXInterfaceId)iid parameters:(NSDictionary*)params userInfo:(NSDictionary*)userInfo;

-(id)sendRequestWithInterfaceId:(XXInterfaceId)iid parameters:(NSDictionary*)params timeout:(NSTimeInterval)timeout userInfo:(NSDictionary*)userInfo;


/**
 * 根据请求类型ID取消请求
 * 
 * 该请求必须是通过方法-(id)sendRequestWithInterfaceId: parameters: userInfo:进行发起的，否则
 * 通过其他方式添加到_worker数组中
 * @param iid 请求类型id
 */
-(void)cancelRequestWithInterfaceId:(XXInterfaceId)iid;

/**
 * 取消所有的在_workers中保存着的请求
 */
-(void)cancelAllRequests;



/**
 下述所有方法，当delegate不为nil时，为异步请求，结果通过delegate返回；当delegate为nil时，为同步请求，通过函数返回结果。
 此时，如果结果为NSData类型，表示请求正常，如果结果为NSError类型，表示请求异常或失败。
 **/
-(id)checkNewVersionWithUserInfo:(NSDictionary*)userInfo;

-(id)shopLoginWithUserinfo:(NSDictionary*)userInfo;

-(id)getCustomUrl:(NSString*)urlStr withDelegate:(id<HTTPInterfaceManagerDelegate>)delegate_ userinfo:(NSDictionary*)userInfo;


//+(NSString*)genUserAvatarUrlStringWithUserModel:(XXUserModel*)userModel;

@end
