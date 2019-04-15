//
//  HTTPInterfaceAddress.h
//  Xiuxiu
//
//  Created by Mac on 15/6/27.
//  Copyright (c) 2015年 yangdeger@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTTPInterfaceManager.h"
/**
 * 获取到接口的链接地址
 */
@interface HTTPInterfaceAddress : NSObject {
}

/**
 * 获取到接口的链接地址，suffix用于mta接口上报用
 */
+(NSString*)interfaceAddressWithID:(XXInterfaceId)iid suffix:(NSString**)suffix;


//+(NSString*)interfaceAddressWithID2:(XXInterfaceId)iid suffix:(NSString**)suffix;

@end
