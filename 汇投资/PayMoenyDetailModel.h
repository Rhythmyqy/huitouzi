//
//  PayMoenyDetailModel.h
//  汇投资
//
//  Created by wcf on 14/11/23.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import "WXBaseModel.h"

@interface PayMoenyDetailModel : WXBaseModel





@property(nonatomic,copy)NSString *addtime_asc;
@property(nonatomic,copy)NSString *create_time;
@property(nonatomic,copy)NSString *invest_paid;
@property(nonatomic,copy)NSString *invest_type;
@property(nonatomic,copy)NSString *invest_unpaid;
@property(nonatomic,copy)NSString *project_code;
@property(nonatomic,copy)NSString *project_name;
@property(nonatomic,copy)NSString *repaytime_up;
@property(nonatomic,strong)NSNumber *status;
@property(nonatomic,strong)NSNumber *tender_money;

@property(nonatomic,strong)NSNumber *type;
@property(nonatomic,copy)NSString *yield;





@property(nonatomic,copy)NSString *repay_up;
@property(nonatomic,copy)NSString *repayaccount_principal;
@property(nonatomic,copy)NSString *repayaccount_up;
@property(nonatomic,copy)NSString *repayyes_up;


/*
 "repay_time" : "2014-10-15",
 "cid" : 9107,
 "repay_lixi" : 155.34,
 "days" : 30,
 "pay_status" : "未支付",
 "value_date_up" : "2014-09-15",
 "tid" : 1130,
 "repay_benjin" : 0
 
 tid：投资记录ID
 pay_status：未支付、已支付、赎回中、已赎回、已提前还款
 repay_time：还款时间
 value_date_up：起息日
 repay_lixi：支付利息
 repay_benjin：支付本金
 days：天数
 */
@property (copy,nonatomic)NSString *repay_time;
@property(nonatomic,strong)NSNumber *cid;
@property(strong,nonatomic)NSNumber *repay_lixi;
@property(nonatomic,strong)NSNumber *days;
@property(nonatomic,copy)NSString *pay_status;
@property(nonatomic,copy)NSString *value_date_up;
@property(nonatomic,strong)NSNumber *tid;
@property(nonatomic,strong)NSNumber *repay_benjin;
@property(nonatomic,strong)NSNumber *repay_allmoney;
@end
