//
//  CenterViewController.h
//  汇投资
//
//  Created by 杨青源 on 14-10-31.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"
#import "LiCaiModel.h"


@interface CenterViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *tzButton;
@property (weak, nonatomic) IBOutlet UIButton *SBButton;
@property (weak, nonatomic) IBOutlet UIImageView *centerseletimg;

@property (weak, nonatomic) IBOutlet UIView *leftSelectView;
@property (weak, nonatomic) IBOutlet UIView *rightSelectView;
@property (strong,nonatomic)HomeModel *homeModel;
@property (strong,nonatomic)UITableView *detailTableView;

@property(strong,nonatomic)NSMutableArray *data;
@property(strong,nonatomic)NSMutableArray *detailData;
@property(strong,nonatomic)LiCaiModel *licai;
@property (strong,nonatomic)NSNumber *totalPages;//散标总页数
@property (strong,nonatomic)NSNumber *pageIndex;//散标当前页
@property (strong,nonatomic)NSNumber *licaiTotalPages;//理财总页数
@property (strong,nonatomic)NSNumber *licaipageIndex;//理财当前页
- (IBAction)sbButtonAction:(id)sender;
- (IBAction)tzButtonAction:(id)sender;


@property(strong,nonatomic)UITableView *tableView;


@end
