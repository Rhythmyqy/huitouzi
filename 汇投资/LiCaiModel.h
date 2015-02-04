//
//  LiCaiModel.h
//  汇投资
//
//  Created by wcf on 14/11/20.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import "WXBaseModel.h"

@interface LiCaiModel : WXBaseModel

/*
 "project_days" : 7,
 "is_allow_invest" : 1,
 "min_invest_money" : "1000",
 "year_revenue" : "6.5",
 "project_status" : "立即认购",
 "project_id" : 106,
 "pname" : "滚雪球理财计划之小清新系列"
 */

@property(copy,nonatomic)NSString *pname;//项目名称
@property(copy,nonatomic)NSString *year_revenue; //年化收益率
@property(strong,nonatomic)NSNumber *project_days;//理财期限
@property(nonatomic,copy)NSString *min_invest_money;//最小可投金额
@property(strong,nonatomic)NSString *project_status;//
@property (strong,nonatomic)NSNumber *project_id;//项目id


@end
