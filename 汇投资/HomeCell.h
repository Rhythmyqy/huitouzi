//
//  HomeCell.h
//  汇投资
//
//  Created by 杨青源 on 14/11/5.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"
#import "LiCaiModel.h"

@interface HomeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *pName;

@property (weak, nonatomic) IBOutlet UILabel *year_revenue;
@property (weak, nonatomic) IBOutlet UILabel *financing_limit;
@property (weak, nonatomic) IBOutlet UILabel *financing_amount;
@property (weak, nonatomic) IBOutlet UILabel *project_status;
@property (weak, nonatomic) IBOutlet UIView *progressView;
@property (strong, nonatomic) IBOutlet UIImageView *isNewImg;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@property (weak,nonatomic)HomeModel *homeModel;


@end
