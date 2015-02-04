//
//  TzjlCell.m
//  汇投资
//
//  Created by 杨青源 on 14/11/16.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import "TzjlCell.h"
#import "TzjlViewController.h"
#import "PayMoenyDetailViewController.h"

@implementation TzjlCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
/*
project_name;
project_code;
create_time;
yield;
tender_money;
invest_paid;
invest_unpaid;
 
 */
- (void)setTzjlModel:(TzjlModel *)tzjlModel
{
    if (_tzjlModel!=tzjlModel) {
        _tzjlModel=tzjlModel;
        self.project_name.text=_tzjlModel.project_name;
        self.project_code.text=_tzjlModel.project_code;
        self.create_time.text=_tzjlModel.create_time;
        self.yield.text=_tzjlModel.yield;
        self.tender_money.text=[NSString stringWithFormat:@"%@元",_tzjlModel.tender_money];
        self.invest_paid.text=[NSString stringWithFormat:@"%@元",_tzjlModel.invest_paid];
        
        self.invest_unpaid.text=[NSString stringWithFormat:@"%@元",_tzjlModel.invest_unpaid];
    }
}
- (IBAction)payDetailMoney:(id)sender {
    id next = [self nextResponder];
    while(![next isKindOfClass:[TzjlViewController class]])//这里跳不出来。。。有人说这里跳不出来，其实是因为它没有当前这个view放入ViewController中，自然也就跳不出来了，会死循环，使用时需要注意。
    {
        next = [next nextResponder];
    }
    if ([next isKindOfClass:[TzjlViewController class]])
    {
        next = (TzjlViewController *)next;
    }
    PayMoenyDetailViewController *payDVC = [[PayMoenyDetailViewController alloc]init];
    
    payDVC.tid = _tzjlModel.tid;
    payDVC.tzjlModel = _tzjlModel;
   
  
    [next presentViewController:payDVC animated:YES completion:nil];
    
}
@end
