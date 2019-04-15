//
//  IPSelector.h
//  Xiuxiu
//
//  Created by Mac on 15/6/25.
//  Copyright (c) 2015年 yangdeger@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kDefaultWebApiPort 20180

/**
 * 对访问服务器使用的域名或IP进行获取
 */
@interface IPSelector : NSObject {
    BOOL _isLoading;
    NSMutableArray* _ipList;
    NSMutableArray* _ltcIpList; //'long term connection' ip list
}

+(instancetype)sharedSelector;

+(NSString*)defaultDomain;

+(NSString*)defaultIp;

-(NSString*)autoHost;

/**
 * 仅包括根路径
 */
-(NSString*)autoWebBase;
/**
 * 包括接口api的子路径
 */
-(NSString*)autoWebApiBase;

-(void)addWebApiHost:(NSString*)host port:(int)port;

-(void)reportGoodHost:(NSString*)domainOrIp port:(int)port;

-(void)reportBadHost:(NSString*)domainOrIp port:(int)port;

/**
 * 长连接的host
 */
-(NSString*)ltcHost;

/**
 * 长连接的端口
 */
-(int)ltcPort;

- (NSString *)undercoverHost;
- (int)undercoverPort;


/**
 * 对web service 域名进行dns解析，并将解析到的ip地址缓存到优先级列表中
 * 
 */
-(void)doDNSSolve;

-(void)fetchLTConnectionAddress;
@end
