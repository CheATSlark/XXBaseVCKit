//
//  HTTPInterfaceManager+Qiniu.m
//  Xiuxiu
//
//  Created by xiaoaiai on 2017/6/24.
//  Copyright © 2017年 yangdeger@gmail.com. All rights reserved.
//

#import "HTTPInterfaceManager+Qiniu.h"

@implementation HTTPInterfaceManager (Qiniu)

- (id)getQiniuToken {
    NSDictionary *param = [self addCommomParameters:@{}];
    NSString *json_value = [self genPackedJsonStringWithParameters:param];
    NSDictionary *final_value = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIGetQiniuToken parameters:final_value userInfo:nil];
}

- (id)getQnVoiceToken {
    NSDictionary *param = [self addCommomParameters:@{}];
    NSString *json_value = [self genPackedJsonStringWithParameters:param];
    NSDictionary *final_value = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIGetQnVoiceToken parameters:final_value userInfo:nil];
}

- (id)getOSSQiniuToken {
    NSDictionary *param = [self addCommomParameters:@{}];
    NSString *json_value = [self genPackedJsonStringWithParameters:param];
    NSDictionary *final_value = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIGetOSSQiniuToken parameters:final_value userInfo:nil];
    
}

@end
