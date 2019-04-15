//
//  HTTPInterfaceManager+FaceView.m
//  Xiuxiu
//
//  Created by xiaoaiai on 2016/10/19.
//  Copyright © 2016年 yangdeger@gmail.com. All rights reserved.
//

#import "HTTPInterfaceManager+FaceView.h"

@implementation HTTPInterfaceManager (FaceView)

- (id)fetchFaceViewList:(NSInteger)page {
    NSDictionary *param = [self addCommomParameters:@{@"limit":@(15),@"page":@(page)}];
    NSString *json_value = [self genPackedJsonStringWithParameters:param];
    NSDictionary *final_value = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIFaceViewList parameters:final_value userInfo:nil];
}

- (id)fetchFaceManagerList {
    NSDictionary *param = [self addCommomParameters:@{}];
    NSString *json_value = [self genPackedJsonStringWithParameters:param];
    NSDictionary *final_value = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIFaceManagerList parameters:final_value userInfo:nil];
}


- (id)sortFaceViewList:(NSDictionary *)sortedList {
    NSDictionary *param = [self addCommomParameters:@{@"ids_sort":sortedList}];
    NSString *json_value = [self genPackedJsonStringWithParameters:param];
    NSDictionary *final_value = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XISortFaceViewList parameters:final_value userInfo:nil];
}


- (id)fetchFacePackageList:(int)package_id userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"face_pack_id":@(package_id)};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIFacePackageDown parameters:final_params userInfo:userInfo];
}

- (id)deleteFaceView:(NSString *)faceID userInfo:(NSDictionary *)userInfo{
    NSDictionary *param = [self addCommomParameters:@{@"face_pack_id":faceID}];
    NSString *json_value = [self genPackedJsonStringWithParameters:param];
    NSDictionary *final_value = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIDeleteFaceView parameters:final_value userInfo:userInfo];
}

@end
