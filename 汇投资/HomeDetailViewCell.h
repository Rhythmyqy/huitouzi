//
//  HomeDetailViewCell.h
//  汇投资
//
//  Created by 杨青源 on 14/11/21.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiCaiModel.h"

@interface HomeDetailViewCell : UITableViewCell
- (IBAction)NowInvestAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *mayGetMoney;
@property (weak, nonatomic) IBOutlet UILabel *projectTime;

@property (weak, nonatomic) IBOutlet UILabel *projectTitle;
@property (strong,nonatomic)LiCaiModel *liCaiModel;
@property (weak, nonatomic) IBOutlet UIButton *nowInvert;
@end
