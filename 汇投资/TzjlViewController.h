//
//  TzjlViewController.h
//  汇投资
//
//  Created by 杨青源 on 14/11/6.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import "BassViewController.h"
#import "TzjlModel.h"

@interface TzjlViewController : BassViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *centerSelectimg;

@property (weak, nonatomic) IBOutlet UIView *leftSelectView;
@property (weak, nonatomic) IBOutlet UIView *rightSelectView;
@property(nonatomic,strong) TzjlModel *tzjlModel;

@property(strong,nonatomic)NSMutableArray *data;

@property (weak, nonatomic) IBOutlet UIButton *whButton;
@property (weak, nonatomic) IBOutlet UIButton *yhButton;
//@property(nonatomic,strong)UITableView *tableView2;

@end
