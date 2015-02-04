//
//  PayMoenyDetailCell.h
//  汇投资
//
//  Created by wcf on 14/11/23.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayMoenyDetailModel.h"
@interface PayMoenyDetailCell : UITableViewCell
//还款日期
@property (weak, nonatomic) IBOutlet UIImageView *pay_staus_image;
@property (weak, nonatomic) IBOutlet UILabel *repayyes_up;
//支付状态：1-未支付 2-已支付 3-赎回中 4-已赎回 5-赎回失败
@property (weak, nonatomic) IBOutlet UILabel *pay_status;
//支付利息
@property (weak, nonatomic) IBOutlet UILabel *repayaccount_up;
//支付本金
@property (weak, nonatomic) IBOutlet UILabel *repayaccount_principal;
//合计金额
@property (weak, nonatomic) IBOutlet UILabel *repayaccountyes_up;


@property(nonatomic,strong) PayMoenyDetailModel *paymoenyDetailModel;

@end
