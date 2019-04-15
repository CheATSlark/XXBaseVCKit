//
//  HTTPInterfaceManager+ShortVideo.h
//  Xiuxiu
//
//  Created by xiaoaiai on 2017/6/29.
//  Copyright © 2017年 yangdeger@gmail.com. All rights reserved.
//

#import "HTTPInterfaceManager.h"

@interface HTTPInterfaceManager (ShortVideo)

- (id)fetchShortVideoList:(NSInteger)topic_id Page:(NSInteger)page FeedID:(NSString *)feed_id;

-(id)fetchVideoListPage:(NSInteger)page userInfo:(NSDictionary *)userInfo;

-(id)fetchMyVideoListPage:(NSInteger)page userInfo:(NSDictionary *)userInfo;

- (id)fetchShortVideoDetail:(NSString *)feed_id;

-(id)fetchShortVideoMusicList;

-(id)deleteVideo:(int)video_id userInfo:(NSDictionary *)userInfo;
@end
