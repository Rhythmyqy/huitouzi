//
//  MessgeViewController.h
//  汇投资
//
//  Created by 杨青源 on 14-10-31.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BassViewController.h"
#import "XtxxModel.h"
#import "MessgeDetailViewController.h"

@interface MessgeViewController : BassViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *leftSelectView;
@property (weak, nonatomic) IBOutlet UIView *rightSelectView;

@property(nonatomic,strong)XtxxModel *xtxxModel;

@property(strong,nonatomic)NSMutableArray *data;

@property (weak, nonatomic) IBOutlet UIButton *wdButton;
@property (weak, nonatomic) IBOutlet UIButton *ydButton;


@end
