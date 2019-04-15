//
//  HTTPInterfaceManager+InvitePlay.h
//  Xiuxiu
//
//  Created by xiaoaiai on 2017/2/22.
//  Copyright © 2017年 yangdeger@gmail.com. All rights reserved.
//

#import "HTTPInterfaceManager.h"

@interface HTTPInterfaceManager (InvitePlay)

- (id)fetchInvitePlayUsers:(int)limit Page:(int)page;

@end
