//
//  MoreViewController.h
//  汇投资
//
//  Created by 杨青源 on 14-10-31.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BassViewController.h"
#import "STAlertView.h"

@interface MoreViewController : BassViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property (nonatomic, strong) STAlertView *stAlertView;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

- (IBAction)getOutAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *getoutButton;

@end
