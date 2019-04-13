//
//  NSString+ExtraXX.h
//  Xiuxiu
//
//  Created by Mac on 15/3/10.
//  Copyright (c) 2015年 yangdeger@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (ExtraXX)

-(NSString*)md5Value;

-(NSString*)percentEscapes;

-(NSDictionary*)parseParametersString;

+(NSString *)fixContentTextSize:(NSString *)textStr;
+(NSString *)fixContextNR:(NSString *)textStr;

+(CGFloat)fixCotentHeigh:(NSString *)textStr;

- (NSString *)VerticalString;

@end
