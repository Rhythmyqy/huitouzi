//
//  CzjlCell.m
//  汇投资
//
//  Created by 杨青源 on 14/11/16.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import "CzjlCell.h"

@implementation CzjlCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

- (void)setCzjlModel:(CzjlModel *)czjlModel{
    if (_czjlModel != czjlModel ) {
        _czjlModel = czjlModel;
        self.money.text = [NSString stringWithFormat:@"%@元",_czjlModel.money];
        self.status.text = _czjlModel.status;
        self.createtime.text = _czjlModel.createtime;
        self.serial_number.text = [NSString stringWithFormat:@"流水号:%@",_czjlModel.serial_number];
        
    }



}


@end
