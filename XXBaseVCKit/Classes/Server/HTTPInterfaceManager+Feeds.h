//
//  HTTPInterfaceManager+Feeds.h
//  Xiuxiu
//
//  Created by Mac on 15/7/30.
//  Copyright (c) 2015年 yangdeger@gmail.com. All rights reserved.
//

#import "HTTPInterfaceManager.h"

/**
 * extend for feeds business.
 */
@interface HTTPInterfaceManager (Feeds)

-(id)getFeedTopicList:(NSDictionary*)userInfo;

/**
 * 获取固定列表中的动态记录
 * 
 * @param type 列表类型，0 最新 1 推荐 2 关注的人
 * @param page 起始页面，该值有效时，使用该值计算偏移，不用lastId。该值为0时用last_id
 * @param last_id 起始记录偏移
 * @param userInfo 透传的信息
 */
-(id)getFeedFixListWithType:(int)type page:(int)page lastId:(int)last_id userInfo:(NSDictionary*)userInfo;

/**
 * 获取话题列表或者指定人物的动态记录
 * 
 * @param type 类型，3为话题，4为通过aiai号查找
 * @param target 目标id。type为3时填写话题id，type为4时填写aiai号
 * @param page 起始页面，该值有效时，使用该值计算偏移，不用lastId。该值为0时用last_id
 * @param last_id 起始记录偏移
 * @param userInfo 透传的信息
 */
-(id)getFeedCustomListWithType:(int)type target:(int)target page:(int)page lastId:(int)last_id userInfo:(NSDictionary*)userInfo;

// 展示晒单列表
-(id)getFeedFlauntListWithType:(int)type target:(int)target page:(int)page goodId:(int)goods_id lastId:(int)last_id userInfo:(NSDictionary *)userInfo;

-(id)deleteFeed:(int32_t)feed_id userInfo:(NSDictionary*)userInfo;

-(id)praiseFeed:(int32_t)feed_id userInfo:(NSDictionary*)userInfo;

-(id)reportFeed:(int32_t)feed_id reason:(NSString*)reason userInfo:(NSDictionary*)userInfo;

-(id)getFeedDetail:(int32_t)feed_id userInfo:(NSDictionary*)userInfo;

-(id)getFeedCommentList:(int32_t)feed_id lastid:(int)lastid userInfo:(NSDictionary*)userInfo;

/**
 * 针对帖子进行评论或者对回复进行评论
 * 
 * @param feed_id 帖子id
 * @param cid 评论id，仅针对帖子评论，该值传0
 * @param content 评论内容
 * @param anonymous 是否匿名
 * @param userInfo 透传信息
 */
-(id)commentFeed:(int32_t)feed_id commentId:(int32_t)cid content:(NSString*)content anonymous:(int32_t)anonymous userInfo:(NSDictionary*)userInfo;


-(id)deleteFeedComment:(int32_t)comment_id userInfo:(NSDictionary*)userInfo;

-(id)reportFeedComment:(int32_t)comment_id ownerAiainum:(int32_t)aiainum reason:(NSString*)reason userInfo:(NSDictionary*)userInfo;

-(id)getFeedPraisedList:(int32_t)feed_id page:(int32_t)page userInfo:(NSDictionary*)userInfo;

-(id)getFeedNewTipsCount:(NSDictionary*)userInfo;

/**
 * 加载广告
 * 
 * @param type 广告类型
 * @param userInfo 透传
 */
-(id)feedAdConfigWithTableType:(int32_t)type userInfo:(NSDictionary*)userInfo;


/**
 * 加载广告（二位参数）
 * 
 * @param topic_id 话题id
 * @param userInfo 透传
 */
-(id)feedAdConfigWithType:(int32_t)type feedTopic:(int32_t)topic_id userInfo:(NSDictionary*)userInfo;


/**
 * 发布feed
 * 
 * @param content 文字内容，可为空
 * @param topic_id 话题id，无话题为0
 * @param anonymous 是否匿名
 * @param pics 图片资源，无图片时候为nil
 */
-(id)composeFeed:(NSString*)content topic:(int32_t)topic_id anonymous:(int32_t)anonymous pics:(NSArray*)pics userInfo:(NSDictionary*)userInfo;

-(id)composeFlaunt:(NSString *)content topic:(int32_t)topic_id goods:(int32_t)goods_id userInfo:(NSDictionary *)userInfo;

-(id)composeFlaunt:(NSString *)content pics:(NSArray *)pics topic:(int32_t)topic_id goods:(int32_t)goods_id userInfo:(id)userInfo;

-(id)uploadComposeFeedPictures:(NSArray*)pics userInfo:(NSDictionary*)userInfo;

-(id)composeCertify:(NSString *)content pics:(NSArray *)pics userInfo:(id)userInfo;
/**
 * 发表到朋友圈中
 *
 * @param content 文字内容
 * @param pics 图片内容
 * @param userInfo 透传
 */
-(id)composeMoments:(NSString *)content pics:(NSArray *)pics userInfo:(id)userInfo;

/**
 * 全部提醒
 * @param type 分页
 * @param userInfo 透传信息
 */
-(id)getFeedAllTipsList:(int32_t)offset userInfo:(NSDictionary *)userInfo;

/**
 * 删除全部提醒
 */
-(id)clearAllTips:(NSDictionary*)userInfo;

/**
 * 删除单条提醒
 */
-(id)deleteOneTips:(int32_t)tips_id userInfo:(NSDictionary*)userInfo;

-(id)getRedPointInfo:(id)userInfo;

/**
 * VIP)置顶个人动态
 * 
 * @param feed_id 动态id
 * @param type 0:取消置顶， 1：置顶
 * @param userInfo 透传
 */
-(id)stickFeedToTop:(int32_t)feed_id type:(int32_t)type  userInfo:(NSDictionary*)userInfo;


//获取我的圈子内容
- (id)fetchMineMoments;

//获取所有圈子列表
-(id)fetchAllCircleByPage:(int)page userInfo:(NSDictionary *)userInfo;

//获取推荐的圈子内容
- (id)fetchRecommondMoments;
//全部列表右边列表
- (id)fetchTopicList;
//全部列表左边列表
- (id)fetchTopicClassList;
//关注圈子
- (id)focusTopic:(NSInteger)topicID;
//取消关注圈子
- (id)cancelFocusTopic:(NSInteger)topicID;
//获取发布动态时的圈子列表
- (id)getFilterTipicList;
//判断当前用户在当前话题有没有权限
- (id)checkAddFeedsPermission:(NSInteger)topic_id;
//获取推荐热门话题列表
- (id)getHotTalkRecommendList;
//获取热门话题列表
- (id)getHotTalkPage:(int)page limit:(int)limit userInfo:(NSDictionary *)userInfo;
//获取推荐圈子列表
-(id)getCircleRecommendList;
@end


