//
//  TxjlCell.h
//  汇投资
//
//  Created by 杨青源 on 14/11/16.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TxjlModel.h"
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
@interface TxjlCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *bank_name;
@property (weak, nonatomic) IBOutlet UILabel *bank_card_tail_number;
@property (weak, nonatomic) IBOutlet UILabel *cash_money;
@property (weak, nonatomic) IBOutlet UILabel *handle_money;
@property (weak, nonatomic) IBOutlet UILabel *accept_money;
@property (weak, nonatomic) IBOutlet UILabel *createtime;
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UIImageView *bankImage;
@property (nonatomic,strong) TxjlModel *txjlModel;
@end
