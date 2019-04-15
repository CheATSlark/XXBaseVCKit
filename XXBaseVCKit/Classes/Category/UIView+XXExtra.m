//
//  UIView+XXExtra.m
//  Xiuxiu
//
//  Created by Mac on 15/3/3.
//  Copyright (c) 2015年 yangdeger@gmail.com. All rights reserved.
//

#import "UIView+XXExtra.h"

@implementation UIView (XXExtra)

-(UIView *)findFatherViewWithKindClass:(Class)klass
{
    UIView* tmp = [self superview];
    while (![tmp isKindOfClass:klass] && (tmp = [tmp superview]) != nil) {
        //doing nothing
    }
    return tmp;
}

-(UIViewController *)findViewControllerResponder
{
    id responder = self.nextResponder;
    while (responder != nil && ![responder isKindOfClass:[UIViewController class]]) {
        responder = [responder nextResponder];
    }
    return responder;
}

- (CGFloat)width{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)w{
    CGRect rect = self.frame;
    rect.size.width = w;
    self.frame = rect;
}

- (CGFloat)height{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height{
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
}

- (CGFloat)originX{
    return self.frame.origin.x;
}

- (CGFloat)originY{
    return self.frame.origin.y;
}

- (void)setOriginX:(CGFloat)originX{
    CGRect rect = self.frame;
    rect.origin.x = originX;
    self.frame = rect;
}

- (void)setOriginY:(CGFloat)originY{
    CGRect rect = self.frame;
    rect.origin.y = originY;
    self.frame = rect;
}

- (CGPoint)origin{
    return self.frame.origin;
}

- (CGSize)size{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin{
    CGRect rect = self.frame;
    rect.origin = origin;
    self.frame = rect;
}

- (void)setSize:(CGSize)size{
    CGRect rect = self.frame;
    rect.size = size;
    self.frame = rect;
}

- (CGFloat)centerX{
    return self.center.x;
}

- (CGFloat)centerY{
    return self.center.y;
}

- (void)setCenterX:(CGFloat)centerX{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (void)setCenterY:(CGFloat)centerY{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)top {
    return self.originY;
}

- (void)setTop:(CGFloat)top {
    CGRect rect = self.frame;
    rect.origin.y = top;
    self.frame = rect;
}

- (CGFloat)bottom {
    return self.height + self.top;
}

- (void)setBottom:(CGFloat)bottom {
    self.originY = self.superview.height - bottom - self.height;
}

- (CGFloat)left {
    return self.originX;
}

- (void)setLeft:(CGFloat)left {
    self.originX = left;
}

- (CGFloat)right {
    return self.originX + self.width;
}

- (void)setRight:(CGFloat)right {
//    self.width = right;
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

@end
