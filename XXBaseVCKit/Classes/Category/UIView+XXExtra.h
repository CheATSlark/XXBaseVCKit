//
//  UIView+XXExtra.h
//  Xiuxiu
//
//  Created by Mac on 15/3/3.
//  Copyright (c) 2015年 yangdeger@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XXExtra)

-(UIView*)findFatherViewWithKindClass:(Class)klass;

-(UIViewController*)findViewControllerResponder;

#pragma mark - frame
@property(nonatomic) CGPoint origin;
@property(nonatomic) CGFloat originX;
@property(nonatomic) CGFloat originY;
@property(nonatomic) CGSize  size;
@property(nonatomic) CGFloat width;
@property(nonatomic) CGFloat height;
@property(nonatomic) CGFloat centerX;
@property(nonatomic) CGFloat centerY;

@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat bottom;

@end
