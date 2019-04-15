//
//  HTTPInterfaceManager+Feedback.h
//  Xiuxiu
//
//  Created by xiaoaiai on 16/8/22.
//  Copyright © 2016年 yangdeger@gmail.com. All rights reserved.
//

#import "HTTPInterfaceManager.h"

@interface HTTPInterfaceManager (Feedback)

- (id)submitNewFeedbackWithContent:(NSString *)content ClassId:(NSInteger)classId PicPaths:(NSArray *)picPaths AiaiNum:(NSString *)aiaiNum Type:(NSInteger)type;

- (id)getFeedbackRecordList:(NSInteger)page Limit:(NSInteger)limit;

- (id)getFeedbackDetailInfo:(NSInteger)feed_back_id Page:(NSInteger)page Limit:(NSInteger)limit;

- (id)sendFeedbackComment:(NSInteger)feed_back_id Content:(NSString *)content;

@end
