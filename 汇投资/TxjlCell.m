//
//  TxjlCell.m
//  汇投资
//
//  Created by 杨青源 on 14/11/16.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import "TxjlCell.h"
#import "UIImageView+WebCache.h"

@implementation TxjlCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
/*
bank_name;
bank_card_tail_number;
cash_money;
handle_money;
accept_money;
createtime;
status;
 */
- (void)setTxjlModel:(TxjlModel *)txjlModel
{
    if (_txjlModel!=txjlModel) {
        _txjlModel=txjlModel;
        self.bank_name.text=_txjlModel.bank_name;
        self.bank_card_tail_number.text=[NSString stringWithFormat:@"尾号%@",_txjlModel.bank_card_tail_number];
        self.cash_money.text=[NSString stringWithFormat:@"%@元",_txjlModel.cash_money];
        self.handle_money.text=[NSString stringWithFormat:@"%@元",_txjlModel.handle_money];
        self.accept_money.text=[NSString stringWithFormat:@"%@元",_txjlModel.accept_money];
        self.createtime.text=_txjlModel.createtime;
        self.status.text=_txjlModel.status;
        [_bankImage sd_setImageWithURL:[NSURL URLWithString:_txjlModel.bankpic]];
        
        
        
    }
}
@end
