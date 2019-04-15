//
//  HTTPInterfaceManager+ChatGroup.m
//  Xiuxiu
//
//  Created by Mac on 15/12/24.
//  Copyright © 2015年 yangdeger@gmail.com. All rights reserved.
//

#import "HTTPInterfaceManager+ChatGroup.h"

@implementation HTTPInterfaceManager (ChatGroup)

-(id)getChatGroupList:(int)page category:(int)category userInfo:(NSDictionary *)userInfo
{
    //增加一个category的支持
    NSDictionary* dict = nil;
    if (category < 0) {
        dict = @{@"page":@(page),
          @"limit":@(15)};
    }else{
        dict = @{@"page":@(page),
                 @"class_id":@(category),
                 @"limit":@(15)};
    }
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIChatGroupList parameters:final_params userInfo:userInfo];
}

-(id)getChatGroupListNew:(int)page tag_type:(int)tag_type tag_id:(int)tag_id sort_type:(int)sort_type userInfo:(NSDictionary *)userInfo{
    NSDictionary* dict = nil;
    dict = @{@"page":@(page),@"tag_type":@(tag_type),@"tag_id":@(tag_id),@"sort_type":@(sort_type),@"limit":@(15)};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIChatGroupList parameters:final_params userInfo:userInfo];
}


-(id)getChatGroup:(int)group_id memberList:(int)page userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"group_id":@(group_id),
                           @"page":@(page),
                           @"limit":@(1000)};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIChatGroupMemberList parameters:final_params userInfo:userInfo];
}

-(id)getChatGroupInfos:(int)group_id userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"group_id":@(group_id)};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIChatGroupInfos parameters:final_params userInfo:userInfo];
}

-(id)getChatGroupApplyList:(int)group_id page:(int)page userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"group_id":@(group_id),
                           @"page":@(page),
                           @"limit":@(20)};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIChatGroupApplyList parameters:final_params userInfo:userInfo];
}

-(id)dealChatGroup:(int)group_id apply:(int)apply_id result:(int)result userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"group_id":@(group_id),
                           @"apply_id":@(apply_id),
                           @"deal_result":@(result)};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIChatGroupDealApply parameters:final_params userInfo:userInfo];
}

-(id)applyChatGroupJoin:(int)group_id userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"group_id":@(group_id)};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIChatGroupApply parameters:final_params userInfo:userInfo];
}

-(id)updateChatGroup:(int)group_id informations:(NSDictionary *)infos userInfo:(id)userInfo
{
    NSMutableDictionary* dict = [NSMutableDictionary dictionary];
    [dict setObject:@(group_id) forKey:@"group_id"];
    [dict setValuesForKeysWithDictionary:infos];
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIChatGroupUpdateInfos parameters:final_params userInfo:userInfo];
}

-(id)updateChatGroup:(int)group_id announcement:(NSString *)anno_text userInfo:(id)userInfo
{
    NSDictionary* dict = @{@"group_id":@(group_id),
                           @"message":anno_text};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIChatGroupUpdateAnnouncement parameters:final_params userInfo:userInfo];
}

-(id)chatGroup:(int)group_id messageSetting:(int)type userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"group_id":@(group_id),
                           @"msg_type":@(type)};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIChatGroupMsgSetting parameters:final_params userInfo:userInfo];
}

-(id)chatGroup:(int)group_id kickMember:(int)member_id userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"group_id":@(group_id),
                           @"mem_id":@(member_id)};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIChatGroupKick parameters:final_params userInfo:userInfo];
}

-(id)chatGroup:(int)group_id kickAndBlockMember:(int)member_id userInfo:(id)userInfo
{
    NSDictionary* dict = @{@"group_id":@(group_id),
                           @"mem_id":@(member_id)};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIChatGroupBlackAndKick parameters:final_params userInfo:userInfo];
}

-(id)leaveChatGroup:(int)group_id userInfo:(id)userInfo
{
    NSDictionary* dict = @{@"group_id":@(group_id)};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIChatGroupLeave parameters:final_params userInfo:userInfo];
}

-(id)getChatGroupInfosViaHxIds:(NSString*)hxIds userInfo:(id)userInfo
{
    NSDictionary* dict = @{@"group_hx_id":hxIds};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIChatGroupInfoViaHx parameters:final_params userInfo:userInfo];
}

-(id)cancelChatGroupJoinApply:(int)group_id userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"group_id":@(group_id)};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIChatGroupCancelApply parameters:final_params userInfo:userInfo];
}

-(id)chatGroupCategoryListWithPage:(int)page userInfo:(id)userInfo
{
    NSDictionary* dict = @{@"page":@(page),
                           @"limit":@(50)};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIChatGroupCategoryList parameters:final_params userInfo:userInfo];
}

-(id)chatGroupRecommendListWithPage:(int)page userInfo:(id)userInfo
{
    NSDictionary* dict = @{@"page":@(page),
                           @"limit":@(15)};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIChatGroupRecommendList parameters:final_params userInfo:userInfo];
}

-(id)chatGroupJoinedListWithPage:(int)page userInfo:(id)userInfo
{
    NSDictionary* dict = @{@"page":@(page),
                           @"limit":@(15)};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIChatGroupJoinedList parameters:final_params userInfo:userInfo];
}

-(id)chatGroupOfficalListWithPage:(int)page userInfo:(id)userInfo{
    NSDictionary* dict = @{@"page":@(page),
                           @"limit":@(15)};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIChatGroupOffical parameters:final_params userInfo:userInfo];
    
}


- (id)fetchAllJoinedGroup {
    NSDictionary* dict = @{@"page":@(0),
                           @"limit":@(100)};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIChatGroupJoinedList parameters:final_params userInfo:@{}];
}

-(id)getChatGroupBlackList:(int)group_id page:(int)page userInfo:(id)userInfo
{
    NSDictionary* dict = @{@"group_id":@(group_id),
                           @"page":@(page),
                           @"limit":@(20)};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString *json_value = [self genPackedJsonStringWithParameters:params];
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIGetGroupBlackList parameters:final_params userInfo:userInfo];
}

-(id)cancelChatGroupBlack:(int)group_id balck_id:(int)black_id userInfo:(id)userInfo
{
    NSDictionary* dict = @{@"group_id":@(group_id),
                           @"black_id":@(black_id)};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString *json_value = [self genPackedJsonStringWithParameters:params];
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XICancelGroupBlack parameters:final_params userInfo:userInfo];
}

-(id)addManagerInChatGroup:(int)group_id member:(int)member_id userInfo:(id)userInfo
{
    NSDictionary* dict = @{@"group_id":@(group_id),
                           @"mem_id":@(member_id)};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString *json_value = [self genPackedJsonStringWithParameters:params];
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIAddManager parameters:final_params userInfo:userInfo];
}

-(id)removeManagerInChatGroup:(int)group_id member:(int)member_id userInfo:(id)userInfo
{
    NSDictionary* dict = @{@"group_id":@(group_id),
                           @"mem_id":@(member_id)};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString *json_value = [self genPackedJsonStringWithParameters:params];
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIRemoveManager parameters:final_params userInfo:userInfo];
}

-(id)getUserFansListInChatGroup:(int)group_id page:(int)page searchStr:(NSString *)search userInfo:(NSDictionary *)userInfo
{
    NSMutableDictionary* dict = [@{@"page":@(page)
                           ,@"limit":@(20)
                           ,@"getallcount":@(1)
                           ,@"group_id":@(group_id)} mutableCopy];
    if (search) {
        [dict setObject:search forKey:@"search"];
    }
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIGetMyFansList parameters:final_params userInfo:userInfo];
}

-(id)inviteFuns:(NSArray *)funs joinToGroup:(int)group_id message:(NSDictionary *)ext userInfo:(id)userInfo
{
    NSDictionary* dict = @{@"group_id":@(group_id),
                           @"members":funs,
                           @"ext":ext};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString *json_value = [self genPackedJsonStringWithParameters:params];
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIInviteJoinGroup parameters:final_params userInfo:userInfo];
}

-(id)acceptToJoinGroup:(int)group_id invite_sn:(NSString *)invite_sn userInfo:(id)userInfo
{
    NSDictionary* dict = @{@"group_id":@(group_id),
                           @"invite_sn":invite_sn};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString *json_value = [self genPackedJsonStringWithParameters:params];
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIAcceptJoinGroup parameters:final_params userInfo:userInfo];
}

-(id)searchChatGroupByKeyword:(NSString *)k_word class_id:(int)class_id page:(int)page userInfo:(id)userInfo
{
    NSDictionary *dic = @{@"k_word":k_word,
                          @"class_id":@(class_id),
                          @"limit":@(20),
                          @"page":@(page)};
    NSDictionary *params = [self addCommomParameters:dic];
    NSString *json_value = [self genPackedJsonStringWithParameters:params];
    NSDictionary *final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIChatGroupSearch parameters:final_params userInfo:userInfo];
}

-(id)searchChatGroupInClassByKeyword:(NSString *)k_word class_id:(int)class_id page:(int)page userInfo:(id)userInfo
{
    NSDictionary *dic = @{@"k_word":k_word,
                          @"class_id":@(class_id),
                          @"limit":@(20),
                          @"page":@(page)};
    NSDictionary *params = [self addCommomParameters:dic];
    NSString *json_value = [self genPackedJsonStringWithParameters:params];
    NSDictionary *final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIChatGroupClassSearch parameters:final_params userInfo:userInfo];
}
@end
