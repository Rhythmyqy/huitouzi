//
//  TxjlModel.h
//  汇投资
//
//  Created by wcf on 14/11/17.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXBaseModel.h"
/*
 "createtime":"2014-09-02 14:12:58",
 "uid":1397,
 "bank_card":"6222020200041601318",
 "bank_name":"中国工商银行",
 "status":"成功",
 "bank_card_tail_number":"1318",
 "investrpay_money":"12000.00",
 "handle_money":"0.00",
 "pay_time":"2014-10-30 15:06:58",
 "cash_money":"12000.00",
 "cid":63,
 "accept_money":"12000.00"
 */
@interface TxjlModel : WXBaseModel
@property(nonatomic,copy)NSString *createtime;
@property(nonatomic,strong)NSNumber *uid;
@property(nonatomic,copy)NSString *bank_card;
@property(nonatomic,copy)NSString *bank_name;
@property(nonatomic,copy)NSString *status;
@property(nonatomic,copy)NSString *bank_card_tail_number;
@property(nonatomic,copy)NSString *investrpay_money;
@property(nonatomic,copy)NSString *handle_money;
@property(nonatomic,copy)NSString *pay_time;
@property(nonatomic,copy)NSString *cash_money;
@property(nonatomic,strong)NSNumber *cid;
@property(nonatomic,copy)NSString *accept_money;
@property(nonatomic,copy)NSString *bankpic;
@end
