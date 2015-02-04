//
//  MoneyManageViewController.h
//  汇投资
//
//  Created by 杨青源 on 14-10-31.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BassViewController.h"

@interface MoneyManageViewController : BassViewController<UITableViewDelegate,UITableViewDataSource>
- (IBAction)tzAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *avaliable_money;
@property(nonatomic,copy)NSString *withdraw;
@property(nonatomic,copy)NSString *num_of_coupon;
@property(nonatomic,copy)NSString * reward_money;
@property (weak, nonatomic) IBOutlet UITableView *moneyTableView;
@property(nonatomic,strong)NSDictionary *data;
@property (weak, nonatomic) IBOutlet UIImageView *didGetMoney;

@property (weak, nonatomic) IBOutlet UIImageView *myMoney;
@property (weak, nonatomic) IBOutlet UILabel *didGetMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *mygetmoneylabel;
@property (weak, nonatomic) IBOutlet UILabel *myallmoneyLabel;


@property (weak, nonatomic) IBOutlet UIButton *TZbutton;

@end
