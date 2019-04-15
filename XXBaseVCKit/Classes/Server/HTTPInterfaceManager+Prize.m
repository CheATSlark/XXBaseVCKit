//
//  HTTPInterfaceManager+Prize.m
//  Xiuxiu
//
//  Created by xiaoaiai on 2016/11/14.
//  Copyright © 2016年 yangdeger@gmail.com. All rights reserved.
//

#import "HTTPInterfaceManager+Prize.h"

@implementation HTTPInterfaceManager (Prize)

- (id)fetchWishPoolPrizeList:(NSInteger)page {
    NSInteger tmpPage = page / 16;
    
    
    NSDictionary *param = [self addCommomParameters:@{@"limit":@(16),@"page":@(tmpPage)}];
    NSString *json_value = [self genPackedJsonStringWithParameters:param];
    NSDictionary *final_value = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIWishPoolList parameters:final_value userInfo:nil];
}

- (id)fetchWishItemLottery {
    NSDictionary *param = [self addCommomParameters:@{}];
    NSString *json_value = [self genPackedJsonStringWithParameters:param];
    NSDictionary *final_value = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIWishPrizeList parameters:final_value userInfo:nil];
}

- (id)fetchWishPrizeList:(NSInteger)page {
    
    NSInteger tmpPage = page / 16;
    
    NSDictionary *param = [self addCommomParameters:@{@"limit":@(16),@"page":@(tmpPage)}];
    NSString *json_value = [self genPackedJsonStringWithParameters:param];
    NSDictionary *final_value = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIWishPrizeListAll parameters:final_value userInfo:nil];
}

- (id)fetchPrizeDetailInfo:(NSDictionary *)dic {

    NSDictionary *param = [self addCommomParameters:dic];
    NSString *json_value = [self genPackedJsonStringWithParameters:param];
    NSDictionary *final_value = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIWishPrizeDetial parameters:final_value userInfo:nil];
}

- (id)fetchOrderList:(NSInteger)goods_fight_id Page:(NSInteger)page Limit:(NSInteger)limit {
    
//    NSInteger tmpPage = page / limit;
    
    NSDictionary *param = [self addCommomParameters:@{@"goods_fight_id":@(goods_fight_id),@"page":@(page),@"limit":@(limit)}];
    NSString *json_value = [self genPackedJsonStringWithParameters:param];
    NSDictionary *final_value = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIOrderList parameters:final_value userInfo:nil];
}

- (id)fetchMyList:(NSInteger)goods_fight_id Page:(NSInteger)page Limit:(NSInteger)limit {
    
    NSInteger tmpPage = page / limit;
    
    NSDictionary *param = [self addCommomParameters:@{@"goods_fight_id":@(goods_fight_id),@"page":@(tmpPage),@"limit":@(limit)}];
    NSString *json_value = [self genPackedJsonStringWithParameters:param];
    NSDictionary *final_value = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIMyWishList parameters:final_value userInfo:nil];
}

- (id)fetchHistoryWishList:(NSInteger)goods_id Page:(NSInteger)page Limit:(NSInteger)limit {
    NSInteger tmpPage = page / limit;
    
    NSDictionary *param = [self addCommomParameters:@{@"goods_id":@(goods_id),@"page":@(tmpPage),@"limit":@(limit)}];
    NSString *json_value = [self genPackedJsonStringWithParameters:param];
    NSDictionary *final_value = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIHisPrizeList parameters:final_value userInfo:nil];
}

- (id)fetchMyWishRecList:(NSInteger)page {
    NSInteger tmpPage = page / 16;
    
    NSDictionary *param = [self addCommomParameters:@{@"page":@(tmpPage),@"limit":@(16)}];
    NSString *json_value = [self genPackedJsonStringWithParameters:param];
    NSDictionary *final_value = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIMyWishRecList parameters:final_value userInfo:nil];
}

- (id)fetchMyDrawRecList:(NSInteger)page {
    NSInteger tmpPage = page / 16;
    
    NSDictionary *param = [self addCommomParameters:@{@"page":@(tmpPage),@"limit":@(16)}];
    NSString *json_value = [self genPackedJsonStringWithParameters:param];
    NSDictionary *final_value = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIMyDrawRecList parameters:final_value userInfo:nil];
}

- (id)checkWishBuyCount:(NSInteger)goods_fight_id Count:(NSInteger)count {
    NSDictionary *param = [self addCommomParameters:@{@"goods_fight_id":@(goods_fight_id),@"buy_num":@(count)}];
    NSString *json_value = [self genPackedJsonStringWithParameters:param];
    NSDictionary *final_value = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XICheckWishBuy parameters:final_value userInfo:nil];
}

- (id)fetchPrizeAdressList:(NSInteger)page {
    NSInteger tmpPage = page / 16;
    NSDictionary *param = [self addCommomParameters:@{@"page":@(tmpPage),@"limit":@(16)}];
    NSString *json_value = [self genPackedJsonStringWithParameters:param];
    NSDictionary *final_value = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIPrizeAdressList parameters:final_value userInfo:nil];
}

- (id)addPrizeAdress:(NSString *)consignee Mobile:(NSString *)mobile Province:(NSString *)province City:(NSString *)city District:(NSString *)district Address:(NSString *)address {
    NSDictionary *dic = @{@"addr_type":@(1),@"consignee":consignee,@"mobile":mobile,@"province":province,@"city":city,@"district":district,@"address":address};
    return [self prizeAdressOpreation:dic InterfaceID:XIPrizeAdressAdd];
}

- (id)updatePrizeAdress:(NSString *)consignee Mobile:(NSString *)mobile Province:(NSString *)province City:(NSString *)city District:(NSString *)district Address:(NSString *)address Is_default:(NSInteger)is_default Address_id:(NSInteger)address_id {
    NSDictionary *dic =  @{@"addr_type":@(2),@"consignee":consignee,@"mobile":mobile,@"province":province,@"city":city,@"district":district,@"address":address,@"is_default":@(is_default),@"address_id":@(address_id)};
    return [self prizeAdressOpreation:dic InterfaceID:XIPrizeAdressUpdate];
}

- (id)deletePrizeAdress:(NSInteger)address_id {
    NSDictionary *dic = @{@"address_id":@(address_id),@"addr_type":@(3)};
    return [self prizeAdressOpreation:dic InterfaceID:XIPrizeAdressDelete];
}

- (id)fetchDefaultAddress {
    NSDictionary *param = [self addCommomParameters:@{}];
    NSString *json_value = [self genPackedJsonStringWithParameters:param];
    NSDictionary *final_value = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIDefaultAddress parameters:final_value userInfo:nil];
}

- (id)confirmDrawPrize:(NSInteger)goods_fight_id AddressID:(NSInteger)address_id {
    NSDictionary *param = [self addCommomParameters:@{@"goods_fight_id":@(goods_fight_id),@"address_id":@(address_id)}];
    NSString *json_value = [self genPackedJsonStringWithParameters:param];
    NSDictionary *final_value = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIConfirmPrize parameters:final_value userInfo:nil];
}

- (id)drawedPrize:(NSInteger)goods_fight_id Address:(NSInteger)address_id {
    NSDictionary *param = [self addCommomParameters:@{@"goods_fight_id":@(goods_fight_id),@"address_id":@(address_id)}];
    NSString *json_value = [self genPackedJsonStringWithParameters:param];
    NSDictionary *final_value = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIDrawedPrize parameters:final_value userInfo:nil];
}

- (id)createOrder:(NSInteger)goods_fight_id GoodsNum:(NSInteger)goods_num Type:(NSInteger)pay_type GoodsAmount:(NSInteger)goods_amount {
    NSDictionary *param = [self addCommomParameters:@{@"goods_fight_id":@(goods_fight_id),@"goods_num":@(goods_num),@"pay_type":@(pay_type),@"goods_amount":@(goods_amount)}];
    NSString *json_value = [self genPackedJsonStringWithParameters:param];
    NSDictionary *final_value = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XICreateWishOrder parameters:final_value userInfo:nil];
    
}

#pragma mark - private
- (id)prizeAdressOpreation:(NSDictionary *)dic InterfaceID:(int)interface{
    NSDictionary *param = [self addCommomParameters:dic];
    NSString *json_value = [self genPackedJsonStringWithParameters:param];
    NSDictionary *final_value = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:interface parameters:final_value userInfo:nil];
}


@end
