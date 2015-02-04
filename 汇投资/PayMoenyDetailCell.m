//
//  PayMoenyDetailCell.m
//  汇投资
//
//  Created by wcf on 14/11/23.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import "PayMoenyDetailCell.h"
#import "PayMoenyDetailViewController.h"

@implementation PayMoenyDetailCell

- (void)awakeFromNib {
    // Initialization code
}
/*


 
 {
 "repay_time" : "2014-10-15",
 "cid" : 9107,
 "repay_lixi" : 155.34,
 "days" : 30,
 "pay_status" : "未支付",
 "value_date_up" : "2014-09-15",
 "tid" : 1130,
 "repay_benjin" : 0
 },
 
 */
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setPaymoenyDetailModel:(PayMoenyDetailModel *)paymoenyDetailModel
{
    if (_paymoenyDetailModel!=paymoenyDetailModel) {
        _paymoenyDetailModel=paymoenyDetailModel;
        /*
         
         tid：投资记录ID
         pay_status：未支付、已支付、赎回中、已赎回、已提前还款
         repay_time：还款时间
         value_date_up：起息日
         repay_lixi：支付利息
         repay_benjin：支付本金
         days：天数
         */
        
        self.pay_status.text = _paymoenyDetailModel.pay_status;
        
        if ([_paymoenyDetailModel.pay_status isEqualToString:@"已支付"]) {
            [self.pay_staus_image setImage:[UIImage imageNamed:@"付息详情_08.png"]];
        }else{
        [self.pay_staus_image setImage:[UIImage imageNamed:@"付息详情_06.png"]];
        
        }
        
        self.repayaccount_up.text = [NSString stringWithFormat:@"%@元",_paymoenyDetailModel.repay_lixi ];
        
        self.repayaccount_principal.text = [NSString stringWithFormat:@"%@元",_paymoenyDetailModel.repay_benjin];
        self.repayaccountyes_up.text = [NSString stringWithFormat:@"%@元",_paymoenyDetailModel.repay_allmoney];
        self.repayyes_up.text = _paymoenyDetailModel.repay_time;
        
    }
}
@end
