//
//  CommonSvrErrorHandler.m
//  Xiuxiu
//
//  Created by Mac on 15/4/14.
//  Copyright (c) 2015年 yangdeger@gmail.com. All rights reserved.
//

#import "CommonSvrErrorHandler.h"
//#import "UtilityToolkit.h"
//#import "AccountManager.h"
#import "UIAlertView+ExtraXX.h"
//#import "XXUserEntryViewController.h"
//#import "XXAppDelegate.h"
//#import "XXControlManager.h"

CommonSvrErrorHandler* gIntance;

@implementation CommonSvrErrorHandler

+(instancetype)sharedHandler
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        gIntance = [[CommonSvrErrorHandler alloc] init];
    });
    return gIntance;
}

//-(BOOL)handlerErrorResultTokenInvalid:(NSDictionary *)result
//{
//    BOOL rtn = NO;
//    int errcode = dictionary_get_int(result, @"errorcode", -1);
//    if (errcode == 4017 || errcode == 4026) { //已经过期,或token无效
//        AccountManager* am = [AccountManager sharedManager];
//        [am clearToken];
//        NSString* errMsg = dictionary_get_nsstring(result, @"errormsg", @"");
//        dispatch_async(dispatch_get_main_queue(), ^{
//            //提示外部token已经无效
//            [[NSNotificationCenter defaultCenter] postNotificationName:kXXNotificationKey_UserLoginStatusChange object:nil userInfo:@{@"msg":@"token invalide"}];
//            
//            [UIAlertView showAlertWithTag:1 delegate:self title:LT("title.alert.local.hint") message:errMsg buttonText:LT("title.alert.confirm"),nil];
//            
//            //做其他的登出处理！
//            AccountManager* am = [AccountManager sharedManager];
//            [am logout];
//            [am chatLogout];
//            [am jpushLogout];
//            
//        });
//        rtn = YES;
//    }
//    else if(errcode == -1001) { //本地错误:环信单点被T
//        AccountManager* am = [AccountManager sharedManager];
//        [am clearToken];
//        NSString* errMsg = dictionary_get_nsstring(result, @"errormsg", @"");
//        dispatch_async(dispatch_get_main_queue(), ^{
//            //提示外部token已经无效
//            [[NSNotificationCenter defaultCenter] postNotificationName:kXXNotificationKey_UserLoginStatusChange object:nil userInfo:@{@"msg":@"token invalide"}];
//            
//            [UIAlertView showAlertWithTag:1 delegate:self title:LT("title.alert.local.hint") message:errMsg buttonText:LT("title.alert.confirm"),nil];
//            
//            //做其他的登出处理！
//            AccountManager* am = [AccountManager sharedManager];
//            [am logout];
//            [am chatLogoutWithFlag:0];
//            [am jpushLogout];
//            
//        });
//        rtn = YES;
//    }
//    return rtn;
//    
//}

-(void)handlerErrorResultUsingDefaultAction:(NSDictionary *)result
{
//    int errcode = dictionary_get_int(result, @"errorcode", -1);
//    NSString* errMsg = dictionary_get_nsstring(result, @"errormsg", @"");
//    dispatch_async(dispatch_get_main_queue(), ^{
////        [UIAlertView showAlertWithTitle:[NSString stringWithFormat:@"错误（%d）",errcode] message:errMsg];
//        [UIAlertView showAlertWithTitle:LT("title.alert.svr.error") message:errMsg];
//    });
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
//    //切换到登录界面
//    UIStoryboard* sb = [UIStoryboard storyboardWithName:@"User" bundle:nil];
//    UINavigationController* nvc = [sb instantiateInitialViewController];
//    XXUserEntryViewController* uevc = [nvc viewControllers][0];
//    uevc.isLaunch = YES;
//    XXAppDelegate* appDelegate = (XXAppDelegate*)[[UIApplication sharedApplication] delegate];
//    appDelegate.window.rootViewController = nvc;
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"appdelegateRotaionNotfiy" object:@(NO)];
//    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
//        
//        
//        
//        SEL selector = NSSelectorFromString(@"setOrientation:");
//        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
//        [invocation setSelector:selector];
//        [invocation setTarget:[UIDevice currentDevice]];
//        int val = 0;
//
//        val = UIInterfaceOrientationPortrait;
//        
//        
//        
//        [invocation setArgument:&val atIndex:2];
//        [invocation invoke];
//    }
}

@end
