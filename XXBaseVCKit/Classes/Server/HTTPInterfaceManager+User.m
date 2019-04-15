//
//  HTTPInterfaceManager+User.m
//  Xiuxiu
//
//  Created by Mac on 15/4/2.
//  Copyright (c) 2015年 yangdeger@gmail.com. All rights reserved.
//

#import "HTTPInterfaceManager+User.h"
#import "HTTPWorker.h"
#import "IPSelector.h"
#import "NSString+ExtraXX.h"
#import "NSString+ExtraXX.h"

#define kIMKey_RequestId @"InterfaceManagerRequestId"

@implementation HTTPInterfaceManager (User)

-(id)updateNewPassword:(NSString *)password oldPassword:(NSString *)old_password userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"newpwd":password,
                           @"oldpwd":old_password};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIUserModifyPassword parameters:final_params userInfo:userInfo];
}

-(id)updateSMUserInfo:(NSDictionary *)information userInfo:(NSDictionary *)userInfo{
    NSDictionary* dict = information;
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:SMUserCompeletInfo parameters:final_params userInfo:userInfo];
}

-(id)updateUserInfomation:(NSDictionary *)information userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = information;
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIUserModifyInfo parameters:final_params userInfo:userInfo];
}

-(id)updateUserInfomation:(NSDictionary *)information userInfo:(NSDictionary *)userInfo noTk:(BOOL)noTk
{
    
    NSDictionary* dict = information;
    NSDictionary* params = [self addCommomParameters:dict];
    if (noTk) {
        NSMutableDictionary* mparams = (NSMutableDictionary*)params;
        [mparams removeObjectForKey:@"tk"];
        NSMutableString *str = [NSMutableString string];
        //获取所有key
        NSArray *keyList = mparams.allKeys;
        //按字母排序
        NSArray *sortedArray = [keyList sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            return [obj1 compare:obj2];
        }];
        //排序后拼接字符串
        for (NSString *key in sortedArray){
            id value = params[key];
            //根据服务器要求，去除掉空格等字符
            if ([value isKindOfClass:[NSString class]]) {
                value = [(NSString*)value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                //将之前percent encode的东西先转回来
                value = [value stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                //将\\和\"转译
                value = [value stringByReplacingOccurrencesOfString:@"\\\\" withString:@"\\"];
                value = [value stringByReplacingOccurrencesOfString:@"\\\"" withString:@"\""];
            }
            
            [str appendString:[NSString stringWithFormat:@"%@",value]];
        }
        NSString* tk = [str md5Value];
        [mparams setObject:tk forKey:@"tk"];
    }
    
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIUserModifyInfo parameters:final_params userInfo:userInfo];
}

-(id)changeUserStatus:(int)status userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"statusid":[NSString stringWithFormat:@"%d",status]};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIUserChangeStatus parameters:final_params userInfo:userInfo];
}

-(id)bindDeviceWithDeviceMac:(NSString *)mac deviceType:(NSString *)type deviceName:(NSString *)name userInfo:(NSDictionary *)userInfo {
    NSDictionary* dict = @{@"mac":mac,
                           @"devtype":type,
                           @"devname":name == nil ? @"" : name};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIBindDevice parameters:final_params userInfo:userInfo];
}



-(id)deviceDisconnectWithDeviceMac:(NSString *)mac userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"mac":mac};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIDisconnectDevice parameters:final_params userInfo:userInfo];
}

-(id)uploadAvatarWithPicList:(NSString *)picList modifyPicIds:(NSArray *)picIds datas:(NSArray *)datas userInfo:(NSDictionary *)userInfo
{
    assert([picIds count] == [datas count]);
    NSDictionary* dict = @{@"piclist":picList};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params needPercentEscape:NO];
    NSDictionary* final_params = @{@"data":json_value};

    NSString* base = [[IPSelector sharedSelector] autoWebApiBase];
    NSString* urlStr = [NSString stringWithFormat:@"%@%@",base,@"user/uploadaccountpic"];
    HTTPWorker* worker = [[HTTPWorker alloc] initWithBaseUrl:urlStr parameters:final_params delegate:self];
    NSInteger count = [picIds count];
    for (NSInteger i = 0; i < count; i++) {
        [worker multipartPartAddData:datas[i] contentType:@"image/jpeg" fileName:@"user_avatar.png" forKey:picIds[i]];
    }
    
    worker.integerInfo = XIUploadAvatar;
    worker.userInfo = userInfo;
    [worker requestAsync:_workingQueue];
    
    @synchronized(_workers) {
        [_workers addObject:worker];
    }
    return worker;
}



-(id)getUserinfoWithAiaiNum:(NSString *)aiaiNum userinfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"uid":aiaiNum};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIGetUserInfoByAiaiNum parameters:final_params userInfo:userInfo];
}

-(id)getUserInfoWithString:(NSString *)str page:(int)page limit:(int)lit userinfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"search":str,
                           @"page":@(page),
                           @"limit":@(lit)};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XINewSearch parameters:final_params userInfo:userInfo];
}

-(id)getUserListWithGender:(NSString *)gender page:(int)page userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"gender":gender
                           ,@"page":@(page)
                           ,@"limit":@(20)
                           ,@"getallcount":@(1)};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIGetUserList parameters:final_params userInfo:userInfo];
}

-(id)zanUserWithAiaiNum:(NSString *)aiaiNum userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"uid":aiaiNum};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIZanUser parameters:final_params userInfo:userInfo];
}

-(id)followUserWithAiaiNum:(NSString *)aiaiNum userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"uid":aiaiNum};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIFollowUser parameters:final_params userInfo:userInfo];
}

-(id)unfollowUserWithAiaiNum:(NSString *)aiaiNum userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"uid":aiaiNum};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIUnFollowUser parameters:final_params userInfo:userInfo];
}

-(id)blockUserWithAiaiNum:(NSString *)aiaiNum userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"uid":aiaiNum};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIBanUser parameters:final_params userInfo:userInfo];
}

-(id)reportAndBlockUserWithAiaiNum:(NSString *)aiaiNum reason:(NSString *)reason userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"report_aiainum":aiaiNum,
                           @"report_reason":reason};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIReportAndBlockUser parameters:final_params userInfo:userInfo];
}

-(id)reportUserWithAiaiNum:(NSString *)aiaiNum reason:(NSString *)reason userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"report_aiainum":aiaiNum,
                           @"report_reason":reason};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIReportUser parameters:final_params userInfo:userInfo];
}

-(id)unbanUserWithAiaiNum:(NSString *)aiaiNum userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"uid":aiaiNum};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIUnbanUser parameters:final_params userInfo:userInfo];
}

-(id)getBatchUserInfoWithAiaiNumbers:(NSString *)aiaiNums userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"uidlist":aiaiNums};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIGetBatchUserInfoByAiaiNum parameters:final_params userInfo:userInfo];
}

-(id)getUserFollowListWithPage:(int)page userinfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"page":@(page)
                           ,@"limit":@(20)
                           ,@"getallcount":@(1)};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIGetMyFollowList parameters:final_params userInfo:userInfo];
}

-(id)getUserFollowListWithPage:(int)page searchWord:(NSString *)word userinfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"page":@(page)
                           ,@"limit":@(20)
                           ,@"getallcount":@(1)
                           ,@"search":word};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIGetMyFollowList parameters:final_params userInfo:userInfo];
}
-(id)getUserFansListWithPage:(int)page userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"page":@(page)
                           ,@"limit":@(20)
                           ,@"getallcount":@(1)};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIGetMyFansList parameters:final_params userInfo:userInfo];
}

-(id)getUserPraisedListWithPage:(int)page userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"page":@(page)
                           ,@"limit":@(20)
                           ,@"getallcount":@(1)};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIGetMyPraisedList parameters:final_params userInfo:userInfo];
}

-(id)getUserBanListWithPage:(int)page searchWord:(NSString *)word userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"page":@(page)
                           ,@"limit":@(20)
                           ,@"getallcount":@(1)
                           ,@"search":word};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIBanUserList parameters:final_params userInfo:userInfo];
}


-(id)setUserInvisiableState:(int)state userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"newstatus":@(state)};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIUserModifyInvisiable parameters:final_params userInfo:userInfo];
}


-(id)getUserVisitorListWithPage:(int)page userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"page":@(page)
                           ,@"limit":@(20)
                           ,@"getallcount":@(1)};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIGetMyVisitorList parameters:final_params userInfo:userInfo ];
}

-(id)getRankTypeList:(int)gender userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"gender":@(gender)};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIRankTypeList parameters:final_params userInfo:userInfo ];
}

-(id)getRankData:(int)rid page:(int)page userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"top_id":@(rid)
                           ,@"page":@(page)
                           ,@"limit":@(30)};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIRankData parameters:final_params userInfo:userInfo ];
}

-(id)getSigninInformations:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XISigninInfos parameters:final_params userInfo:userInfo];
}

-(id)doSigninWithActivityId:(int)aid dateString:(NSString *)dateStr userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"activity_id":@(aid),
                           @"activity_date":dateStr};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XISigninAction parameters:final_params userInfo:userInfo];
}

-(id)uploadVoiceSignature:(NSData *)voiceData duration:(int)duration userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"voice_time":@(duration)};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params needPercentEscape:NO];
    NSDictionary* final_params = @{@"data":json_value};
    
    NSString* base = [[IPSelector sharedSelector] autoWebApiBase];
    NSString* urlStr = [NSString stringWithFormat:@"%@%@",base,@"user/upload_voice"];
    HTTPWorker* worker = [[HTTPWorker alloc] initWithBaseUrl:urlStr parameters:final_params delegate:self];

    [worker multipartPartAddData:voiceData contentType:@"audio/amr" fileName:@"voice" forKey:@"voice"];
    
    worker.integerInfo = XIUploadVoiceSignature;
    worker.userInfo = userInfo;
    [worker requestAsync:_workingQueue];
    
    @synchronized(_workers) {
        [_workers addObject:worker];
    }

    return worker;
}

-(id)removeVoiceSingatureWithUserInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"remove_voice":@(1)};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIRemoveVoiceSignature parameters:final_params userInfo:userInfo];
}

-(id)feedbackInformations:(NSDictionary *)feedback userInfo:(NSDictionary *)userInfo
{
    NSDictionary* params = [self addCommomParameters:feedback];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIFeedback parameters:final_params userInfo:userInfo];
}

- (id)getIDWallPhotoListWithPage:(NSInteger)page Limit:(NSInteger)limit Tag:(int)tag Time:(NSString *)time Score:(NSString *)scroe userInfo:(NSDictionary *)userInfo {
    NSDictionary *dic = @{@"page":@(page),
                          @"limit":@(limit),
                          @"gender":@(-1),
                          };
    NSDictionary *param = [self addCommomParameters:dic];
    NSString *json_value = [self genPackedJsonStringWithParameters:param];
    NSDictionary *final_value = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIGetIDWallList parameters:final_value userInfo:userInfo];
}

-(id)getSMIDWallPhotoWithParams:(NSDictionary *)par userInfo:(NSDictionary *)userInfo{
    NSDictionary *param = [self addCommomParameters:par];
    NSString *json_value = [self genPackedJsonStringWithParameters:param];
    NSDictionary *final_value = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIGetIDWallList parameters:final_value userInfo:userInfo];
}

- (id)getUserPermissionAndService {
    NSDictionary *param = [self addCommomParameters:nil];
    NSString *json_value = [self genPackedJsonStringWithParameters:param];
    NSDictionary *final_value = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIGetUserPermission parameters:final_value userInfo:nil];
}

- (id)getUserComboPermissionList {
    NSDictionary *param = [self addCommomParameters:nil];
    NSString *json_value = [self genPackedJsonStringWithParameters:param];
    NSDictionary *final_value = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIGetUserComboPermissionList parameters:final_value userInfo:nil];
}

- (id)buyUserPermission:(int)combo_id {
    NSDictionary *param = [self addCommomParameters:@{@"combo_id":@(combo_id)}];
    NSString *json_value = [self genPackedJsonStringWithParameters:param];
    NSDictionary *final_value = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIBuyUserPermission parameters:final_value userInfo:nil];
}


- (id)getHadBuyLit {
    NSDictionary *param = [self addCommomParameters:nil];
    NSString *json_value = [self genPackedJsonStringWithParameters:param];
    NSDictionary *final_value = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIGetHadBuyList parameters:final_value userInfo:nil];
}

- (id)getUserMissionAndLevel {
    NSDictionary *param = [self addCommomParameters:nil];
    NSString *json_value = [self genPackedJsonStringWithParameters:param];
    NSDictionary *final_value = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIGetUserLevel parameters:final_value userInfo:nil];
}

-(id)setAudioChatSwitchByOn:(int)on
{
    NSDictionary *dic = @{@"newstatus":@(on)};
    NSDictionary *param = [self addCommomParameters:dic];
    NSString *json_value = [self genPackedJsonStringWithParameters:param];
    NSDictionary *final_value = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIAudioSetSwith parameters:final_value userInfo:nil];
}

-(id)changeVideoChatSwitch:(int)status userInfo:(NSDictionary *)userInfo
{
    NSDictionary *dic = @{@"status":@(status)};
    NSDictionary* params = [self addCommomParameters:dic];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIVideoChatSwitch parameters:final_params userInfo:userInfo];
}

-(id)pushExpression:(int)face_pack_id express:(int)img_id
{
    
    NSDictionary *dic = @{@"face_pack_id":@(face_pack_id),
                          @"img_id":@(img_id)};
    NSDictionary *param = [self addCommomParameters:dic];
    NSString *json_value = [self genPackedJsonStringWithParameters:param];
    NSDictionary *final_value = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIUpExpressionl parameters:final_value userInfo:nil];
}

- (id)getUserRemarkList {
    NSDictionary *dic = @{@"page":@(0),
                          @"limit":@(500)};
    NSDictionary *param = [self addCommomParameters:dic];
    NSString *json_value = [self genPackedJsonStringWithParameters:param];
    NSDictionary *final_value = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIGetUserRemarkList parameters:final_value userInfo:nil];
}

- (id)updateUserRemarkFromAiAiNum:(NSString *)fromAiAiNum ToAiAiNum:(NSString *)toAiAiNum RemarkName:(NSString *)remarkName {
    NSDictionary *dic = @{@"from_aiai_num":fromAiAiNum,
                          @"to_uid":toAiAiNum,
                          @"remark_name":remarkName};
    NSDictionary *param = [self addCommomParameters:dic];
    NSString *json_value = [self genPackedJsonStringWithParameters:param];
    NSDictionary *final_value = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIUpdateRemarkName parameters:final_value userInfo:nil];
}

- (id)fetchUserSettingInfo {
    NSDictionary *dic = @{};
    NSDictionary *param = [self addCommomParameters:dic];
    NSString *json_value = [self genPackedJsonStringWithParameters:param];
    NSDictionary *final_value = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIGetSettingConf parameters:final_value userInfo:nil];
    
}

- (id)submitReportWithContent:(NSString *)content ClassId:(NSInteger)classId PicPaths:(NSArray *)picPaths AiaiNum:(NSString *)aiaiNum{
    
    NSDictionary *param = nil;
    
    
    //把地址的数字拼上
    if (picPaths !=nil && picPaths.count>0) {
        NSMutableDictionary *picPathsDic = [NSMutableDictionary dictionary];
        for (int i = 1; i <= picPaths.count; i ++) {
            [picPathsDic setObject:picPaths[i-1] forKey:[NSString stringWithFormat:@"pic_%d",i]];
        }
        
        [picPathsDic addEntriesFromDictionary: @{@"content":content,@"class_id":@(classId),@"sys_version":[[UIDevice currentDevice] systemVersion],@"device":[NSString iPhoneTypeString],@"be_reported_aiainum":aiaiNum}];
        param = [self addCommomParameters:picPathsDic];
        
        
    } else {
        param = [self addCommomParameters:@{@"content":content,@"class_id":@(classId),@"sys_version":[[UIDevice currentDevice] systemVersion],@"device":[NSString iPhoneTypeString],@"be_reported_aiainum":aiaiNum}];
    }
    
    
    NSString *json_value = [self genPackedJsonStringWithParameters:param];
    NSDictionary *final_value = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XISubmitReportMsg parameters:final_value userInfo:nil];
}

- (id)postCallReport:(NSDictionary *)call_info{
    NSDictionary *dic = call_info;
    NSDictionary *param = [self addCommomParameters:dic];
    NSString *json_value = [self genPackedJsonStringWithParameters:param];
    NSDictionary *final_value = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XICallReport parameters:final_value userInfo:nil];
}

@end
