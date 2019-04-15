//
//  IPSelector.m
//  Xiuxiu
//
//  Created by Mac on 15/6/25.
//  Copyright (c) 2015年 yangdeger@gmail.com. All rights reserved.
//

#import "IPSelector.h"
#import "IPModel.h"
//#import "Config.h"
#include <netdb.h>
#include <arpa/inet.h>
#import "HTTPInterfaceManager.h"
#import "HTTPInterfaceManager+Config.h"
#import "CommonSvrErrorHandler.h"
//#import "UtilityToolkit.h"

//#import "XXControlManager.h"
//#import "StatusChecker.h"
//#import "AccountManager.h"

static IPSelector *gSelector;

#define kDefaultPriority 1
#define kConstPriority 0x7fffffff
#define kMaxPriority 3
#define kMinPriority -1

#define kIPKey_LTCList @"xx_ltclist"

@interface IPSelector()<HTTPInterfaceManagerDelegate> {
    HTTPInterfaceManager* _interfaceManager;
}

@end

@implementation IPSelector

+(instancetype)sharedSelector
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        gSelector = [[self alloc] init];
    });
    return gSelector;
}

+(NSString *)defaultDomain
{
#if WEB_SERVER_ENV == 2
    return @"api.shenzhenxiaoai.com";
#elif WEB_SERVER_ENV == 3
    return @"192.168.1.50";
#elif WEB_SERVER_ENV == 1
    return @"192.168.1.50";
#elif WEB_SERVER_ENV == 0
    return @"gama.shenzhenxiaoai.com";
#endif
}

+(NSString *)defaultIp
{
    return @"120.24.70.50";
}

-(instancetype)init
{
    self = [super init];
    if (self != nil) {
        _ipList = [NSMutableArray array];
        _ltcIpList = [NSMutableArray array];
//        [self resetDefaultIPModel];
        [self loadLtcIpList];
        _interfaceManager = [[HTTPInterfaceManager alloc] init];
        _interfaceManager.delegate = self;
    }
    return self;
}


-(void)addWebApiHost:(NSString *)host port:(int)port
{
    IPModel* m = [[IPModel alloc] init];
    // 仍然保留按留https
    NSRange r =  [host rangeOfString:@"http://"];
    if (r.location != NSNotFound) {
        host = [host substringFromIndex:r.location+r.length];
    }
    m.ipOrDomain = host;
    m.port = port;
    [_ipList addObject:m];
}

-(void)doDNSSolve
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // Get host entry info for given host
      //  struct hostent *remoteHostEnt = gethostbyname([[IPSelector defaultDomain] UTF8String]);
        struct hostent *remoteHostEnt = gethostbyname2([[IPSelector defaultDomain] UTF8String], AF_INET6);
        // Get address info from host entry
        dispatch_async(dispatch_get_main_queue(), ^{

            
            if (remoteHostEnt != NULL && remoteHostEnt->h_addr_list != NULL) {
                [_ipList removeAllObjects];
            }else{
                return ;
            }
            
            int idx = 0;
            while (remoteHostEnt->h_addr_list[idx] != NULL) {
                struct in_addr *remoteInAddr = (struct in_addr *)remoteHostEnt->h_addr_list[idx];
                // Convert numeric addr to ASCII string
                char *remoteInAddrChar = inet_ntoa(*remoteInAddr);
                NSString *str_ip = [NSString stringWithCString:remoteInAddrChar encoding:NSUTF8StringEncoding];
                IPModel* pm = [[IPModel alloc] init];
                pm.ipOrDomain = str_ip;
                pm.port = 80;
                pm.priority = kDefaultPriority;
                [_ipList addObject:pm];
                
                idx += 1;
            }
        });
    });

}

-(void)resetDefaultIPModel
{
    [_ipList removeAllObjects];
    
#if WEB_SERVER_ENV == 0
    IPModel* pm1 = [[IPModel alloc] init];
    pm1.ipOrDomain = @"gama.aifuns.com"; //开发环境
    pm1.port = 8082;
    pm1.priority = kConstPriority;
    [_ipList addObject:pm1];
#elif WEB_SERVER_ENV == 1
    IPModel* pm1 = [[IPModel alloc] init];
    pm1.ipOrDomain = @"120.24.244.1"; //测试环境
    pm1.port = 80;
    pm1.priority = kConstPriority;
    [_ipList addObject:pm1];
#elif WEB_SERVER_ENV == 2  //正式环境
    IPModel* pm1 = [[IPModel alloc] init];
    pm1.ipOrDomain = [[self class] defaultDomain];
    pm1.port = 80;
    pm1.priority = 0;
    [_ipList addObject:pm1];
    
    IPModel* pm2 = [[IPModel alloc] init];
    pm2.ipOrDomain = [[self class] defaultIp];
    pm2.port = 80;
    pm2.priority = 0;
    [_ipList addObject:pm2];
    
#elif WEB_SERVER_ENV == 3
    IPModel* pm1 = [[IPModel alloc] init];
    pm1.ipOrDomain = @"192.168.1.50"; //测试环境
    pm1.port = 20180;
    pm1.priority = kConstPriority;
    [_ipList addObject:pm1];
#endif
    
    
    [self sortListViaPriority];
}

-(void)loadLtcIpList
{
    NSDictionary* result = [[NSUserDefaults standardUserDefaults] objectForKey:kIPKey_LTCList];
    
    IPModel* im = [[IPModel alloc] init];
    
    if (result != nil) {
       
        im.ipOrDomain = [result objectForKey:@"ip"];
        int port = [[result objectForKey:@"port"] intValue];
        if (port == 0) {
            port = 8485;
        }
        im.port = port;
    }else{
        //set default
        im.ipOrDomain = [IPSelector defaultDomain];
        im.port = 8485;
    }
    
    [_ltcIpList addObject:im];
}

-(NSString *)autoHost
{
    NSString* host = nil;
    int port = 0;
    
    if ([_ipList count] == 0) {
        host = [[self class] defaultDomain];
        port = kDefaultWebApiPort;
    }else{
        IPModel* pm = [_ipList objectAtIndex:0];
        
        if (pm.priority == kMinPriority) {
            host = [[self class] defaultDomain];
            port = kDefaultWebApiPort;
        }else{
            host = pm.ipOrDomain;
            port = pm.port;
        }
    }
    
    return host;
}

-(NSString *)autoWebBase
{
    NSString* host = nil;
    int port = 0;
    
    if ([_ipList count] == 0) {
        host = [[self class] defaultDomain];
        port = kDefaultWebApiPort;
    }else{
        IPModel* pm = [_ipList objectAtIndex:0];
        
        if (pm.priority == kMinPriority) {
            host = [[self class] defaultDomain];
            port = kDefaultWebApiPort;
        }else{
            host = pm.ipOrDomain;
            port = pm.port;
        }
    }
    return [NSString stringWithFormat:@"http://%@:%d",host,port];
}

-(NSString *)autoWebApiBase
{
    return [NSString stringWithFormat:@"%@/api/v1/",[self autoWebBase]];
}

-(NSString *)ltcHost
{
    IPModel* im = [_ltcIpList firstObject];
    return im.ipOrDomain;
}

-(int)ltcPort
{
    IPModel* im = [_ltcIpList firstObject];
    return im.port;
}

- (NSString *)undercoverHost {
    
    IPModel* im = [_ltcIpList objectAtIndex:1];
    return im.ipOrDomain;
}
-(int)undercoverPort
{
    IPModel* im = [_ltcIpList objectAtIndex:1];
    return im.port;
}


#pragma mark - adjust logic

-(void)reportGoodHost:(NSString *)domainOrIp port:(int)port
{
    //由于直接从svr获取ip配置了，这里也不再选ip，先屏蔽
//    dispatch_async(dispatch_get_main_queue(), ^{
//        IPModel* pm = [[IPModel alloc] init];
//        pm.ipOrDomain = domainOrIp;
//        pm.port = port;
//        __block BOOL found = NO;
//        [_ipList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//            IPModel* o = (IPModel*)obj;
//            if ([o isEqual:pm]) {
//                if (o.priority != kConstPriority) {
//                    o.priority = o.priority + 1 < kMaxPriority ? o.priority + 1 : kMaxPriority;
//                }
//                *stop = YES;
//                found = YES;
//            }
//        }];
//        
//        if (found) {
//            DDLogDebug(@"report GOOD: %@:%d",pm.ipOrDomain,pm.port);
//            [self sortListViaPriority];
//        }
//    });
}

-(void)reportBadHost:(NSString *)domainOrIp port:(int)port
{
    //由于直接从svr获取ip配置了，这里也不再选ip，先屏蔽
//    dispatch_async(dispatch_get_main_queue(), ^{
//        IPModel* pm = [[IPModel alloc] init];
//        pm.ipOrDomain = domainOrIp;
//        pm.port = port;
//        __block BOOL found = NO;
//        [_ipList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//            IPModel* o = (IPModel*)obj;
//            if ([o isEqual:pm]) {
//                if (o.priority != kConstPriority) {
//                    o.priority = o.priority - 1 > kMinPriority ? o.priority - 1 : kMinPriority;
//                }
//                *stop = YES;
//                found = YES;
//            }
//        }];
//        
//        if (found) {
//            DDLogDebug(@"report BAD: %@:%d",pm.ipOrDomain,pm.port);
//            [self sortListViaPriority];
//        }
//    });
}

-(void)sortListViaPriority
{
    [_ipList sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        IPModel* pm1 = (IPModel*)obj1;
        IPModel* pm2 = (IPModel*)obj2;
        
        if (pm1.priority > pm2.priority) {
            return NSOrderedAscending;
        }else if(pm1.priority < pm2.priority) {
            return NSOrderedDescending;
        }else{
            return NSOrderedSame;
        }
    }];
}

-(void)fetchLTConnectionAddress
{
    if (_isLoading) {
        return ;
    }
    
    [_interfaceManager getConnectionIpAddressWithInfo:nil];
}

//-(void)doFirstLTConnection
//{
//    //由于有广播在长连接中，因此无论如何都开始连接
//    [[XXControlManager shareInstance] connect];
//}

#pragma mark - interface manager delegate
-(void)interface:(XXInterfaceId)interfaceId failWithError:(NSError *)error userInfo:(NSDictionary *)userInfo
{
    _isLoading = NO;
//    [self doFirstLTConnection];
}

-(void)interface:(XXInterfaceId)interfaceId successWithData:(NSData *)data userInfo:(NSDictionary *)userInfo
{
    BOOL ps;
    NSDictionary* result = [_interfaceManager commonParseResult:data success:&ps];
    if (!ps) {
        CommonSvrErrorHandler* seh = [CommonSvrErrorHandler sharedHandler];
        [seh handlerErrorResultTokenInvalid:result];
        
    }else{
        [_ltcIpList removeAllObjects];
        NSArray *array = (NSArray *)result;
        for (NSDictionary *dic in array) {
            IPModel* im = [[IPModel alloc] init];
            NSString *ip = [dic objectForKey:@"ip"];
            im.ipOrDomain = ip;
            int port = [[dic objectForKey:@"port"] intValue];
            if (port == 0) {
                port = 8485;
            }
            im.port = port;
            [_ltcIpList addObject:im];
        }
        
        //save to local
        [[NSUserDefaults standardUserDefaults] setObject:result forKey:kIPKey_LTCList];
    }
    
    //这里进行一次连接
//    [self doFirstLTConnection];
    
    _isLoading = NO;
}

@end
