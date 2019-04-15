//
//  HTTPInterfaceManager+Market.m
//  Xiuxiu
//
//  Created by FaDeve on 2017/11/15.
//  Copyright © 2017年 yangdeger@gmail.com. All rights reserved.
//

#import "HTTPInterfaceManager+Market.h"

@implementation HTTPInterfaceManager (Market)

-(id)fetchMarketGoodsCategory
{
    NSDictionary* dict = @{};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIMarketCategory parameters:final_params userInfo:nil];
}

-(id)getWishListByCatID:(int)cat_id page:(int)page userInfo:(NSDictionary *)userInfo
{
    NSInteger tmpPage = page / 16;
    NSDictionary* dict = @{@"cat_id":@(cat_id),@"page":@(tmpPage),@"limit":@(20)};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIMarketList parameters:final_params userInfo:userInfo];
}

-(id)getWishDetailByGoodsFightId:(int)goods_fight_id OrByGoodsId:(int)goods_id userInfo:(NSDictionary *)userInfo
{
    NSDictionary *dict;
    if (goods_id) {
        dict = @{@"goods_fight_id":@(goods_fight_id)};
    }else{
        dict = @{@"goods_id":@(goods_id)};
    }
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIMarketDetail parameters:final_params userInfo:userInfo];
}

-(id)confirmOrderByGoodsSkuId:(int)goods_sku_id goodsNum:(int)goods_num userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"goods_sku_id":@(goods_sku_id),@"goods_num":@(goods_num)};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIMarketOrder parameters:final_params userInfo:userInfo];
}

-(id)payOrderAmount:(NSString *)amount goodsSkuID:(int)goods_sku_id goodsNum:(int)goods_num payCode:(NSString *)pay_code addressId:(int)address_id userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"order_amount":amount,@"goods_sku_id":@(goods_sku_id),@"goods_num":@(goods_num),@"pay_code":pay_code,@"address_id":@(address_id)};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIMarketPay parameters:final_params userInfo:userInfo];
}

-(id)getBuyListByPage:(int)page userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"page":@(page),@"limit":@(7)};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIMarketBuyList parameters:final_params userInfo:userInfo];
}

-(id)getOrderInfoByOrderNum:(NSString *)order_no userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"order_no":order_no};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIMarketOrderInfo parameters:final_params userInfo:userInfo];
}

-(id)getMarketItemsByPage:(int)page cat_id:(int)cat_id userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"page":@(page),@"limit":@(7),@"cat_id":@(cat_id)};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIMarketItemsList parameters:final_params userInfo:userInfo];
}

-(id)getMarketItemDetailByGoodId:(NSString *)goods_id userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"goods_id":goods_id};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIMarketItemDetail parameters:final_params userInfo:userInfo];
}

-(id)getMYcartListByPage:(int)page userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"page":@(page),@"limit":@(20)};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIMarketCartList parameters:final_params userInfo:userInfo];
}

-(id)addToCartByGoods_sku_id:(int)goods_sku_id mumber:(NSString *)num userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"goods_sku_id":@(goods_sku_id),@"num":num};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIMarketAddCart parameters:final_params userInfo:userInfo];
}

-(id)cartModify:(NSDictionary *)modify userInfo:(NSDictionary *)userInfo
{
    NSDictionary* params = [self addCommomParameters:modify];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIMarketModifyCart parameters:final_params userInfo:userInfo];
}

-(id)pushBillByGoods_sku_id:(int)goods_sku_id goods_num:(NSString *)goods_num type:(int)source userInfo:(NSDictionary *)userInfo
{
    NSDictionary *dict;
    if (source == 2) {
        dict = @{@"source":@(source)};
    }else{
        dict = @{@"goods_sku_id":@(goods_sku_id),@"goods_num":goods_num,@"source":@(source)};
    }
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIMarketPushBill parameters:final_params userInfo:userInfo];
}

-(id)creatBillOrder:(NSDictionary *)billInfo userInfo:(NSDictionary *)userInfo
{
    NSDictionary* params = [self addCommomParameters:billInfo];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIMarketCreateOrder parameters:final_params userInfo:nil];
}

-(id)searchBillType:(NSInteger)type page:(int)page userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"order_type":@(type),@"page":@(page),@"limit":@(20)};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIMarketSearchBill parameters:final_params userInfo:userInfo];
}

-(id)getBillInfo:(NSString *)order_no userInfo:(NSDictionary *)userInfo
{
    NSDictionary* dict = @{@"order_no":order_no};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIMarketBillInfo parameters:final_params userInfo:userInfo];
}

-(id)doPayBillAction:(NSString *)order_no pay_type:(NSString *)pay_code period:(int)isPeriod userInfo:(NSDictionary *)userInfo
{
    NSDictionary *dict;
    if (isPeriod == 0) {
         dict = @{@"order_no":order_no,@"pay_code":pay_code};
    }else{
        dict = @{@"order_no":order_no,@"pay_code":pay_code,@"total_period":@(isPeriod)};
    }
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIMarketBillPay parameters:final_params userInfo:userInfo];
}

-(id)doRecieveAction:(NSString *)order_no action:(int)action userInfo:(NSDictionary *)userInfo
{
    NSDictionary *dict = @{@"order_no":order_no,@"action":@(action)};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIMarketRecieve parameters:final_params userInfo:userInfo];
}

-(id)getUserInfo
{
    NSDictionary* dict = @{};
    NSDictionary* params = [self addCommomParameters:dict];
    NSString* json_value = [self genPackedJsonStringWithParameters:params];
    NSDictionary* final_params = @{@"data":json_value};
    return [self sendRequestWithInterfaceId:XIMarketUser parameters:final_params userInfo:nil];
}
@end
