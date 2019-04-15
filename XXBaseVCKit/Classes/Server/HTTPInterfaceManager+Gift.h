//
//  HTTPInterfaceManager+Gift.h
//  Xiuxiu
//
//  Created by Mac on 15/11/9.
//  Copyright © 2015年 yangdeger@gmail.com. All rights reserved.
//

#import "HTTPInterfaceManager.h"

//@class XXAddValueItemModel;

/**
 * Gift Module
 */
@interface HTTPInterfaceManager (Gift)

-(id)getGiftExchangeList:(int)page userInfo:(NSDictionary*)userInfo;

-(id)getGiftAccountList:(int)type page:(int)page userInfo:(NSDictionary*)userInfo;

-(id)getGiftListByAiaiNum:(NSString*)aiaiNum userInfo:(NSDictionary*)userInfo;

-(id)getGiftExchangeInformation:(NSDictionary*)userInfo;

-(id)makeExchangeOrder:(int)cash_amount items:(NSArray*)items AccountID:(NSString *)accountId AccountName:(NSString *)accountName Type:(NSInteger)exchange_type userInfo:(NSDictionary*)userInfo;

-(id)makeSMemberExchangeOrder:(int)cash_amount AccountID:(NSString *)accountId AccountName:(NSString *)accountName Type:(NSInteger)exchange_type userInfo:(NSDictionary *)userInfo;

-(id)sendGift:(int)gid to:(NSString*)aiaiNum amount:(int)amount totalPrice:(int)price needBroadcasting:(int)broadcast userInfo:(NSDictionary*)userInfo;

-(id)getExchangeOrderDetail:(NSString*)gid userInfo:(NSDictionary*)userInfo;

-(id)getGiftPublishList:(int)page lastId:(int)lastId type:(int)type userInfo:(NSDictionary*)userInfo;

-(id)getAddValueConfig:(NSDictionary*)userInfo;

-(id)getAddValueList:(int)page userInfo:(NSDictionary*)userInfo;

//-(id)makeAddValueOrderWithModel:(XXAddValueItemModel*)model payway:(int)way userInfo:(NSDictionary*)userInfo;

-(id)validateAppStoreTransactionWithReceipt:(NSString*)data aiaiNum:(NSString*)aiainum transactionId:(NSString*)transactionId userInfo:(NSDictionary*)userInfo;

//-(id)validateMemberAppStoreTransaction:(NSString *)data aiaiNum:(NSString *)aiainum transactionId:(NSString *)transactionId userInfo:(NSDictionary *)userInfo;

- (id)getExchageAccoutList:(NSInteger)page Limit:(NSInteger)limit IsDefault:(int)is_default;

- (id)updateExchageAccount:(NSInteger)id Account_id:(NSString *)account_id Account_Name:(NSString *)account_name Is_default:(int)is_default;

- (id)deleteExchageAccount:(NSInteger)id;

- (id)addExchangeAccount_id:(NSString *)account_id Account_name:(NSString *)account_name Is_default:(int)is_default ;

- (id)cancelExchangeOrder:(NSString *)order_id;

-(id)getFaceExpression:(NSDictionary *)userInfo;

-(id)sendGift:(int)gid to:(NSString *)aiaiNum Feedid:(NSString *)feed_id amount:(int)amount totalPrice:(int)price needBroadcasting:(int)broadcast userInfo:(NSDictionary *)userInfo;


- (id)fetchSendGiftList:(NSInteger)feed_id AiAiNum:(NSInteger)aiai_num Page:(NSInteger)page;



@end
