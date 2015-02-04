//
//  TzjlCell.h
//  汇投资
//
//  Created by 杨青源 on 14/11/16.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TzjlModel.h"

@interface TzjlCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *project_name;
@property (weak, nonatomic) IBOutlet UILabel *project_code;
@property (weak, nonatomic) IBOutlet UILabel *create_time;
@property (weak, nonatomic) IBOutlet UILabel *yield;
@property (weak, nonatomic) IBOutlet UILabel *tender_money;
@property (weak, nonatomic) IBOutlet UILabel *invest_paid;
@property (weak, nonatomic) IBOutlet UILabel *invest_unpaid;

- (IBAction)payDetailMoney:(id)sender;
@property(nonatomic,strong) TzjlModel *tzjlModel;
@end
