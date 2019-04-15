//
//  HTTPInterfaceManager+Admin.m
//  Xiuxiu
//
//  Created by Mac on 15/10/20.
//  Copyright © 2015年 yangdeger@gmail.com. All rights reserved.
//

#import "HTTPInterfaceManager+Admin.h"
#import "HTTPWorker.h"
#import "HTTPInterfaceAddress.h"


@implementation HTTPInterfaceManager (Admin)
#ifdef ADMIN_VER
-(id)adminRecommendFeed:(int32_t)fid
{
    NSDictionary* dict = @{@"feed_id":@(fid)};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIAdminFeedRecommend parameters:final_params userInfo:nil];
}

-(id)adminFreezeAccount:(int)aiai_num type:(int)type
{
    NSDictionary* dict = @{@"to_aiai":@(aiai_num),
                           @"type":@(type)};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIAdminFreezeAccount parameters:final_params userInfo:nil ];
}

-(id)adminTopFeed:(int32_t)fid type:(int32_t)type
{
    NSDictionary* dict = @{@"feed_id":@(fid),
                           @"type":@(type)};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIAdminFeedTop parameters:final_params userInfo:nil ];
}

-(id)adminCancelTopFeed:(int32_t)fid type:(int32_t)type
{
    NSDictionary* dict = @{@"feed_id":@(fid),
                           @"type":@(type)};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIAdminFeedUndoTop parameters:final_params userInfo:nil ];
}

-(id)adminFreezeFeed:(int32_t)fid
{
    NSDictionary* dict = @{@"feed_id":@(fid)};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIAdminFreezeFeed parameters:final_params userInfo:nil ];
}

-(id)adminFreezeFeedComment:(int32_t)cid
{
    NSDictionary* dict = @{@"comment_id":@(cid)};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIAdminFreezeFeedComment parameters:final_params userInfo:nil ];
}
#endif
@end
