//
//  HTTPInterfaceManager+ChatGroup.h
//  Xiuxiu
//
//  Created by Mac on 15/12/24.
//  Copyright © 2015年 yangdeger@gmail.com. All rights reserved.
//

#import "HTTPInterfaceManager.h"

@interface HTTPInterfaceManager (ChatGroup)

-(id)getChatGroupList:(int)page category:(int)category userInfo:(NSDictionary*)userInfo;

-(id)getChatGroupListNew:(int)page tag_type:(int)tag_type tag_id:(int)tag_id sort_type:(int)sort_type userInfo:(NSDictionary *)userInfo;

-(id)getChatGroupInfos:(int)group_id userInfo:(NSDictionary*)userInfo;

-(id)applyChatGroupJoin:(int)group_id userInfo:(NSDictionary*)userInfo;

/**
 * 处理申请
 * 
 * @param group_id 群组id
 * @param apply_id 申请id
 * @param result 处理结果 1 同意加入， 2 拒绝
 */
-(id)dealChatGroup:(int)group_id apply:(int)apply_id result:(int)result userInfo:(NSDictionary*)userInfo;

-(id)cancelChatGroupJoinApply:(int)group_id userInfo:(NSDictionary*)userInfo;

-(id)getChatGroupApplyList:(int)group_id page:(int)page userInfo:(NSDictionary*)userInfo;

-(id)getChatGroup:(int)group_id memberList:(int)page userInfo:(NSDictionary*)userInfo;

/**
 * 修改群名称或群签名
 * 
 * @param group_id 群组id
 * @param infos 相关信息，参见接口文档
 * @param userInfo 透传
 */
-(id)updateChatGroup:(int)group_id informations:(NSDictionary*)infos userInfo:(id)userInfo;


/**
 * 修改群公告
 * 
 * @param group_id 群组id
 * @param anno_text 公告内容
 * @param userInfo 透传
 */
-(id)updateChatGroup:(int)group_id announcement:(NSString*)anno_text userInfo:(id)userInfo;


-(id)chatGroup:(int)group_id kickMember:(int)member_id userInfo:(id)userInfo;

-(id)chatGroup:(int)group_id kickAndBlockMember:(int)member_id userInfo:(id)userInfo;

-(id)leaveChatGroup:(int)group_id userInfo:(NSDictionary*)userInfo;

-(id)getChatGroupInfosViaHxIds:(NSString*)hxIds userInfo:(id)userInfo;

-(id)chatGroupRecommendListWithPage:(int)page userInfo:(id)userInfo;

-(id)chatGroupCategoryListWithPage:(int)page userInfo:(id)userInfo;

-(id)chatGroupJoinedListWithPage:(int)page userInfo:(id)userInfo;

-(id)chatGroupOfficalListWithPage:(int)page userInfo:(id)userInfo;

-(id)getChatGroupBlackList:(int)group_id page:(int)page userInfo:(id)userInfo;

-(id)cancelChatGroupBlack:(int)group_id balck_id:(int)black_id userInfo:(id)userInfo;

-(id)addManagerInChatGroup:(int)group_id member:(int)member_id userInfo:(id)userInfo;

-(id)removeManagerInChatGroup:(int)group_id member:(int)member_id userInfo:(id)userInfo;

-(id)getUserFansListInChatGroup:(int)group_id page:(int)page searchStr:(NSString *)search userInfo:(NSDictionary *)userInfo;

-(id)inviteFuns:(NSArray *)funs joinToGroup:(int)group_id message:(NSDictionary *)ext userInfo:(id)userInfo;

-(id)acceptToJoinGroup:(int)group_id invite_sn:(NSString *)invite_sn userInfo:(id)userInfo;

-(id)searchChatGroupByKeyword:(NSString *)k_word class_id:(int)class_id page:(int)page userInfo:(id)userInfo;

-(id)searchChatGroupInClassByKeyword:(NSString *)k_word class_id:(int)class_id page:(int)page userInfo:(id)userInfo;

-(id)fetchAllJoinedGroup;

@end
