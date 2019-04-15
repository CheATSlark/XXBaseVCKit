//
//  UIImage+ExtraXX.m
//  Xiuxiu
//
//  Created by Mac on 15/3/26.
//  Copyright (c) 2015年 yangdeger@gmail.com. All rights reserved.
//

#import "UIImage+ExtraXX.h"

@implementation UIImage (ExtraXX)

+(UIImage*)imageWithColor:(UIColor *)color
{
    return [UIImage imageWithColor:color size:CGSizeMake(1, 1)];
}

+(UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    CGContextRef con = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(con, color.CGColor);
    CGContextFillRect(con, (CGRect){CGPointZero, size});
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+(UIImage *)imageWithBorderColor:(UIColor *)bcolor fillColor:(UIColor *)fcolor radius:(CGFloat)radius size:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();

    CGFloat width = size.width;
    CGFloat height = size.height;
    
//    [fcolor setFill];
//    CGContextFillRect(ctx, CGRectMake(0, 0, width, height));
    
    //border
    CGContextMoveToPoint(ctx, width - radius, 0);
    CGContextAddLineToPoint(ctx, radius, 0);
    CGContextAddArc(ctx, radius, radius, radius, M_PI+M_PI_2, M_PI, 1);
    
    CGContextAddLineToPoint(ctx, 0, height - radius);
    CGContextAddArc(ctx, radius, height - radius, radius, M_PI, M_PI_2, 1);
    
    CGContextAddLineToPoint(ctx, width-radius, height);
    CGContextAddArc(ctx, width-radius, height-radius, radius, M_PI_2, 0, 1);
    
    CGContextAddLineToPoint(ctx, width, radius);
    CGContextAddArc(ctx, width-radius, radius, radius, M_PI * 2, M_PI+M_PI_2, 1);

    CGContextClosePath(ctx);
    
//    [fcolor setFill];
//    CGContextFillPath(ctx);
    
    [bcolor setStroke];
    CGContextSetLineWidth(ctx, 1.0);
    CGContextStrokePath(ctx);
    

    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+(UIImage *)transparentImageWithColor:(UIColor *)color size:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef con = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(con, color.CGColor);
    CGContextFillRect(con, (CGRect){CGPointZero, size});
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+(UIImage *)profileImage:(UIImage *)pfimage haloColor:(UIColor *)hcolor haloRadius:(CGFloat)radius
{
    @autoreleasepool {
        CGFloat of = MIN(pfimage.size.width, pfimage.size.height);
        CGSize size = CGSizeMake(of, of);
        UIGraphicsBeginImageContext(size);
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        
        //glum
        CGFloat glum_radius = radius;
        CGContextSetLineWidth(ctx, glum_radius);
        [hcolor setStroke];
        CGContextAddArc(ctx, of/2, of/2, (of-glum_radius)/2, 0, 2*M_PI, 0);
        CGContextDrawPath(ctx, kCGPathStroke);
        
        //image
        CGMutablePathRef cpath = CGPathCreateMutable();
        CGPathAddArc(cpath, NULL, of/2, of/2, of/2-glum_radius, 0, 2*M_PI, 0);
        CGContextAddPath(ctx, cpath);
        CGPathRelease(cpath);
        CGContextClip(ctx);
        [pfimage drawAtPoint:CGPointZero];
        
        UIImage* rtn = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return rtn;
    }
}

+(UIImage *)profileRectCirImage:(UIImage *)pfimage haloColor:(UIColor *)hcolor haloRadius:(CGFloat)hRadius chamfer:(CGFloat)radius
{
    @autoreleasepool {
        CGFloat of = MIN(pfimage.size.width, pfimage.size.height);
        CGSize size = CGSizeMake(of, of);
        UIGraphicsBeginImageContext(size);
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        
        //glum
        CGFloat glum_radius = hRadius;
        [hcolor setStroke];
        CGContextSetFillColorWithColor(ctx, hcolor.CGColor);
        
        CGContextMoveToPoint(ctx, of - radius, 0);
        CGContextAddLineToPoint(ctx, radius, 0);
        CGContextAddArc(ctx, radius, radius, radius, M_PI+M_PI_2, M_PI, 1);
        
        CGContextAddLineToPoint(ctx, 0, of - radius);
        CGContextAddArc(ctx, radius, of - radius, radius, M_PI, M_PI_2, 1);
        
        CGContextAddLineToPoint(ctx, of-radius, of);
        CGContextAddArc(ctx, of-radius, of-radius, radius, M_PI_2, 0, 1);
        
        CGContextAddLineToPoint(ctx, of, radius);
        CGContextAddArc(ctx, of-radius, radius, radius, M_PI * 2, M_PI+M_PI_2, 1);
        
        CGContextDrawPath(ctx, kCGPathFill);
        
        //image
        CGMutablePathRef cpath = CGPathCreateMutable();
        
        CGPathMoveToPoint(cpath, NULL, of-radius-glum_radius, glum_radius);
        CGPathAddLineToPoint(cpath, NULL, radius+glum_radius, glum_radius);
        CGPathAddArc(cpath, NULL, radius+glum_radius, radius+glum_radius, radius, M_PI+M_PI_2, M_PI, 1);
        CGPathAddLineToPoint(cpath, NULL, glum_radius, of-radius-glum_radius);
        CGPathAddArc(cpath, NULL, radius+glum_radius, of-radius-glum_radius, radius, M_PI, M_PI_2, 1);
        
        CGPathAddLineToPoint(cpath, NULL, of-radius-glum_radius, of-glum_radius);
        CGPathAddArc(cpath, NULL, of-radius-glum_radius, of-radius-glum_radius, radius, M_PI_2, 0, 1);
        
        CGPathAddLineToPoint(cpath, NULL, of-glum_radius, radius+glum_radius);
        CGPathAddArc(cpath, NULL, of-radius-glum_radius, radius+glum_radius, radius, M_PI*2, M_PI+M_PI_2, 1);
        
        
        CGContextAddPath(ctx, cpath);
        CGPathRelease(cpath);
        CGContextClip(ctx);
        [pfimage drawAtPoint:CGPointZero];
        
        UIImage* rtn = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return rtn;
    }
}


+(UIImage *)feedImageSize:(CGSize)size withFeedText:(NSString *)text
{
    @autoreleasepool {
        CGFloat scale = [UIScreen mainScreen].scale;
        size = CGSizeMake(size.width * scale, size.height * scale);
        UIGraphicsBeginImageContextWithOptions(size, YES, scale);
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        
        //background color
        // 0x999999
        //[UIColor colorWithRed:((0xfafafa&0xFF0000)>>16)/255.0 green:((0xfafafa&0xFF00)>>8)/255.0 blue:(0xfafafa&0xFF)/255.0 alpha:1]
        
        CGContextSetFillColorWithColor(ctx, [[UIColor colorWithRed:((0xfafafa&0xFF0000)>>16)/255.0 green:((0xfafafa&0xFF00)>>8)/255.0 blue:(0xfafafa&0xFF)/255.0 alpha:1] CGColor]);
        CGContextFillRect(ctx, CGRectMake(0, 0, size.width, size.height));
        
        NSMutableParagraphStyle *ps = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        [ps setAlignment:NSTextAlignmentCenter];
        NSDictionary* attr = @{NSFontAttributeName:[UIFont systemFontOfSize:20.0]
                               ,NSParagraphStyleAttributeName:ps
                               ,NSForegroundColorAttributeName:[UIColor colorWithRed:((0x999999&0xFF0000)>>16)/255.0 green:((0x999999&0xFF00)>>8)/255.0 blue:(0x999999&0xFF)/255.0 alpha:1]};
        
        //calc size
        CGFloat margin = 10;
        CGRect rect = (CGRect){.size=size, .origin={0, 0} };
        CGRect mrect = CGRectInset(rect, margin, margin); //留出边界
        
        
        CGSize esize = [text boundingRectWithSize:(CGSize){.width=mrect.size.width,20000} options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
        esize.height = (esize.height > mrect.size.height) ? mrect.size.height : esize.height;
        esize.width  = (esize.width > mrect.size.width) ? mrect.size.width : esize.width; //计算后调整到正好在可以绘制的矩形内
        
        CGRect drect = CGRectMake((mrect.size.width-esize.width)/2, (mrect.size.height-esize.height)/2, esize.width, esize.height); //居中绘制：计算出应该绘制到的位置
        drect = CGRectOffset(drect, margin, margin);
        
        //    DDLogInfo(@"text = %@, esize=%@, drect = %@",text,NSStringFromCGSize(esize),NSStringFromCGRect(drect));
        
        [text drawInRect:drect withAttributes:attr];
        
        UIImage* rtn = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return rtn;
    }
}

-(UIImage *)scaleToSize:(CGSize)newSize
{
    if(self.size.width < newSize.width || self.size.height < newSize.height)
    {
        return self;
    }
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [self drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

-(UIImage *)clipToSize:(CGSize)size
{
    @autoreleasepool {
        UIImage* image = self;
        float r = size.width / size.height;
        float r1 = image.size.width / image.size.height;
        CGRect rect = CGRectZero;
        if (r1 > r) { // h -> v
            rect.size.height = image.size.height;
            rect.size.width = image.size.height * r;
            rect.origin.x = (image.size.width - rect.size.width) / 2;
        }else{
            rect.size.width = image.size.width;
            rect.size.height = image.size.width / r;
        }
        //    DDLogInfo(@"Image:[%.lf %.lf]  size:[%.lf  %.lf] -》 %@",image.size.width,image.size.height, size.width,size.height,NSStringFromCGRect(rect));
        CGImageRef img = CGImageCreateWithImageInRect([image CGImage], rect);
        UIImage* rtn = [[UIImage alloc] initWithCGImage:img];
        CGImageRelease(img);
        return rtn;
    }
}


-(UIImage *)roundImageToSize:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //background
    CGContextSetFillColorWithColor(ctx, [[UIColor whiteColor] CGColor]);
    CGContextFillRect(ctx, (CGRect){CGPointZero, size});
    //main content
    CGMutablePathRef cpath = CGPathCreateMutable();
    CGFloat of = MIN(self.size.width, self.size.height);
    CGPathAddArc(cpath, NULL, of/2, of/2, of/2, 0, 2*M_PI, 0);
    CGContextAddPath(ctx, cpath);
    CGPathRelease(cpath);
    CGContextClip(ctx);
    [self drawAtPoint:CGPointZero];
    
    UIImage* rtn = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return rtn;
}

- (UIImage *)fixOrientation {
    @autoreleasepool {
        UIImage *aImage = self;
        if (aImage==nil || !aImage) {
            return nil;
        }
        // No-op if the orientation is already correct
        if (aImage.imageOrientation == UIImageOrientationUp) return aImage;
        
        // We need to calculate the proper transformation to make the image upright.
        // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
        CGAffineTransform transform = CGAffineTransformIdentity;
        UIImageOrientation orientation=aImage.imageOrientation;
        int orientation_=orientation;
        switch (orientation_) {
            case UIImageOrientationDown:
            case UIImageOrientationDownMirrored:
                transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
                transform = CGAffineTransformRotate(transform, M_PI);
                break;
                
            case UIImageOrientationLeft:
            case UIImageOrientationLeftMirrored:
                transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
                transform = CGAffineTransformRotate(transform, M_PI_2);
                break;
                
            case UIImageOrientationRight:
            case UIImageOrientationRightMirrored:
                transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
                transform = CGAffineTransformRotate(transform, -M_PI_2);
                break;
        }
        
        switch (orientation_) {
            case UIImageOrientationUpMirrored:{
                
            }
            case UIImageOrientationDownMirrored:
                transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
                transform = CGAffineTransformScale(transform, -1, 1);
                break;
                
            case UIImageOrientationLeftMirrored:
            case UIImageOrientationRightMirrored:
                transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
                transform = CGAffineTransformScale(transform, -1, 1);
                break;
        }
        
        // Now we draw the underlying CGImage into a new context, applying the transform
        // calculated above.
        CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                                 CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                                 CGImageGetColorSpace(aImage.CGImage),
                                                 CGImageGetBitmapInfo(aImage.CGImage));
        CGContextConcatCTM(ctx, transform);
        switch (aImage.imageOrientation) {
            case UIImageOrientationLeft:
            case UIImageOrientationLeftMirrored:
            case UIImageOrientationRight:
            case UIImageOrientationRightMirrored:
                // Grr...
                CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
                break;
                
            default:
                CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
                break;
        }
        
        // And now we just create a new UIImage from the drawing context
        CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
        UIImage *img = [UIImage imageWithCGImage:cgimg];
        CGContextRelease(ctx);
        CGImageRelease(cgimg);
        aImage=img;
        img=nil;
        return aImage;
    }
}

-(UIImage *)clipImageWithTopMargin:(CGFloat)h1 bottomMargin:(CGFloat)h2
{
    CGFloat h = self.size.height;
    if (h1 + h2 > h) {
        return self;
    }
    @autoreleasepool {
        CGRect rect = CGRectMake(0, h1, self.size.width, h-h1-h2);
        CGImageRef imgRef = self.CGImage;
        CGImageRef rtnImgRef = CGImageCreateWithImageInRect(imgRef, rect);
        UIImage* rtn = nil;
        if (rtnImgRef != NULL) {
            rtn = [UIImage imageWithCGImage:rtnImgRef];
            CFRelease(rtnImgRef);
        }
        return rtn;
    }
}

+(UIImage *)ac_grayImage:(UIImage *)sourceImage {
    int bitmapInfo =kCGImageAlphaNone;
    int width = sourceImage.size.width;
    int height = sourceImage.size.height;
    
    CGColorSpaceRef colorSpace =CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate(nil, width, height, 8, 0, colorSpace, bitmapInfo);
    CGColorSpaceRelease(colorSpace);
    
    if (context ==NULL) {
        return nil;
    }
    
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), sourceImage.CGImage);
    UIImage *grayImage = [UIImage imageWithCGImage:CGBitmapContextCreateImage(context)];
    CGContextRelease(context);
    
    return grayImage;
}
@end
