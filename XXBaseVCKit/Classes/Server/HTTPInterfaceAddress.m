//
//  HTTPInterfaceAddress.m
//  Xiuxiu
//
//  Created by Mac on 15/6/27.
//  Copyright (c) 2015年 yangdeger@gmail.com. All rights reserved.
//

#import "HTTPInterfaceAddress.h"
#import "IPSelector.h"

@interface HTTPInterfaceAddress()
@property (nonatomic,strong) NSMutableDictionary* idSuffixMap;
@end

@implementation HTTPInterfaceAddress

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.idSuffixMap = [[NSMutableDictionary alloc] init];
        [_idSuffixMap setObject:@"checkVer" forKey:@(XICheckNewVersion)];
        [_idSuffixMap setObject:@"user/loginshop" forKey:@(XIShopLogin)];
        [_idSuffixMap setObject:@"auth/getcode" forKey:@(XIGetTicket)];
        [_idSuffixMap setObject:@"auth/gettoken" forKey:@(XIGetToken)];
        [_idSuffixMap setObject:@"auth/refreshtoken" forKey:@(XIRefreshToken)];
        [_idSuffixMap setObject:@"user/logout" forKey:@(XIUserLogout)];
        [_idSuffixMap setObject:@"user/register" forKey:@(XIUserRegister)];
        [_idSuffixMap setObject:@"user/getaccountinfo" forKey:@(XIGetUserInfo)];
        [_idSuffixMap setObject:@"auth/otherlogin" forKey:@(XIGetToken3rd)];
        [_idSuffixMap setObject:@"auth/getcode" forKey:@(XIGetTicket3rd)];
        [_idSuffixMap setObject:@"user/updatepwd" forKey:@(XIUserModifyPassword)];
        [_idSuffixMap setObject:@"user/updateaccountinfo" forKey:@(XIUserModifyInfo)];
        [_idSuffixMap setObject:@"user/changestate" forKey:@(XIUserChangeStatus)];
        [_idSuffixMap setObject:@"user/binddevices" forKey:@(XIBindDevice)];
        [_idSuffixMap setObject:@"user/unconnect" forKey:@(XIDisconnectDevice)];
        [_idSuffixMap setObject:@"user/uploadaccountpic" forKey:@(XIUploadAvatar)];
        [_idSuffixMap setObject:@"user/checkhxuser" forKey:@(XICheckHXUser)];
        [_idSuffixMap setObject:@"user/searchuser" forKey:@(XIGetUserInfoByAiaiNum)];
        [_idSuffixMap setObject:@"user/getonlinelist" forKey:@(XIGetUserList)];
        [_idSuffixMap setObject:@"user/praise" forKey:@(XIZanUser)];
        [_idSuffixMap setObject:@"user/follow" forKey:@(XIFollowUser)];
        [_idSuffixMap setObject:@"user/unfollow" forKey:@(XIUnFollowUser)];
        [_idSuffixMap setObject:@"user/blockuser" forKey:@(XIBanUser)];
        [_idSuffixMap setObject:@"user/reportonly" forKey:@(XIReportUser)];
        [_idSuffixMap setObject:@"user/report" forKey:@(XIReportAndBlockUser)];
        [_idSuffixMap setObject:@"user/unblockuser" forKey:@(XIUnbanUser)];
        [_idSuffixMap setObject:@"user/selectuser" forKey:@(XIGetBatchUserInfoByAiaiNum)];
        [_idSuffixMap setObject:@"user/followlist" forKey:@(XIGetMyFollowList)];
        [_idSuffixMap setObject:@"user/fanslist" forKey:@(XIGetMyFansList)];
        [_idSuffixMap setObject:@"user/praiselist" forKey:@(XIGetMyPraisedList)];
        [_idSuffixMap setObject:@"user/blocklist" forKey:@(XIGetMyBlockList)];
        [_idSuffixMap setObject:@"user/display" forKey:@(XIUserModifyInvisiable)];
        [_idSuffixMap setObject:@"user/findbackpwd" forKey:@(XIFindPassword)];
        [_idSuffixMap setObject:@"getconfig" forKey:@(XIGetConfig)];
        [_idSuffixMap setObject:@"conn/getconnaddr" forKey:@(XIGetConnectionAddr)];
        [_idSuffixMap setObject:@"conn/getconnlist" forKey:@(XIGetControlRecord)];
        [_idSuffixMap setObject:@"conn/delconn" forKey:@(XIDeleteSingleControlRecord)];
        [_idSuffixMap setObject:@"conn/delallconn" forKey:@(XIDeleteAllControlRecord)];
        //Feed
        [_idSuffixMap setObject:@"feeds/topic_list" forKey:@(XIFeedTopicList)];
        [_idSuffixMap setObject:@"feeds/del_feeds" forKey:@(XIFeedDelete)];
        [_idSuffixMap setObject:@"feeds/add_feed_like" forKey:@(XIFeedPraise)];
        [_idSuffixMap setObject:@"feeds/report" forKey:@(XIFeedReport)];
        [_idSuffixMap setObject:@"feeds/report" forKey:@(XIFeedReportComment)];
        [_idSuffixMap setObject:@"feeds/list" forKey:@(XIFeedListFixed)];
        [_idSuffixMap setObject:@"feeds/list" forKey:@(XIFeedListCustom)];
        [_idSuffixMap setObject:@"feeds/feeds_detail" forKey:@(XIFeedDetail)];
        [_idSuffixMap setObject:@"feeds/get_comment_list" forKey:@(XIFeedCommentList)];
        [_idSuffixMap setObject:@"feeds/add_comment" forKey:@(XIFeedComposeComment)];
        [_idSuffixMap setObject:@"feeds/del_comment" forKey:@(XIFeedDeleteComment)];
        [_idSuffixMap setObject:@"feeds/praise_user_list" forKey:@(XIFeedPraiseList)];
        [_idSuffixMap setObject:@"feeds/tips_num" forKey:@(XIFeedTipsNum)];
        [_idSuffixMap setObject:@"feeds/feed_ad_list" forKey:@(XIFeedAdConfig)];
        [_idSuffixMap setObject:@"feeds/tips_list" forKey:@(XIFeedAllTipsList)];
        [_idSuffixMap setObject:@"feeds/add_feeds" forKey:@(XIFeedCompose)];
        [_idSuffixMap setObject:@"feeds/upload" forKey:@(XIFeedComposePictures)];
        [_idSuffixMap setObject:@"feeds/tips_clear" forKey:@(XIFeedClearAllTips)];
        [_idSuffixMap setObject:@"feeds/tips_del" forKey:@(XIFeedDeleteOneTips)];
        [_idSuffixMap setObject:@"user/register_by_phone" forKey:@(XIUserRegisterViaPhone)];
        [_idSuffixMap setObject:@"captcha/send" forKey:@(XIGetCaptcha)];
        [_idSuffixMap setObject:@"user/findpwd_by_msg" forKey:@(XIChangePasswordViaPhone)];
        [_idSuffixMap setObject:@"user/get_visited_list" forKey:@(XIGetMyVisitorList)];
        [_idSuffixMap setObject:@"user/top_info" forKey:@(XIRankTypeList)];
        [_idSuffixMap setObject:@"user/top_list" forKey:@(XIRankData)];
        [_idSuffixMap setObject:@"jpush/relation" forKey:@(XIPushTokenUpload)];
        [_idSuffixMap setObject:@"feeds/tips_info" forKey:@(XIRedPointInfo)];
        [_idSuffixMap setObject:@"feeds/top_by_aiai_num" forKey:@(XIFeedListStickToNorth)];
        //Gift
        [_idSuffixMap setObject:@"shop/present_order_list" forKey:@(XIGiftAccountList)];
        [_idSuffixMap setObject:@"shop/exchange_list" forKey:@(XIGiftExchangeList)];
        [_idSuffixMap setObject:@"user/gift_list" forKey:@(XIGiftListByAiaiNum)];
        [_idSuffixMap setObject:@"user/get_exchange_info" forKey:@(XIGiftExchangeInfo)];
        [_idSuffixMap setObject:@"shop/exchange" forKey:@(XIGiftExchangeMakeOrder)];
        [_idSuffixMap setObject:@"shop/exchange_reward" forKey:@(SMGiftExchangeMakeOrder)];
        [_idSuffixMap setObject:@"shop/new_present_order" forKey:@(XIGiftSendPresentOrder)];
        [_idSuffixMap setObject:@"shop/exchange_order_detail" forKey:@(XIGiftExchangeOrderDetail)];
        [_idSuffixMap setObject:@"notice/list" forKey:@(XIGiftPublicshList)];
        [_idSuffixMap setObject:@"coin/conf" forKey:@(XIGiftAddValueConfig)];
        [_idSuffixMap setObject:@"coin/recharge_list" forKey:@(XIGiftAddValueList)];
        [_idSuffixMap setObject:@"coin/recharge" forKey:@(XIGiftAddValueMakeOrder)];
        [_idSuffixMap setObject:@"coin/recharge_iap" forKey:@(XIGiftAddValueValidTransaction)];
        [_idSuffixMap setObject:@"combo/buy_iap" forKey:@(SMAddMemberVaildTransaction)];
        //Signin
//        [_idSuffixMap setObject:@"activity/activity_list" forKey:@(XISigninInfos)];
        [_idSuffixMap setObject:@"task/user_sign_in" forKey:@(XISigninInfos)];
//        task/user_sign_in
        [_idSuffixMap setObject:@"activity/sign_in" forKey:@(XISigninAction)];
        //Voice Signature
        [_idSuffixMap setObject:@"user/upload_voice" forKey:@(XIUploadVoiceSignature)];
        [_idSuffixMap setObject:@"user/upload_voice" forKey:@(XIRemoveVoiceSignature)];
        //ChatGroup
        [_idSuffixMap setObject:@"group/list" forKey:@(XIChatGroupList)];
        [_idSuffixMap setObject:@"group/info" forKey:@(XIChatGroupInfos)];
        [_idSuffixMap setObject:@"group/join" forKey:@(XIChatGroupApply)];
        [_idSuffixMap setObject:@"group/cancel_join" forKey:@(XIChatGroupCancelApply)];
        [_idSuffixMap setObject:@"group/deal_join" forKey:@(XIChatGroupDealApply)];
        [_idSuffixMap setObject:@"group/member_list" forKey:@(XIChatGroupMemberList)];
        [_idSuffixMap setObject:@"group/update" forKey:@(XIChatGroupUpdateInfos)];
        [_idSuffixMap setObject:@"group/join_list" forKey:@(XIChatGroupApplyList)];
        [_idSuffixMap setObject:@"group/msg_setting" forKey:@(XIChatGroupMsgSetting)];
        [_idSuffixMap setObject:@"group/del_member" forKey:@(XIChatGroupKick)];
        [_idSuffixMap setObject:@"group/black_member" forKey:@(XIChatGroupBlackAndKick)];
        [_idSuffixMap setObject:@"group/quit" forKey:@(XIChatGroupLeave)];
        [_idSuffixMap setObject:@"group/info_by_hx" forKey:@(XIChatGroupInfoViaHx)];
        [_idSuffixMap setObject:@"group/modify_message" forKey:@(XIChatGroupUpdateAnnouncement)];
        [_idSuffixMap setObject:@"group/class" forKey:@(XIChatGroupCategoryList)];
        [_idSuffixMap setObject:@"group/recommend_list" forKey:@(XIChatGroupRecommendList)];
        [_idSuffixMap setObject:@"group/joined_list" forKey:@(XIChatGroupJoinedList)];
        [_idSuffixMap setObject:@"group/official_list" forKey:@(XIChatGroupOffical)];
        //ChatRoom
        [_idSuffixMap setObject:@"chatroom/list" forKey:@(XIChatRoomList)];
        [_idSuffixMap setObject:@"chatroom/user/activate" forKey:@(XIChatRoomMarkActive)];
        [_idSuffixMap setObject:@"chatroom/user/logout" forKey:@(XIChatRoomLeaved)];

        //hidden: admin
        [_idSuffixMap setObject:@"admin/block_account" forKey:@(XIAdminFreezeAccount)];
        [_idSuffixMap setObject:@"admin/recommend_feed" forKey:@(XIAdminFeedRecommend)];
        [_idSuffixMap setObject:@"admin/top_feed" forKey:@(XIAdminFeedTop)];
        [_idSuffixMap setObject:@"admin/cancel_top_feed" forKey:@(XIAdminFeedUndoTop)];
        [_idSuffixMap setObject:@"admin/frozen_feed" forKey:@(XIAdminFreezeFeed)];
        [_idSuffixMap setObject:@"admin/frozen_feed_comment" forKey:@(XIAdminFreezeFeedComment)];
        
        //redPacket
        [_idSuffixMap setObject:@"red/envelop" forKey:@(XIRedPacketUpload)];
        [_idSuffixMap setObject:@"red/get_list" forKey:@(XIRedPacketRecordList)];
        [_idSuffixMap setObject:@"red/info" forKey:@(XIRedPacketInfo)];
        [_idSuffixMap setObject:@"red/grab" forKey:@(XIRedPacketKnock)];
        
        //radar
        [_idSuffixMap setObject:@"radar/list" forKey:@(XIRadarTagInfo)];
        [_idSuffixMap setObject:@"radar/open" forKey:@(XIRadarOpen)];
        [_idSuffixMap setObject:@"radar/close" forKey:@(XIRadarClose)];
        
        [_idSuffixMap setObject:@"feedback" forKey:@(XIFeedback)];
        
        //idwall
        [_idSuffixMap setObject:@"accosted/recommendlist" forKey:@(XIGetIDWallList)];//获取id照片列表
        
        //IDPhoto
        [_idSuffixMap setObject:@"idphoto/status" forKey:@(XIIDPhotoStatus)];
        [_idSuffixMap setObject:@"idphoto/submit" forKey:@(XIIDPhotoSubmit)];
        [_idSuffixMap setObject:@"idphoto/delete" forKey:@(XIIDPhotoDelete)];

        //圈子
        [_idSuffixMap setObject:@"topic_list/followed" forKey:@(XIDiscoverMineMoments)];
        [_idSuffixMap setObject:@"topic_list/recommend" forKey:@(XIDiscoverRecommondMoments)];
        [_idSuffixMap setObject:@"feeds/topic_list" forKey:@(XIDiscoverTopicList)];
        [_idSuffixMap setObject:@"topic_list/class" forKey:@(XIDiscoverTopicClassList)];
        [_idSuffixMap setObject:@"topic_list/follow" forKey:@(XIDiscoverFocusTopic)];
        [_idSuffixMap setObject:@"topic_list/unfollow" forKey:@(XIDiscoverCancelFocusTopic)];

        //PhoneTie
        [_idSuffixMap setObject:@"user/email_bind_phone" forKey:@(XIPhoneTie)];
        [_idSuffixMap setObject:@"user/change_phonenum" forKey:@(XIModifyPhone)];
        
        //AudioChat
        [_idSuffixMap setObject:@"voice_call/invite" forKey:@(XIAudioChatInvite)];
        [_idSuffixMap setObject:@"voice_call/start" forKey:@(XIAudioChatStart)];
        [_idSuffixMap setObject:@"voice_call/end" forKey:@(XIAudioChatEnd)];
        [_idSuffixMap setObject:@"voice_call/balance" forKey:@(XIAudioChatBalance)];
        
        [_idSuffixMap setObject:@"voice_call/set_price" forKey:@(XIChatPrice)];
        [_idSuffixMap setObject:@"user/voice_call" forKey:@(XIAudioSetSwith)];
        
        //雷达v5.3改版新增
        [_idSuffixMap setObject:@"radar/moods_list" forKey:@(XIRadarMoodList)];
        [_idSuffixMap setObject:@"radar/add_moods" forKey:@(XIRadarAddMoods)];
        [_idSuffixMap setObject:@"radar/update_moods_switch" forKey:@(XIRadarUpdateMoods)];
        [_idSuffixMap setObject:@"radar/update_moods" forKey:@(XIRadarUpdateMoodsFeeling)];
        
        //用户权限
        [_idSuffixMap setObject:@"user/get_user_permission" forKey:@(XIGetUserPermission)];
        //套餐组合列表
        [_idSuffixMap setObject:@"combo/list" forKey:@(XIGetUserComboPermissionList)];
        //购买过的列表
        [_idSuffixMap setObject:@"combo/bought" forKey:@(XIGetHadBuyList)];
        //购买套餐
        [_idSuffixMap setObject:@"combo/buy" forKey:@(XIBuyUserPermission)];
        //用户任务
        [_idSuffixMap setObject:@"task/user_detail" forKey:@(XIGetUserLevel)];
        //5.4 获取过滤之后的列表
        [_idSuffixMap setObject:@"feeds/filter_topic_list" forKey:@(XIFilterTopicList)];
        [_idSuffixMap setObject:@"feeds/check_add_feeds" forKey:@(XICheckAddFeed)];

        //5.4 反馈相关XISubmitFeedback
        [_idSuffixMap setObject:@"newfeedback" forKey:@(XISubmitFeedback)];

        
        [_idSuffixMap setObject:@"group/blacklist" forKey:@(XIGetGroupBlackList)];
        [_idSuffixMap setObject:@"group/cancel_black" forKey:@(XICancelGroupBlack)];

        
        [_idSuffixMap setObject:@"newfeedback/list" forKey:@(XIFeedbackList)];
        [_idSuffixMap setObject:@"newfeedback/detail" forKey:@(XIFeedbackDetail)];
        [_idSuffixMap setObject:@"newfeedback/add_comment" forKey:@(XIFeedbackComment)];
        
        [_idSuffixMap setObject:@"exchange_account/list" forKey:@(XIGetAccountList)];
        [_idSuffixMap setObject:@"exchange_account/update" forKey:@(XIUpdateExchangeAccount)];
        [_idSuffixMap setObject:@"exchange_account/del" forKey:@(XIDelExchangeAccount)];
        [_idSuffixMap setObject:@"exchange_account/add" forKey:@(XIAddExchangeAccount)];
        [_idSuffixMap setObject:@"shop/cancel_exchange" forKey:@(XICancelExcOrder)];

        
        [_idSuffixMap setObject:@"group/add_manager" forKey:@(XIAddManager)];
        [_idSuffixMap setObject:@"group/remove_manager" forKey:@(XIRemoveManager)];
        
        [_idSuffixMap setObject:@"group/invite" forKey:@(XIInviteJoinGroup)];
        [_idSuffixMap setObject:@"group/join_from_invite" forKey:@(XIAcceptJoinGroup)];
        [_idSuffixMap setObject:@"face_pack/list" forKey:@(XIGetFacePacket)];
        [_idSuffixMap setObject:@"face_pack/use" forKey:@(XIUpExpressionl)];
        
        [_idSuffixMap setObject:@"user/new_searchuser" forKey:@(XINewSearch)];
        [_idSuffixMap setObject:@"face_pack_down/list" forKey:@(XIFaceViewList)];
        [_idSuffixMap setObject:@"my_face_pack_down/list" forKey:@(XIFaceManagerList)];
        [_idSuffixMap setObject:@"user_face_pack/sort" forKey:@(XISortFaceViewList)];
        [_idSuffixMap setObject:@"user_del_face_pack/list" forKey:@(XIDeleteFaceView)];
        
        [_idSuffixMap setObject:@"user_down_face_pack/list" forKey:@(XIFacePackageDown)];
        
        [_idSuffixMap setObject:@"topic/recommend" forKey:@(XIHotTalkRecommend)];
        [_idSuffixMap setObject:@"topic/list" forKey:@(XIHotTalkList)];
        [_idSuffixMap setObject:@"mall/wish/list" forKey:@(XIWishPoolList)];
        [_idSuffixMap setObject:@"mall/wish_lottery/top" forKey:@(XIWishPrizeList)];
        [_idSuffixMap setObject:@"mall/wish_lottery/list" forKey:@(XIWishPrizeListAll)];
        [_idSuffixMap setObject:@"mall/wish/detail" forKey:@(XIWishPrizeDetial)];
        [_idSuffixMap setObject:@"mall/order/list" forKey:@(XIOrderList)];
        [_idSuffixMap setObject:@"mall/code/mylist" forKey:@(XIMyWishList)];
        [_idSuffixMap setObject:@"mall/wish_lottery/history_list" forKey:@(XIHisPrizeList)];
        [_idSuffixMap setObject:@"mall/my_wish/list" forKey:@(XIMyWishRecList)];
        [_idSuffixMap setObject:@"mall/wish_buy/check" forKey:@(XICheckWishBuy)];
        [_idSuffixMap setObject:@"mall/addr/list" forKey:@(XIPrizeAdressList)];
        [_idSuffixMap setObject:@"mall/addr/opt" forKey:@(XIPrizeAdressDelete)];
        [_idSuffixMap setObject:@"mall/addr/opt" forKey:@(XIPrizeAdressUpdate)];
        [_idSuffixMap setObject:@"mall/addr/opt" forKey:@(XIPrizeAdressAdd)];
        [_idSuffixMap setObject:@"mall/addr/default" forKey:@(XIDefaultAddress)];
        [_idSuffixMap setObject:@"mall/award/add" forKey:@(XIConfirmPrize)];
        [_idSuffixMap setObject:@"mall/award/info" forKey:@(XIDrawedPrize)];
        [_idSuffixMap setObject:@"mall/order/create" forKey:@(XICreateWishOrder)];
        [_idSuffixMap setObject:@"mall/my_luttery/list" forKey:@(XIMyDrawRecList)];
        [_idSuffixMap setObject:@"game/coin/conf" forKey:@(XICoinConfig)];
        
        [_idSuffixMap setObject:@"red_packets/send" forKey:@(XISendSpecialGift)];
        [_idSuffixMap setObject:@"red_packets/info" forKey:@(XISpecialGiftInfo)];
        [_idSuffixMap setObject:@"red_packets/grab" forKey:@(XIGrabSpecialGift)];
        [_idSuffixMap setObject:@"red_packets/get_list" forKey:@(XISpecialGiftList)];

        [_idSuffixMap setObject:@"atj/doyen/list" forKey:@(XIInvitePlayList)];

        
        [_idSuffixMap setObject:@"user/video_switch" forKey:@(XIVideoChatSwitch)];
        [_idSuffixMap setObject:@"video_call/invite" forKey:@(XIVideoChatInvite)];
        [_idSuffixMap setObject:@"video_call/end" forKey:@(XIVideoChatEnd)];
        
        [_idSuffixMap setObject:@"user/remark_list" forKey:@(XIGetUserRemarkList)];
        [_idSuffixMap setObject:@"user/update_remark" forKey:@(XIUpdateRemarkName)];

        [_idSuffixMap setObject:@"group/search" forKey:@(XIChatGroupSearch)];
        [_idSuffixMap setObject:@"group/search_by_class" forKey:@(XIChatGroupClassSearch)];
        
        [_idSuffixMap setObject:@"video/token" forKey:@(XIGetQiniuToken)];
        [_idSuffixMap setObject:@"voice/token" forKey:@(XIGetQnVoiceToken)];
        [_idSuffixMap setObject:@"user/remove_voice" forKey:@(XIDeleteVoice)];
        
        [_idSuffixMap setObject:@"user/video_update" forKey:@(XIDeleteShortVideo)];
        
        [_idSuffixMap setObject:@"user/video_list" forKey:@(XIGetShortVideoList)];
        [_idSuffixMap setObject:@"video/detail" forKey:@(XIGetShortVideoDetail)];
        [_idSuffixMap setObject:@"user/my_video" forKey:@(XIGetMyShortVideoList)];
        
        [_idSuffixMap setObject:@"user/blocklist" forKey:@(XIBanUserList)];
    
        [_idSuffixMap setObject:@"topic/main/list" forKey:@(XIAllCircleList)];
        [_idSuffixMap setObject:@"topic/main/recommend/list" forKey:@(XIRecommandCircle)];
        [_idSuffixMap setObject:@"video/present_gift/list" forKey:@(XIFetchSendGiftList)];
        
        [_idSuffixMap setObject:@"static_file/list" forKey:@(XIGetShortVideoMusicList)];
        [_idSuffixMap setObject:@"voice_call/settlement_order_detail" forKey:@(XIAudioOrderDetail)];
        
        // didiFunction
        [_idSuffixMap setObject:@"didi/config" forKey:@(XIDidiConfig)];
        [_idSuffixMap setObject:@"didi/order/grap" forKey:@(XIDidiGrap)];
        [_idSuffixMap setObject:@"didi/follow/free" forKey:@(XIDidiFreeFllow)];
        [_idSuffixMap setObject:@"didi/comment/add" forKey:@(XIDidiComment)];
        [_idSuffixMap setObject:@"didi/comment/wait" forKey:@(XIDidiJudgeInfo)];
        [_idSuffixMap setObject:@"didi/comment/set" forKey:@(XIDidiSetting)];
        [_idSuffixMap setObject:@"didi/user/switch" forKey:@(XIDidiUserSwitch)];
        [_idSuffixMap setObject:@"didi/call/start" forKey:@(XIDidiCallStart)];
        [_idSuffixMap setObject:@"didi/call/end" forKey:@(XIDidiCallEnd)];
        [_idSuffixMap setObject:@"didi/call/balance" forKey:@(XIDidiFetchBalance)];
        [_idSuffixMap setObject:@"didi/order/create" forKey:@(XIDidiCreate)];
        [_idSuffixMap setObject:@"uc/get_conf" forKey:@(XIGetSettingConf)];
        [_idSuffixMap setObject:@"call/report" forKey:@(XICallReport)];
        
        [_idSuffixMap setObject:@"social/call/start" forKey:@(XICallFreeStart)];
        [_idSuffixMap setObject:@"social/call/end" forKey:@(XICallFreeEnd)];
        [_idSuffixMap setObject:@"social/call/invite" forKey:@(XIInviteAudioOrVideo)];
        [_idSuffixMap setObject:@"call/close" forKey:@(XIDidiNumCallEnd)];

        [_idSuffixMap setObject:@"oss/upload/get_token" forKey:@(XIGetOSSQiniuToken)];
        [_idSuffixMap setObject:@"user/report/add" forKey:@(XISubmitReportMsg)];

        
        [_idSuffixMap setObject:@"goods/category" forKey:@(XIMarketCategory)];
        [_idSuffixMap setObject:@"mall/wish/list" forKey:@(XIMarketList)];
        [_idSuffixMap setObject:@"mall/wish/detail" forKey:@(XIMarketDetail)];
        [_idSuffixMap setObject:@"order/confirm" forKey:@(XIMarketOrder)];
        [_idSuffixMap setObject:@"order/payment" forKey:@(XIMarketPay)];
        [_idSuffixMap setObject:@"order/buy/list" forKey:@(XIMarketBuyList)];
        [_idSuffixMap setObject:@"order/info" forKey:@(XIMarketOrderInfo)];
     
        [_idSuffixMap setObject:@"social/call/balance" forKey:@(XISocailChatBalance)];
        [_idSuffixMap setObject:@"gift/main/list" forKey:@(XINewGiftsList)];
        [_idSuffixMap setObject:@"game/get_lobby_info" forKey:@(XIGameCentre)];
        [_idSuffixMap setObject:@"game/coin/combo_list" forKey:@(XIGameConvertList)];
        [_idSuffixMap setObject:@"game/coin/user_buy_combo" forKey:@(XIGameCovertAction)];
        [_idSuffixMap setObject:@"game/coin/bought_combo_list" forKey:@(XIGameCovertHistory)];
        [_idSuffixMap setObject:@"game/coin/recharge" forKey:@(XIBeanExchangeIcon)];

        [_idSuffixMap setObject:@"mall/goods/list" forKey:@(XIMarketItemsList)];
        [_idSuffixMap setObject:@"mall/goods/detail" forKey:@(XIMarketItemDetail)];
        [_idSuffixMap setObject:@"mall/cart/list" forKey:@(XIMarketCartList)];
        [_idSuffixMap setObject:@"mall/cart/add" forKey:@(XIMarketAddCart)];
        [_idSuffixMap setObject:@"mall/cart/modify" forKey:@(XIMarketModifyCart)];
        [_idSuffixMap setObject:@"mall/order/confirm_mall_order" forKey:@(XIMarketPushBill)];
        [_idSuffixMap setObject:@"mall/order/create_order" forKey:@(XIMarketCreateOrder)];
        [_idSuffixMap setObject:@"mall/order/order_list" forKey:@(XIMarketSearchBill)];
        [_idSuffixMap setObject:@"mall/order/order_info" forKey:@(XIMarketBillInfo)];
        [_idSuffixMap setObject:@"mall/order/pay_order" forKey:@(XIMarketBillPay)];
        [_idSuffixMap setObject:@"mall/order/update_order_info" forKey:@(XIMarketRecieve)];
        [_idSuffixMap setObject:@"mall/user_profile" forKey:@(XIMarketUser)];
        
        [_idSuffixMap setObject:@"user/completeaccountinfo" forKey:@(SMUserCompeletInfo)];
        [_idSuffixMap setObject:@"user/certify" forKey:@(SMUserCertify)];
        [_idSuffixMap setObject:@"accosted/nearbyonline" forKey:@(SMUserList)];
        [_idSuffixMap setObject:@"accosted/randomlist" forKey:@(SMChatRecommand)];
        [_idSuffixMap setObject:@"activity_ad_list" forKey:@(SMActivityImg)];
        [_idSuffixMap setObject:@"user/getinviteinfo" forKey:@(SMInviteInfo)];
        [_idSuffixMap setObject:@"shop/exchange_reward" forKey:@(SMExchange)];
        
        [_idSuffixMap setObject:@"user/voice_video_config" forKey:@(SMMidSettingConfig)];
        [_idSuffixMap setObject:@"user/voice_list" forKey:@(SMVoiceList)];
    }
    return self;
}

+(instancetype)sharedInstance;
{
    static HTTPInterfaceAddress* theInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        theInstance = [[HTTPInterfaceAddress alloc] init];
    });
    return theInstance;
}

+(NSString *)interfaceAddressWithID:(XXInterfaceId)iid suffix:(NSString *__autoreleasing *)suffix_
{
    NSString* base = [[IPSelector sharedSelector] autoWebApiBase];
    NSString* suffix = [[HTTPInterfaceAddress sharedInstance].idSuffixMap objectForKey:@(iid)];
    if (suffix != nil) {
        *suffix_ = suffix;
    }
    return [NSString stringWithFormat:@"%@%@",base,suffix];
}

@end
