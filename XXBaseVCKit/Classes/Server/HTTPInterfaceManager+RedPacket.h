//
//  HTTPInterfaceManager+RedPacket.h
//  Xiuxiu
//
//  Created by FaDeve on 15/12/28.
//  Copyright © 2015年 yangdeger@gmail.com. All rights reserved.
//

#import "HTTPInterfaceManager.h"

@interface HTTPInterfaceManager (RedPacket)

-(id)sendRedPacketWithRedPacketInfo:(NSDictionary *)redPacket_info userInfo:(NSDictionary*)userInfo;

-(id)getRedPacketListWithRecordID:(NSString *)recordId userInfo:(NSDictionary*)userInfo;

-(id)getRedPacketInfoWithRedID:(NSString *)red_id userInfo:(NSDictionary*)userInfo;

-(id)knockRedPacketWithRedPacketInfo:(NSDictionary *)redPacket_info userInfo:(NSDictionary *)userInfo;
/**
 *  为了礼包列表 分页获取 特加入page 作为变量
 *
 *  @param recordId 礼包id
 *  @param page     列表页数
 *  @param userInfo
 *
 *  @return
 */
-(id)getRedPacketListWithRecordID:(NSString *)recordId AndPage:(int)page userInfo:(NSDictionary*)userInfo;


-(id)sendSpecialGiftWithGroupId:(NSString *)groupId userInfo:(NSDictionary *)userInfo;

-(id)getSpecialGiftInfoWithGiftId:(NSString *)giftId userInfo:(NSDictionary *)userInfo;

-(id)grabSepcialGiftWithGiftInfo:(NSDictionary *)gift_info userInfo:(NSDictionary *)userInfo;

-(id)getSpecialGiftListWithGiftId:(NSString *)giftId AndPage:(int)page userInfo:(NSDictionary *)userInfo;
@end
