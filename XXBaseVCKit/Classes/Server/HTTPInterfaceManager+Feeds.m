//
//  HTTPInterfaceManager+Feeds.m
//  Xiuxiu
//
//  Created by Mac on 15/7/30.
//  Copyright (c) 2015年 yangdeger@gmail.com. All rights reserved.
//

#import "HTTPInterfaceManager+Feeds.h"
#import "HTTPInterfaceManager.h"
//#import "AccountManager.h"
#import "HTTPWorker.h"
#import "HTTPInterfaceAddress.h"
//#import "Config.h"

@implementation HTTPInterfaceManager (Feeds)

-(id)getFeedTopicList:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIFeedTopicList parameters:final_params userInfo:userInfo];
}

-(id)getFeedFixListWithType:(int)type page:(int)page lastId:(int)last_id userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"type":@(type),
                           @"page":@(page),
                           @"last_feed_id":@(last_id),
                           @"limit":@(10)};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIFeedListFixed parameters:final_params userInfo:userInfo];
}

-(id)getFeedCustomListWithType:(int)type target:(int)target page:(int)page lastId:(int)last_id userInfo:(NSDictionary *)userInfo
{
    NSMutableDictionary* dict = [@{@"type":@(type),
                           @"page":@(page),
                           @"last_feed_id":@(last_id),
                           @"limit":@(10)} mutableCopy];
    if (type == 3) {
        [dict setObject:@(target) forKey:@"topic_id"];
    }else if(type == 4) {
        [
         dict setObject:@(target) forKey:@"uid"];
    }
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIFeedListCustom parameters:final_params userInfo:userInfo];
}

-(id)getFeedFlauntListWithType:(int)type target:(int)target page:(int)page goodId:(int)goods_id lastId:(int)last_id userInfo:(NSDictionary *)userInfo
{
    NSMutableDictionary* dict = [@{@"type":@(type),
                                   @"page":@(page),
                                   @"last_feed_id":@(last_id),
                                   @"limit":@(10)} mutableCopy];
    [dict setObject:@(target) forKey:@"topic_id"];
    [dict setObject:@(goods_id) forKey:@"goods_id"];
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIFeedListCustom parameters:final_params userInfo:userInfo];
}

-(id)deleteFeed:(int32_t)feed_id userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"feed_id":@(feed_id)};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIFeedDelete parameters:final_params userInfo:userInfo];
}

-(id)praiseFeed:(int32_t)feed_id userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"feed_id":@(feed_id)};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIFeedPraise parameters:final_params userInfo:userInfo];
}

-(id)reportFeed:(int32_t)feed_id reason:(NSString *)reason userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"type":@(0),
                           @"complaint":@(feed_id),
                           @"reason":reason};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIFeedReport parameters:final_params userInfo:userInfo];
}

-(id)getFeedDetail:(int32_t)feed_id userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"feed_id":@(feed_id)};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIFeedDetail parameters:final_params userInfo:userInfo];
}

-(id)getFeedCommentList:(int32_t)feed_id lastid:(int)lastid userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"feed_id":@(feed_id),
                           @"last_comment_id":@(lastid),
                           @"limit":@(15)};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIFeedCommentList parameters:final_params userInfo:userInfo];
}

-(id)commentFeed:(int32_t)feed_id commentId:(int32_t)cid content:(NSString *)content anonymous:(int32_t)anonymous userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = nil;
    if (cid > 0) {
        dict = @{@"feed_id":@(feed_id),
                 @"comment_id":@(cid),
                 @"reply_content":content,
                 @"anonymous":@(anonymous)};
    }else{
        dict = @{@"feed_id":@(feed_id),
                 @"reply_content":content,
                 @"anonymous":@(anonymous)};
    }
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIFeedComposeComment parameters:final_params userInfo:userInfo];
}

-(id)deleteFeedComment:(int32_t)comment_id userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"comment_id":@(comment_id)};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIFeedDeleteComment parameters:final_params userInfo:userInfo];
}

-(id)reportFeedComment:(int32_t)comment_id ownerAiainum:(int32_t)aiainum reason:(NSString *)reason userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"to_uid":@(aiainum),
                           @"type":@(1),
                           @"complaint":@(comment_id),
                           @"reason":reason};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIFeedReportComment parameters:final_params userInfo:userInfo];
}

-(id)getFeedPraisedList:(int32_t)feed_id page:(int32_t)page userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"feed_id":@(feed_id),
                           @"page":@(page),
                           @"limit":@(15)};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIFeedPraiseList parameters:final_params userInfo:userInfo];
}

-(id)getFeedNewTipsCount:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIFeedTipsNum parameters:final_params userInfo:userInfo];
}

-(id)feedAdConfigWithTableType:(int32_t)type userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"type":@(type)};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIFeedAdConfig parameters:final_params userInfo:userInfo];
}

-(id)feedAdConfigWithType:(int32_t)type feedTopic:(int32_t)topic_id userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"type":@(type),
                           @"topic_id":@(topic_id)};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIFeedAdConfig parameters:final_params userInfo:userInfo];
}

-(id)composeFeed:(NSString *)content topic:(int32_t)topic_id anonymous:(int32_t)anonymous pics:(NSArray *)pics userInfo:(NSDictionary *)userInfo
{
    NSMutableDictionary* dict = [NSMutableDictionary dictionary];
    if ([content length] > 0) {
        [dict setObject:content forKey:@"content"];
    }
    [dict setObject:@(topic_id) forKey:@"topic_id"];
    [dict setObject:@(anonymous) forKey:@"anonymous"];
    if (pics != nil) { //不能判断count，因为可能返回数目为空的数组
        [dict setObject:@(1) forKey:@"is_pic"];
        for (NSInteger i = 0; i < [pics count]; i++) {
            NSString* pic_url = [pics objectAtIndex:i];
            [dict setObject:pic_url forKey:[NSString stringWithFormat:@"pic_%ld",(long)i+1]];
        }
    }else{
        [dict setObject:@(0) forKey:@"is_pic"];
    }
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIFeedCompose parameters:final_params userInfo:userInfo];
}

-(id)composeFlaunt:(NSString *)content topic:(int32_t)topic_id goods:(int32_t)goods_id userInfo:(NSDictionary *)userInfo
{
    NSMutableDictionary* dict = [NSMutableDictionary dictionary];
    if ([content length] > 0) {
        [dict setObject:content forKey:@"content"];
    }
    [dict setObject:@(topic_id) forKey:@"topic_id"];
    [dict setObject:@(goods_id) forKey:@"goods_fight_id"];
 
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIFeedCompose parameters:final_params userInfo:userInfo];
}

-(id)composeMoments:(NSString *)content pics:(NSArray *)pics userInfo:(id)userInfo
{
    NSMutableDictionary* dict = [NSMutableDictionary dictionary];
    if ([content length] > 0) {
        [dict setObject:content forKey:@"content"];
    }
    if ([pics count] > 0) {
        [dict setObject:@(1) forKey:@"is_pic"];
        for (NSInteger i = 0; i < [pics count]; i++) {
            NSString* pic_url = [pics objectAtIndex:i];
            [dict setObject:pic_url forKey:[NSString stringWithFormat:@"pic_%ld",(long)i+1]];
        }
    }else{
        [dict setObject:@(0) forKey:@"is_pic"];
    }
    [dict setObject:@(1) forKey:@"is_friend_topic"];
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIFeedCompose parameters:final_params userInfo:userInfo];
}

-(id)composeCertify:(NSString *)content pics:(NSArray *)pics userInfo:(id)userInfo{
    NSMutableDictionary* dict = [NSMutableDictionary dictionary];
    if ([content length] > 0) {
        [dict setObject:content forKey:@"certify_text"];
    }
    if ([pics count] > 0) {
        [dict setObject:@(1) forKey:@"is_pic"];
        for (NSInteger i = 0; i < [pics count]; i++) {
            NSString* pic_url = [pics objectAtIndex:i];
            [dict setObject:pic_url forKey:[NSString stringWithFormat:@"pic%ld",(long)i+1]];
        }
    }else{
        [dict setObject:@(0) forKey:@"is_pic"];
    }
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:SMUserCertify parameters:final_params userInfo:userInfo];
    
}


-(id)composeFlaunt:(NSString *)content pics:(NSArray *)pics topic:(int32_t)topic_id goods:(int32_t)goods_id userInfo:(id)userInfo
{
    NSMutableDictionary* dict = [NSMutableDictionary dictionary];
    if ([content length] > 0) {
        [dict setObject:content forKey:@"content"];
    }
    if ([pics count] > 0) {
        [dict setObject:@(1) forKey:@"is_pic"];
        for (NSInteger i = 0; i < [pics count]; i++) {
            NSString* pic_url = [pics objectAtIndex:i];
            [dict setObject:pic_url forKey:[NSString stringWithFormat:@"pic_%ld",(long)i+1]];
        }
    }else{
        [dict setObject:@(0) forKey:@"is_pic"];
    }
    [dict setObject:@(topic_id) forKey:@"topic_id"];
    [dict setObject:@(goods_id) forKey:@"goods_fight_id"];
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIFeedCompose parameters:final_params userInfo:userInfo];
}


-(id)uploadComposeFeedPictures:(NSArray *)pics userInfo:(NSDictionary *)userInfo
{

    NSDictionary* dict = @{};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params needPercentEscape:NO];
    NSDictionary* final_params = @{@"data":json_value};
    
    NSString* suffix = nil;
    NSString* urlStr = [HTTPInterfaceAddress interfaceAddressWithID:XIFeedComposePictures suffix:&suffix];
    HTTPWorker* worker = [[HTTPWorker alloc] initWithBaseUrl:urlStr parameters:final_params delegate:self];
    NSInteger count = [pics count];
    for (NSInteger i = 0; i < count; i++) {
        [worker multipartPartAddData:pics[i] contentType:@"image/jpeg" fileName:@"user_avatar.png" forKey:[NSString stringWithFormat:@"new_%d",(int32_t)i]];
    }

    worker.integerInfo = XIFeedComposePictures;
    worker.userInfo = userInfo;
    worker.stringInfo = suffix;
    [worker requestAsync:_workingQueue];
    [_workers addObject:worker];
    return worker;
}

-(id)getFeedAllTipsList:(int32_t)offset userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"limit":@(10),
                           @"offset":@(offset)};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIFeedAllTipsList parameters:final_params userInfo:userInfo];
}

- (id)clearAllTips:(NSDictionary*)userInfo
{
    NSDictionary* dict = @{};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIFeedClearAllTips parameters:final_params userInfo:userInfo];
}

-(id)deleteOneTips:(int32_t)tips_id userInfo:(NSDictionary*)userInfo
{
    NSDictionary* dict = @{@"tips_id":@(tips_id)};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIFeedDeleteOneTips parameters:final_params userInfo:userInfo];
}

-(id)getRedPointInfo:(id)userInfo
{
    NSDictionary* dict = @{};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIRedPointInfo parameters:final_params userInfo:userInfo];
}

-(id)stickFeedToTop:(int32_t)feed_id type:(int32_t)type userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"feed_id":@(feed_id),
                           @"type":@(type)};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIFeedListStickToNorth parameters:final_params userInfo:userInfo];
}

- (id)fetchMineMoments {
    NSDictionary* dict = @{};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIDiscoverMineMoments parameters:final_params userInfo:nil];
}

-(id)fetchAllCircleByPage:(int)page userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"page":@(page),
                           @"limit":@(10)};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIAllCircleList parameters:final_params userInfo:nil];
}

- (id)fetchRecommondMoments {
    NSDictionary* dict = @{};
    
    NSDictionary* params = [self addCommomParameters:dict];
    
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIDiscoverRecommondMoments parameters:final_params userInfo:nil];
}

- (id)fetchTopicList {
    NSDictionary* dict = @{};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIDiscoverTopicList parameters:final_params userInfo:nil];
}

- (id)fetchTopicClassList {
    NSDictionary* dict = @{};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIDiscoverTopicClassList parameters:final_params userInfo:nil];
}

- (id)focusTopic:(NSInteger)topicID {
    NSDictionary* dict = @{@"topic_id":@(topicID)};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIDiscoverFocusTopic parameters:final_params userInfo:nil];
}

- (id)cancelFocusTopic:(NSInteger)topicID {
    NSDictionary* dict = @{@"topic_id":@(topicID)};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIDiscoverCancelFocusTopic parameters:final_params userInfo:nil];
}

- (id)getFilterTipicList {
    NSDictionary* dict = @{};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIFilterTopicList parameters:final_params userInfo:nil];
}

- (id)checkAddFeedsPermission:(NSInteger)topic_id {
    NSDictionary* dict = @{@"topic_id":@(topic_id)};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XICheckAddFeed parameters:final_params userInfo:nil];
}

- (id)getHotTalkRecommendList
{
    NSDictionary* dict = @{};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIHotTalkRecommend parameters:final_params userInfo:nil];
}

-(id)getCircleRecommendList
{
    NSDictionary* dict = @{};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIRecommandCircle parameters:final_params userInfo:nil];
}

- (id)getHotTalkPage:(int)page limit:(int)limit userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"page":@(page),@"limit":@(limit)};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIHotTalkList parameters:final_params userInfo:nil];
}
@end
