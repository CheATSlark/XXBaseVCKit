//
//  HTTPInterfaceManager+Gift.m
//  Xiuxiu
//
//  Created by Mac on 15/11/9.
//  Copyright © 2015年 yangdeger@gmail.com. All rights reserved.
//

#import "HTTPInterfaceManager+Gift.h"
//#import "XXAddValueItemModel.h"

@implementation HTTPInterfaceManager (Gift)

-(id)getGiftExchangeList:(int)page userInfo:(NSDictionary *)userInfo
{
    NSMutableDictionary* dict = [@{@"page":@(page),
                           @"limit":@(15)} mutableCopy];
    if (userInfo) {
        [dict addEntriesFromDictionary:userInfo];
    }
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIGiftExchangeList parameters:final_params userInfo:userInfo];
}

-(id)getGiftAccountList:(int)type page:(int)page userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"page":@(page),
                           @"type":@(type),
                           @"limit":@(15)};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIGiftAccountList parameters:final_params userInfo:userInfo];
}

-(id)getGiftListByAiaiNum:(NSString *)aiaiNum userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"uid":aiaiNum};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIGiftListByAiaiNum parameters:final_params userInfo:userInfo];
}

-(id)getGiftExchangeInformation:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIGiftExchangeInfo parameters:final_params userInfo:userInfo];
}

// 1
-(id)makeSMemberExchangeOrder:(int)cash_amount AccountID:(NSString *)accountId AccountName:(NSString *)accountName Type:(NSInteger)exchange_type userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"amount":@(cash_amount),
                           @"account_id":accountId,
                           @"account_name":accountName,
                           @"exchange_type":@(exchange_type)};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:SMGiftExchangeMakeOrder parameters:final_params userInfo:userInfo];
}


-(id)makeExchangeOrder:(int)cash_amount items:(NSArray*)items AccountID:(NSString *)accountId AccountName:(NSString *)accountName Type:(NSInteger)exchange_type userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"exchange_amount_cash":@(cash_amount),
                           @"exchange_gift":items,
                           @"account_id":accountId,
                           @"account_name":accountName,
                           @"exchange_type":@(exchange_type)};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIGiftExchangeMakeOrder parameters:final_params userInfo:userInfo];
}

-(id)sendGift:(int)gid to:(NSString *)aiaiNum amount:(int)amount totalPrice:(int)price needBroadcasting:(int)broadcast userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"gift_id":@(gid),
                           @"count":@(amount),
                           @"coin":@(price),
                           @"to_uid":aiaiNum,
                           @"is_public_notice":@(broadcast)};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIGiftSendPresentOrder parameters:final_params userInfo:userInfo];
}

- (id)sendGift:(int)gid to:(NSString *)aiaiNum Feedid:(NSString *)feed_id amount:(int)amount totalPrice:(int)price needBroadcasting:(int)broadcast userInfo:(NSDictionary *)userInfo {
    NSDictionary* dict = @{@"gift_id":@(gid),
                           @"count":@(amount),
                           @"coin":@(price),
                           @"to_uid":aiaiNum,
                           @"is_public_notice":@(broadcast),
                           @"feed_id":feed_id};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIGiftSendPresentOrder parameters:final_params userInfo:userInfo];
}

-(id)getExchangeOrderDetail:(NSString*)gid userInfo:(NSDictionary *)userInfo
{
    NSMutableDictionary* dict = [@{@"order_id":gid} mutableCopy];
    if (userInfo) {
         [dict addEntriesFromDictionary:userInfo];
    }
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIGiftExchangeOrderDetail parameters:final_params userInfo:userInfo];
}

-(id)getGiftPublishList:(int)page lastId:(int)lastId type:(int)type userInfo:(NSDictionary*)userInfo
{
    NSDictionary* dict = @{@"page":@(page),
                           @"limit":@(15),
                           @"last_notice_id":@(lastId),
                           @"type":@(type)};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIGiftPublicshList parameters:final_params userInfo:userInfo];
}

-(id)getAddValueConfig:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIGiftAddValueConfig parameters:final_params userInfo:userInfo];
}

-(id)getAddValueList:(int)page userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"page":@(page),
                           @"limit":@(15)};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIGiftAddValueList parameters:final_params userInfo:userInfo];
}

//-(id)makeAddValueOrderWithModel:(XXAddValueItemModel *)model payway:(int)way userInfo:(NSDictionary *)userInfo
//{
//    NSMutableDictionary* dct = [NSMutableDictionary dictionary];
//    [dct setObject:@(model.rmb) forKey:@"rmb"];
//    [dct setObject:@(model.normal_value) forKey:@"normal_coin"];
//    [dct setObject:@(model.extra_value) forKey:@"ext_coin"];
//    [dct setObject:@(model.total_value) forKey:@"total_coin"];
//    [dct setObject:@(model.tag) forKey:@"tag"];
//    [dct setObject:@(way) forKey:@"pay_way"];
//
//    NSDictionary* params = [self addCommomParameters:dct];
//    NSString* json_value = [self genPackedJsonStringWithParameters:params];
//
//    NSDictionary* final_params = @{@"data":json_value};
//    return [self sendRequestWithInterfaceId:XIGiftAddValueMakeOrder parameters:final_params userInfo:userInfo];
//}

-(id)validateAppStoreTransactionWithReceipt:(NSString *)data aiaiNum:(NSString *)aiainum transactionId:(NSString *)transactionId userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"data":data,
                           @"pay_way":@(3),
                           @"from_uid":aiainum,
                           @"transaction_id":transactionId};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIGiftAddValueValidTransaction parameters:final_params timeout:60 userInfo:userInfo];
}

-(id)validateMemberAppStoreTransaction:(NSString *)data aiaiNum:(NSString *)aiainum transactionId:(NSString *)transactionId userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"data":data,
                           @"pay_way":@(3),
                           @"from_uid":aiainum,
                           @"transaction_id":transactionId};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:SMAddMemberVaildTransaction parameters:final_params timeout:60 userInfo:userInfo];
}

- (id)getExchageAccoutList:(NSInteger)page Limit:(NSInteger)limit IsDefault:(int)is_default {
    NSDictionary* dict = @{@"page":@(page),
                           @"limit":@(limit),
                           @"is_default":@(is_default)};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIGetAccountList parameters:final_params timeout:60 userInfo:@{}];
}

- (id)updateExchageAccount:(NSInteger )id Account_id:(NSString *)account_id Account_Name:(NSString *)account_name Is_default:(int)is_default {
    NSDictionary* dict = @{@"id":@(id),@"account_id":account_id,@"account_name":account_name,@"is_default":@(is_default)};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIUpdateExchangeAccount parameters:final_params timeout:60 userInfo:@{}];
}

- (id)deleteExchageAccount:(NSInteger)id {
    NSDictionary* dict = @{@"id":@(id)};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIDelExchangeAccount parameters:final_params timeout:60 userInfo:@{}];
}

- (id)addExchangeAccount_id:(NSString *)account_id Account_name:(NSString *)account_name Is_default:(int)is_default {
    NSDictionary* dict = @{@"account_id":account_id,
                           @"account_name":account_name,
                           @"is_default":@(is_default)};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIAddExchangeAccount parameters:final_params timeout:60 userInfo:@{}];

}


- (id)cancelExchangeOrder:(NSString *)order_id {
    NSDictionary* dict = @{@"order_id":order_id};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XICancelExcOrder parameters:final_params timeout:60 userInfo:@{}];
}

-(id)getFaceExpression:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIGetFacePacket parameters:final_params userInfo:userInfo];
}

- (id)fetchSendGiftList:(NSInteger)feed_id AiAiNum:(NSInteger)aiai_num Page:(NSInteger)page {
    NSDictionary* dict = @{@"feed_id":@(feed_id),@"uid":@(aiai_num),@"limit":@(15),@"page":@(page)};
    
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIFetchSendGiftList parameters:final_params userInfo:nil];
}

@end
