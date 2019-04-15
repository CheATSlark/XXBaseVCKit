//
//  NSString+ExtraXX.m
//  Xiuxiu
//
//  Created by Mac on 15/3/10.
//  Copyright (c) 2015年 yangdeger@gmail.com. All rights reserved.
//

#import "NSString+ExtraXX.h"
#import <CommonCrypto/CommonDigest.h>
#import <sys/utsname.h>
#import <sys/time.h>

@implementation NSString (ExtraXX)

-(NSString *)md5Value
{
    const char *original_str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [hash appendFormat:@"%02x", result[i]];
    return hash;
}

-(NSString *)percentEscapes
{
    CFStringRef strRef = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, NULL, CFSTR("%()<>&!%$#@^{}[]+=?|/\"\\"), kCFStringEncodingUTF8);
    return (NSString*)CFBridgingRelease(strRef);
                                                                 
}

-(NSDictionary*)parseParametersString
{
    NSMutableDictionary* rtn = [NSMutableDictionary dictionary];
    NSRange r = [self rangeOfString:@"?"];
    NSString* paramStr = @"";
    if (r.location != NSNotFound) {
        paramStr = [self substringFromIndex:r.location + r.length];
    }
    NSArray* comps = [paramStr componentsSeparatedByString:@"&"];
    for (NSString* comp in comps) {
        NSArray* pair = [comp componentsSeparatedByString:@"="];
        if ([pair count] == 2) {
            NSString* key = pair[0];
            NSString* value = pair[1];
            if ([key length] > 0) {
                [rtn setObject:[value length] == 0 ? @"" : value forKey:key];
            }
        }
    }
    return rtn;
}

+(NSString *)fixContentTextSize:(NSString *)textStr
{
//    textStr = [textStr stringByReplacingOccurrencesOfString:@"\r" withString:@""];
//    textStr = [textStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    return textStr;
}

+(NSString *)fixContextNR:(NSString *)textStr
{
    textStr = [[textStr componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\r\n"]] componentsJoinedByString:@""];
    return  textStr;
}


+(CGFloat)fixCotentHeigh:(NSString *)textStr
{
    NSArray *lineArr = [textStr componentsSeparatedByString:@"\n"];
    
    return lineArr.count*16+5;
}

- (NSString *)VerticalString{
    NSMutableString * str = [[NSMutableString alloc] initWithString:self];
    NSInteger count = str.length;
    for (int i = 1; i < count; i ++) {
        [str insertString:@"\n" atIndex:i*2 - 1];
    }
    return str;
}

+(NSString *)iPhoneTypeString{
    NSString *deviceType;
    struct utsname systemInfo;
    uname(&systemInfo);
    deviceType = [NSString stringWithCString:systemInfo.machine
                                    encoding:NSUTF8StringEncoding];
    return deviceType;
}

+(uint64_t)sysTimeInMilliseconds{
    uint64_t ts = 0;
    struct timeval t;
    int cres = gettimeofday(&t,NULL);
    if (cres == 0) {
        ts = (uint64_t)t.tv_sec * 1000 + t.tv_usec / 1000;
    }
    return ts;
}

@end
