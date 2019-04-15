//
//  HTTPInterfaceManager+ShortVideo.m
//  Xiuxiu
//
//  Created by xiaoaiai on 2017/6/29.
//  Copyright © 2017年 yangdeger@gmail.com. All rights reserved.
//

#import "HTTPInterfaceManager+ShortVideo.h"

@implementation HTTPInterfaceManager (ShortVideo)

- (id)fetchShortVideoList:(NSInteger)topic_id Page:(NSInteger)page FeedID:(NSString *)feed_id {
    NSDictionary *param = [self addCommomParameters:@{@"topic_id":@(topic_id),@"page":@(page),@"limit":@(15),@"feed_id":feed_id}];
    NSString *json_value = [self genPackedJsonStringWithParameters:param];
    NSDictionary *final_value = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIGetShortVideoList parameters:final_value userInfo:nil];
}

-(id)fetchVideoListPage:(NSInteger)page userInfo:(NSDictionary *)userInfo{
    NSDictionary *param = [self addCommomParameters:@{@"page":@(page),@"limit":@(15)}];
    NSString *json_value = [self genPackedJsonStringWithParameters:param];
    NSDictionary *final_value = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIGetShortVideoList parameters:final_value userInfo:nil];
}

-(id)fetchMyVideoListPage:(NSInteger)page userInfo:(NSDictionary *)userInfo
{
    NSDictionary *param = [self addCommomParameters:@{@"page":@(page),@"limit":@(15)}];
    NSString *json_value = [self genPackedJsonStringWithParameters:param];
    NSDictionary *final_value = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIGetMyShortVideoList parameters:final_value userInfo:nil];
}


- (id)fetchShortVideoDetail:(NSString *)feed_id {
    NSDictionary *param = [self addCommomParameters:@{@"feed_id":feed_id}];
    NSString *json_value = [self genPackedJsonStringWithParameters:param];
    NSDictionary *final_value = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIGetShortVideoDetail parameters:final_value userInfo:nil];

}

-(id)fetchShortVideoMusicList
{
    NSDictionary *param = [self addCommomParameters:@{}];
    NSString *json_value = [self genPackedJsonStringWithParameters:param];
    NSDictionary *final_value = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIGetShortVideoMusicList parameters:final_value userInfo:nil];

}

-(id)deleteVideo:(int)video_id userInfo:(NSDictionary *)userInfo{
    NSDictionary *param = [self addCommomParameters:@{@"video_id":@(video_id),@"remove_video":@(1)}];
    NSString *json_value = [self genPackedJsonStringWithParameters:param];
    NSDictionary *final_value = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIDeleteShortVideo parameters:final_value userInfo:nil];
}

@end
