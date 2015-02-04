//
//  CzjlModel.h
//  汇投资
//
//  Created by 杨青源 on 14/11/17.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import "WXBaseModel.h"

@interface CzjlModel : WXBaseModel
/*
 "status" : "成功",
 "uid" : 1397,
 "serial_number" : "CZPC5Z1ICBC20140715000339",
 "bank_name" : "中国工商银行",
 "rid" : 1890,
 "createtime" : "2014-07-15 10:59:51",
 "end_date" : "2014-07-15 11:00:11",
 "money" : "30000.00"
 
 */
@property (copy,nonatomic)NSString *status;
@property (copy,nonatomic)NSString *serial_number;
@property (copy,nonatomic)NSString *bank_name;
@property (copy,nonatomic)NSString *createtime;
@property (copy,nonatomic)NSString *money;
@end
