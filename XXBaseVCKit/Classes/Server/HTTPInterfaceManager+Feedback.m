//
//  HTTPInterfaceManager+Feedback.m
//  Xiuxiu
//
//  Created by xiaoaiai on 16/8/22.
//  Copyright © 2016年 yangdeger@gmail.com. All rights reserved.
//

#import "HTTPInterfaceManager+Feedback.h"
#import "NSString+ExtraXX.h"

@implementation HTTPInterfaceManager (Feedback)

- (id)submitNewFeedbackWithContent:(NSString *)content ClassId:(NSInteger)classId PicPaths:(NSArray *)picPaths AiaiNum:(NSString *)aiaiNum Type:(NSInteger)type {
    
    NSDictionary *param = nil;
    
    //把地址的数字拼上
    if (picPaths !=nil && picPaths.count>0) {
        NSMutableDictionary *picPathsDic = [NSMutableDictionary dictionary];
        for (int i = 1; i <= picPaths.count; i ++) {
            [picPathsDic setObject:picPaths[i-1] forKey:[NSString stringWithFormat:@"pic_%d",i]];
        }
        if (type == 1) {
            [picPathsDic addEntriesFromDictionary: @{@"content":content,@"class_id":@(classId),@"sys_version":[[UIDevice currentDevice] systemVersion],@"device":[NSString iPhoneTypeString],@"type":@(type)}];
        } else if (type == 2) {
            [picPathsDic addEntriesFromDictionary: @{@"content":content,@"class_id":@(classId),@"sys_version":[[UIDevice currentDevice] systemVersion],@"device":[NSString iPhoneTypeString],@"type":@(type),@"be_reported_aiainum":aiaiNum}];
        }
        
        param = [self addCommomParameters:picPathsDic];
    } else {
        if (type == 1) {
            param = [self addCommomParameters:@{@"content":content,@"class_id":@(classId),@"sys_version":[[UIDevice currentDevice] systemVersion],@"device":[NSString iPhoneTypeString],@"type":@(type)}];
        } else if (type == 2) {
            param = [self addCommomParameters:@{@"content":content,@"class_id":@(classId),@"sys_version":[[UIDevice currentDevice] systemVersion],@"device":[NSString iPhoneTypeString],@"type":@(type),@"be_reported_aiainum":aiaiNum}];
        }
        
    }
    
    NSString *json_value = [self genPackedJsonStringWithParameters:param];
    NSDictionary *final_value = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XISubmitFeedback parameters:final_value userInfo:nil];

}


- (id)getFeedbackRecordList:(NSInteger)page Limit:(NSInteger)limit {
    NSDictionary *param = [self addCommomParameters:@{@"page":@(page),@"limit":@(limit)}];
    NSString *json_value = [self genPackedJsonStringWithParameters:param];
    NSDictionary *final_value = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIFeedbackList parameters:final_value userInfo:nil];

}

- (id)getFeedbackDetailInfo:(NSInteger)feed_back_id Page:(NSInteger)page Limit:(NSInteger)limit{
    NSDictionary *param = [self addCommomParameters:@{@"feed_back_id":@(feed_back_id),@"page":@(page),@"limit":@(limit)}];
    NSString *json_value = [self genPackedJsonStringWithParameters:param];
    NSDictionary *final_value = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIFeedbackDetail parameters:final_value userInfo:nil];
}

- (id)sendFeedbackComment:(NSInteger)feed_back_id Content:(NSString *)content {
    NSDictionary *param = [self addCommomParameters:@{@"feed_back_id":@(feed_back_id),@"reply_content":content}];
    NSString *json_value = [self genPackedJsonStringWithParameters:param];
    NSDictionary *final_value = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIFeedbackComment parameters:final_value userInfo:nil];
}

@end
