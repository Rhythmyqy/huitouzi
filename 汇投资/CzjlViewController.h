//
//  CzjlViewController.h
//  汇投资
//
//  Created by 杨青源 on 14/11/6.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import "BassViewController.h"


@interface CzjlViewController : BassViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(strong,nonatomic)NSMutableArray *data;
@end
