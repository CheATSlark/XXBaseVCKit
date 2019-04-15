//
//  HTTPInterfaceManager+Market.h
//  Xiuxiu
//
//  Created by FaDeve on 2017/11/15.
//  Copyright © 2017年 yangdeger@gmail.com. All rights reserved.
//

#import "HTTPInterfaceManager.h"

@interface HTTPInterfaceManager (Market)

-(id)fetchMarketGoodsCategory;

-(id)getWishListByCatID:(int)cat_id page:(int)page userInfo:(NSDictionary *)userInfo;

-(id)getWishDetailByGoodsFightId:(int)goods_fight_id OrByGoodsId:(int)goods_id userInfo:(NSDictionary *)userInfo;

-(id)confirmOrderByGoodsSkuId:(int)goods_sku_id goodsNum:(int)goods_num userInfo:(NSDictionary *)userInfo;

-(id)payOrderAmount:(NSString *)amount goodsSkuID:(int)goods_sku_id goodsNum:(int)goods_num payCode:(NSString *)pay_code addressId:(int)address_id userInfo:(NSDictionary *)userInfo;

-(id)getBuyListByPage:(int)page userInfo:(NSDictionary *)userInfo;

-(id)getOrderInfoByOrderNum:(NSString *)order_no userInfo:(NSDictionary *)userInfo;

-(id)getMarketItemsByPage:(int)page cat_id:(int)cat_id userInfo:(NSDictionary *)userInfo;

-(id)getMarketItemDetailByGoodId:(NSString *)goods_id userInfo:(NSDictionary *)userInfo;

-(id)getMYcartListByPage:(int)page userInfo:(NSDictionary *)userInfo;

-(id)addToCartByGoods_sku_id:(int)goods_sku_id mumber:(NSString *)num userInfo:(NSDictionary *)userInfo;

-(id)cartModify:(NSDictionary *)modify userInfo:(NSDictionary *)userInfo;

-(id)pushBillByGoods_sku_id:(int)goods_sku_id goods_num:(NSString *)goods_num type:(int)source userInfo:(NSDictionary *)userInfo;

-(id)creatBillOrder:(NSDictionary *)billInfo userInfo:(NSDictionary *)userInfo;

-(id)searchBillType:(NSInteger)type page:(int)page userInfo:(NSDictionary *)userInfo;

-(id)getBillInfo:(NSString *)order_no userInfo:(NSDictionary *)userInfo;

-(id)doPayBillAction:(NSString *)order_no pay_type:(NSString *)pay_code period:(int)isPeriod userInfo:(NSDictionary *)userInfo;

-(id)doRecieveAction:(NSString *)order_no action:(int)action userInfo:(NSDictionary *)userInfo;

-(id)getUserInfo;
@end
