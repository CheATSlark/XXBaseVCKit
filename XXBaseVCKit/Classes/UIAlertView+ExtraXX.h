//
//  UIAlertView+ExtraXX.h
//  Xiuxiu
//
//  Created by Mac on 15/2/26.
//  Copyright (c) 2015年 yangdeger@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (ExtraXX)
+(void)showAlertWithMessage:(NSString*)msg;
+(void)showAlertWithTitle:(NSString*)title message:(NSString*)msg;
+(void)showAlertWithTitle:(NSString *)title message:(NSString *)msg cancelButtonTitle:(NSString*)ctitle;
+(void)showAlertWithTag:(NSInteger)tag delegate:(id<UIAlertViewDelegate>)delegate title:(NSString*)title message:(NSString*)msg buttonText:(NSString*)buttonText,...;
@end
