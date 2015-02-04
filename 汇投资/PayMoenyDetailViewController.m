//
//  PayMoenyDetailViewController.m
//  汇投资
//
//  Created by 杨青源 on 14/11/23.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#import "PayMoenyDetailViewController.h"
#import "AppDelegate.h"
#import "PayMoenyDetailCell.h"
#import "WXDataService.h"
#import "PayMoenyDetailModel.h"

@interface PayMoenyDetailViewController ()

@end

@implementation PayMoenyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.data=[NSMutableArray array];
    self.nameTitle.text=@"付息详情";
    self.tableView.frame = CGRectMake(0, 148, 320, kScreenHeight-148);
    self.data=[[NSMutableArray alloc] init];
    [self loadData];
    
}
- (void)loadData
{
//    http://app.huitouzi.com/htzApp/app/htz/rechargeLog.json?pageIndex=1&pageSize=10
    NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"Cookie"];
    
    NSDictionary *dic1 = [[NSMutableDictionary alloc]init];
    
    [dic1 setValue:str forKey:@"Cookie"];
    
    NSString *url= [NSString stringWithFormat:@"http://app.huitouzi.com/htzApp/app/htz/repaymentLog.json?tid=%@&pageIndex=1&pageSize=10",self.tid];
    [WXDataService requestWithURL:url params:nil httpMethod:@"POST" block:^(id result) {
       
        [self _loadFinsh:result];

    } requestHeader:dic1];
}
- (void)_loadFinsh:(id)result{
    
    NSString *code = [result objectForKey:@"code"];
    NSString *msg = [result objectForKey:@"msg"];
    if ([code integerValue] == 0000) {
        NSArray *arr =  [[result objectForKey:@"data"] objectForKey:@"list"];
        
        for (NSDictionary *dic in arr) {
            PayMoenyDetailModel *payMDModel = [[PayMoenyDetailModel alloc]initWithDataDic:dic];
            [self.data addObject:payMDModel];
            
            
        }
          [_tableView reloadData];
      NSDictionary *prodic=  [[result objectForKey:@"data"] objectForKey:@"investLog"];
        self.project_name.text = [prodic objectForKey:@"project_name"];
        self.project_code.text= [prodic objectForKey:@"project_code"];
        self.yield.text = [NSString stringWithFormat:@"%@%%",[prodic objectForKey:@"yield"] ];
        self.tender_money.text = [NSString stringWithFormat:@"%@元",[prodic objectForKey:@"tender_money"]];
        self.create_time.text = [prodic objectForKey:@"create_time"];
        if ([prodic objectForKey:@"create_status_tt"]) {
          self.create_status_tt.text = [prodic objectForKey:@"create_status_tt"];
        }
        
      
    }else {
        UIAlertView *altview = [[UIAlertView alloc]initWithTitle:msg message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [altview show];
    }
}
#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *iden=@"cell_fxxq";
    PayMoenyDetailCell *cell=[tableView dequeueReusableCellWithIdentifier:iden];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"PayMoenyDetailCell" owner:nil options:nil] lastObject];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    cell.paymoenyDetailModel=_data[indexPath.row];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

-(void)back{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


@end
