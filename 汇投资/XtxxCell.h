//
//  XtxxCell.h
//  汇投资
//
//  Created by wcf on 14/11/19.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XtxxModel.h"

@interface XtxxCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *sendtime;

@property(nonatomic,strong) XtxxModel *xtxxModel;
@end
