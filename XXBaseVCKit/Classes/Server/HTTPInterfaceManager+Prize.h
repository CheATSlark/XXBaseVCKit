//
//  HTTPInterfaceManager+Prize.h
//  Xiuxiu
//
//  Created by xiaoaiai on 2016/11/14.
//  Copyright © 2016年 yangdeger@gmail.com. All rights reserved.
//

#import "HTTPInterfaceManager.h"

@interface HTTPInterfaceManager (Prize)

- (id)fetchWishPoolPrizeList:(NSInteger)page;

- (id)fetchWishItemLottery;

- (id)fetchWishPrizeList:(NSInteger)page;

- (id)fetchPrizeDetailInfo:(NSDictionary *)dic;

- (id)fetchOrderList:(NSInteger)goods_fight_id Page:(NSInteger)page Limit:(NSInteger)limit;

- (id)fetchMyList:(NSInteger)goods_fight_id Page:(NSInteger)page Limit:(NSInteger)limit;

- (id)fetchHistoryWishList:(NSInteger)goods_id Page:(NSInteger)page Limit:(NSInteger)limit;

- (id)fetchMyWishRecList:(NSInteger)page;

- (id)fetchMyDrawRecList:(NSInteger)page;

- (id)checkWishBuyCount:(NSInteger)goods_fight_id Count:(NSInteger)count;

- (id)fetchPrizeAdressList:(NSInteger)page;

- (id)addPrizeAdress:(NSString *)consignee Mobile:(NSString *)mobile Province:(NSString *)province City:(NSString *)city District:(NSString *)district Address:(NSString *)address;

- (id)updatePrizeAdress:(NSString *)consignee Mobile:(NSString *)mobile Province:(NSString *)province City:(NSString *)city District:(NSString *)district Address:(NSString *)address Is_default:(NSInteger)is_default Address_id:(NSInteger)address_id;

- (id)deletePrizeAdress:(NSInteger)address_id;

- (id)fetchDefaultAddress;

- (id)confirmDrawPrize:(NSInteger)goods_fight_id AddressID:(NSInteger)address_id;

- (id)drawedPrize:(NSInteger)goods_fight_id Address:(NSInteger)address_id;

- (id)createOrder:(NSInteger)goods_fight_id GoodsNum:(NSInteger)goods_num Type:(NSInteger)pay_type GoodsAmount:(NSInteger)goods_amount;

@end
