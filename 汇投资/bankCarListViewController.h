//
//  bankCarListViewController.h
//  汇投资
//
//  Created by 杨青源 on 15/1/14.
//  Copyright (c) 2015年 杨青源. All rights reserved.
//

#import "BassViewController.h"
#import "LoadBankCarList.h"

@interface bankCarListViewController : BassViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *myTabelView;


@end
