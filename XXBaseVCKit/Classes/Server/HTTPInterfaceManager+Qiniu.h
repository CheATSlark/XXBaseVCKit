//
//  HTTPInterfaceManager+Qiniu.h
//  Xiuxiu
//
//  Created by xiaoaiai on 2017/6/24.
//  Copyright © 2017年 yangdeger@gmail.com. All rights reserved.
//

#import "HTTPInterfaceManager.h"

@interface HTTPInterfaceManager (Qiniu)

- (id)getQiniuToken;

- (id)getQnVoiceToken;

- (id)getOSSQiniuToken;

@end
