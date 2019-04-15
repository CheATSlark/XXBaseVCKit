//
//  HTTPInterfaceManager+RedPacket.m
//  Xiuxiu
//
//  Created by FaDeve on 15/12/28.
//  Copyright © 2015年 yangdeger@gmail.com. All rights reserved.
//

#import "HTTPInterfaceManager+RedPacket.h"

@implementation HTTPInterfaceManager (RedPacket)
/*
 
 */
-(id)sendRedPacketWithRedPacketInfo:(NSDictionary *)redPacket_info userInfo:(NSDictionary*)userInfo{

    NSDictionary* params = [self addCommomParameters:redPacket_info];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIRedPacketUpload parameters:final_params userInfo:userInfo];
}

-(id)getRedPacketListWithRecordID:(NSString *)recordId userInfo:(NSDictionary*)userInfo{
    
    NSDictionary* dict = @{@"red_id":recordId};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIRedPacketRecordList parameters:final_params userInfo:userInfo];
}

-(id)getRedPacketListWithRecordID:(NSString *)recordId AndPage:(int)page userInfo:(NSDictionary*)userInfo{
    
    NSDictionary* dict = @{@"red_id":recordId,@"page":@(page)};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIRedPacketRecordList parameters:final_params userInfo:userInfo];
}


-(id)getRedPacketInfoWithRedID:(NSString *)red_id userInfo:(NSDictionary*)userInfo{

    NSDictionary* dict = @{@"red_id":red_id};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIRedPacketInfo parameters:final_params userInfo:userInfo];
}

-(id)knockRedPacketWithRedPacketInfo:(NSDictionary *)redPacket_info userInfo:(NSDictionary *)userInfo{
    NSDictionary* params = [self addCommomParameters:redPacket_info];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIRedPacketKnock parameters:final_params userInfo:userInfo];
}
//-(id)getRedPacketInfoWithUserInfo:(NSDictionary*)userInfo{
//
//    NSDictionary* dict = @{};
//    
//    NSDictionary* params = [self addCommomParameters:dict];
//    NSString* json_value = [self genPackedJsonStringWithParameters:params];
//    
//    NSDictionary* final_params = @{@"data":json_value};
//    return [self sendRequestWithInterfaceId:XIRedPacketInfo parameters:final_params userInfo:userInfo];
//}

-(id)sendSpecialGiftWithGroupId:(NSString *)groupId userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"group_id":groupId};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XISendSpecialGift parameters:final_params userInfo:userInfo];
}

-(id)getSpecialGiftInfoWithGiftId:(NSString *)giftId userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"red_id":giftId};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XISpecialGiftInfo parameters:final_params userInfo:userInfo];
}

-(id)grabSepcialGiftWithGiftInfo:(NSDictionary *)gift_info userInfo:(NSDictionary *)userInfo
{
    NSDictionary* params = [self addCommomParameters:gift_info];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIGrabSpecialGift parameters:final_params userInfo:userInfo];
}

-(id)getSpecialGiftListWithGiftId:(NSString *)giftId AndPage:(int)page userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"red_id":giftId,@"page":@(page),@"limit":@(20)};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XISpecialGiftList parameters:final_params userInfo:userInfo];
}

@end
