//
//  CommonSvrErrorHandler.h
//  Xiuxiu
//
//  Created by Mac on 15/4/14.
//  Copyright (c) 2015年 yangdeger@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 处理服务器返回错误公共类
 */
@interface CommonSvrErrorHandler : NSObject<UIAlertViewDelegate> {
    
}

+(instancetype)sharedHandler;

/**
 * 处理Token不存在或过期的情况
 * 
 * @param result 错误信息字典
 * @return 错误是否被处理
 */
-(BOOL)handlerErrorResultTokenInvalid:(NSDictionary*)result;


/**
 * 默认处理错误操作，将服务器返回的msg弹出提示用户
 * 
 * @param result 错误信息字典
 */
-(void)handlerErrorResultUsingDefaultAction:(NSDictionary*)result;


@end
