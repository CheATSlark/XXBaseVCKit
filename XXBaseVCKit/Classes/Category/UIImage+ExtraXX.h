//
//  UIImage+ExtraXX.h
//  Xiuxiu
//
//  Created by Mac on 15/3/26.
//  Copyright (c) 2015年 yangdeger@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ExtraXX)
+(UIImage*)imageWithColor:(UIColor*)color;
+(UIImage*)imageWithColor:(UIColor*)color size:(CGSize)size;

+(UIImage*)imageWithBorderColor:(UIColor*)bcolor fillColor:(UIColor*)fcolor radius:(CGFloat)radius size:(CGSize)size;

+(UIImage*)transparentImageWithColor:(UIColor*)color size:(CGSize)size;

/**
 * 从一张一般图片生成一个带光晕的圆形头像图
 * 
 * @param pfimage 需要处理图片
 * @param hcolor 光晕颜色
 * @param radius 光晕宽度
 * @return 处理后图片
 */
+(UIImage*)profileImage:(UIImage*)pfimage haloColor:(UIColor*)hcolor haloRadius:(CGFloat)radius;

/**
 *  从一张图片生成一个方圆形光晕头像
 *
 *  @param pfimage 需处理图片
 *  @param hcolor  光晕颜色
 *  @param hRadius 光晕宽度
 *  @param radius  倒角的半径
 *
 *  @return 处理后图片
 */
+(UIImage *)profileRectCirImage:(UIImage *)pfimage haloColor:(UIColor *)hcolor haloRadius:(CGFloat)hRadius chamfer:(CGFloat)radius;

+(UIImage*)feedImageSize:(CGSize)size withFeedText:(NSString*)text;

-(UIImage*)scaleToSize:(CGSize)size;

-(UIImage*)clipToSize:(CGSize)size;

-(UIImage *)fixOrientation;

/**
	将图片上边和下边分别去掉指定的高度后得到更小的一张图片
	@param h1 上边去掉的高度
	@param h2 下边去掉的高度
	@returns 处理后的图片
 */
- (UIImage *)clipImageWithTopMargin:(CGFloat)h1 bottomMargin:(CGFloat)h2;

- (UIImage *)roundImageToSize:(CGSize)size;

+(UIImage *)ac_grayImage:(UIImage *)sourceImage;
@end
