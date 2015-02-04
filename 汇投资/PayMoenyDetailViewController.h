//
//  PayMoenyDetailViewController.h
//  汇投资
//
//  Created by 杨青源 on 14/11/23.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import "BassViewController.h"
#import "TzjlModel.h"
#import "PayMoenyDetailModel.h"

@interface PayMoenyDetailViewController : BassViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *create_status_tt;

@property (weak, nonatomic) IBOutlet UILabel *project_name;
@property (weak, nonatomic) IBOutlet UILabel *project_code;
@property (weak, nonatomic) IBOutlet UILabel *create_time;
@property (weak, nonatomic) IBOutlet UILabel *yield;
@property (weak, nonatomic) IBOutlet UILabel *tender_money;

@property(nonatomic,strong)NSMutableArray *data;

@property (nonatomic,strong)NSNumber *tid;
@property (nonatomic,strong)TzjlModel *tzjlModel;
@property(nonatomic,strong)PayMoenyDetailModel *payMDModel;
@end
