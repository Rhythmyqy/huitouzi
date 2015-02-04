//
//  HomeModel.h
//  汇投资
//
//  Created by 杨青源 on 14/11/16.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import "WXBaseModel.h"

@interface HomeModel : WXBaseModel
/*
 @property (weak, nonatomic) IBOutlet UILabel *year_revenue;
 @property (weak, nonatomic) IBOutlet UILabel *financing_limit;
 @property (weak, nonatomic) IBOutlet UILabel *financing_amount;
 @property (weak, nonatomic) IBOutlet UILabel *project_status;
 */

@property(copy,nonatomic)NSString *pname;//项目名称
@property(copy,nonatomic)NSString *year_revenue; //年化收益率

@property(copy,nonatomic)NSString *financing_limit;//散标期限

@property(copy,nonatomic)NSString *financing_amount_wanyuan;//项目融资金额（单位：元）
@property(strong,nonatomic)NSNumber *project_status;//1:即将上线  2：项目预告  3：正在募集4：募集截止  5：募集完毕6：正在还款 7：还款完毕
@property(copy,nonatomic)NSString *progress;//融资进度（单位%）
@property (strong,nonatomic)NSNumber *project_id;//项目id
@property(strong,nonatomic)NSNumber *is_new;



@property(assign,nonatomic)BOOL a,b;
@end

