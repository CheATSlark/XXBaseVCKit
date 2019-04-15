//
//  HTTPInterfaceManager+FaceView.h
//  Xiuxiu
//
//  Created by xiaoaiai on 2016/10/19.
//  Copyright © 2016年 yangdeger@gmail.com. All rights reserved.
//

#import "HTTPInterfaceManager.h"

@interface HTTPInterfaceManager (FaceView)

- (id)fetchFaceViewList:(NSInteger)page;

- (id)fetchFaceManagerList;


- (id)sortFaceViewList:(NSDictionary *)sortedList;


- (id)fetchFacePackageList:(int)package_id userInfo:(NSDictionary *)userInfo;

- (id)deleteFaceView:(NSString *)faceID userInfo:(NSDictionary *)userInfo;

@end
