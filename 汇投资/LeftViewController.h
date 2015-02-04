//
//  LeftViewController.h
//  汇投资
//
//  Created by 杨青源 on 14-10-31.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"

@interface LeftViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property(nonatomic,strong)UserModel *userModel;

@property (weak, nonatomic) IBOutlet UITableView *tableView;



@end
