//
//  IPModel.h
//  Xiuxiu
//
//  Created by Mac on 15/6/27.
//  Copyright (c) 2015年 yangdeger@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IPModel : NSObject {
    
}
@property (nonatomic,strong) NSString* ipOrDomain;
@property (nonatomic,assign) uint32_t port;
@property (nonatomic,assign) int32_t priority;
@end
