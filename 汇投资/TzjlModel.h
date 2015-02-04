//
//  TzjlModel.h
//  汇投资
//
//  Created by wcf on 14/11/17.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import "WXBaseModel.h"

@interface TzjlModel : WXBaseModel
/*
 "project_name":"滚雪球理财计划万人迷系列",
 "yield":"10.0",
 "status":1,
 "tender_money":"1000",
 "invest_paid":"0.00",
 "type":1,
 "invest_type":null,
 "invest_unpaid":"12.33",
 "addtime_asc":"2014-10-13",
 "repaytime_up":"2014-11-26",
 "create_time":"2014-10-13 14:07:05",
 "project_code":"141013",
 "tid":1429
 */
@property(nonatomic,copy)NSString *project_name;
@property(nonatomic,copy)NSString *yield;
@property(nonatomic,strong)NSNumber *status;
@property(nonatomic,copy)NSString *tender_money;
@property(nonatomic,copy)NSString *invest_paid;
@property(nonatomic,strong)NSNumber *type;
//@property(nonatomic,assign)NSNumber *invest_type;//1.散标投资记录 2滚雪球投资记录
@property(nonatomic,copy)NSString *invest_unpaid;
@property(nonatomic,copy)NSString *addtime_asc;
@property(nonatomic,copy)NSString *repaytime_up;
@property(nonatomic,copy)NSString *create_time;
@property(nonatomic,copy)NSString *project_code;
@property(nonatomic,strong)NSNumber *tid;
@end
