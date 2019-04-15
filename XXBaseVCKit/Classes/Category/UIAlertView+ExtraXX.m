//
//  UIAlertView+ExtraXX.m
//  Xiuxiu
//
//  Created by Mac on 15/2/26.
//  Copyright (c) 2015年 yangdeger@gmail.com. All rights reserved.
//

#import "UIAlertView+ExtraXX.h"

@implementation UIAlertView (ExtraXX)

+(void)showAlertWithMessage:(NSString *)msg
{
    [UIAlertView showAlertWithTitle:nil message:msg];
}

+(void)showAlertWithTitle:(NSString *)title message:(NSString *)msg
{
    [UIAlertView showAlertWithTag:0 delegate:nil title:title message:msg buttonText:@"我知道啦",nil];
}


+(void)showAlertWithTitle:(NSString *)title message:(NSString *)msg cancelButtonTitle:(NSString *)ctitle
{
    [UIAlertView showAlertWithTag:0 delegate:nil title:title message:msg buttonText:@"我知道啦",nil];
}


+(void)showAlertWithTag:(NSInteger)tag delegate:(id<UIAlertViewDelegate>)delegate title:(NSString *)title message:(NSString *)msg buttonText:(NSString *)buttonText, ...
{
    NSString* tt = title == nil ? @"" : title; //workaround iOS 8 's bold msg problem
    UIAlertView* av = [[UIAlertView alloc] initWithTitle:tt message:msg delegate:delegate cancelButtonTitle:buttonText otherButtonTitles: nil];
    
    //显示多个button 的代码
    va_list args;
    va_start(args, buttonText);
    NSString *anOtherButtonTitle = va_arg(args, NSString*);
    for (; anOtherButtonTitle != nil; anOtherButtonTitle = va_arg(args, NSString*)) {
        [av addButtonWithTitle:anOtherButtonTitle];
    }
    va_end(args);
    
    av.tag = tag;
    [av show];
}

@end
