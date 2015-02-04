//
//  CzjlCell.h
//  汇投资
//
//  Created by 杨青源 on 14/11/16.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CzjlModel.h"
@interface CzjlCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *money;
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UILabel *createtime;

@property (weak, nonatomic) IBOutlet UILabel *serial_number;
@property (strong,nonatomic)CzjlModel *czjlModel;
@end
