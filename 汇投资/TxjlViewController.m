//
//  TxjlViewController.m
//  汇投资
//
//  Created by 杨青源 on 14/11/6.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import "TxjlViewController.h"
#import "TxjlCell.h"
#import "WXDataService.h"
#import "TxjlModel.h"
#import "Reachability.h"

@interface TxjlViewController ()

@end

@implementation TxjlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.nameTitle.text = @"提现记录";
   
    self.data = [[NSMutableArray alloc]init];
    
    
    Reachability *r = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:{
            // 没有网络连接
          
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"未连接到网络"
                                                               message:nil
                                                              delegate:self
                                                     cancelButtonTitle:@"确定"
                                                     otherButtonTitles:nil];
            [alertView show];
        }
            break;
        case ReachableViaWWAN:{
            // 使用3G网络
            
            [self loadData];
            
        }
            break;
        case ReachableViaWiFi:{
            // 使用WiFi网络
            
            [self loadData];
        }
            
            break;
    }
    
    
    
}

- (void)viewWillAppear:(BOOL)animated{



}
- (void)loadData{
    // app.huitouzi.com/htzApp/app/htz/withdrawalLog.json?user_id=1397& pageIndex=1&pageSize=10
    NSString *userId = [[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfor"]objectForKey:@"user_id"];
    NSString *url = [NSString stringWithFormat:@"http://app.huitouzi.com/htzApp/app/htz/withdrawalLog.json?user_id=%@&pageIndex=1&pageSize=10",userId];
    NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"Cookie"];
    NSDictionary *dic1 = [[NSMutableDictionary alloc]init];
    [dic1 setValue:str forKey:@"Cookie"];
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
            
            
            TxjlModel *txjlModel = [[TxjlModel alloc]initWithDataDic:dic];
            
            
            
            
            [self.data addObject:txjlModel];
            
            
            
        }
        
        
        
        [_tableView reloadData];
    }else{
    
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:msg message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }
    
  
    
}
#pragma mark dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
  static NSString *iden = @"cell_txjl";
    TxjlCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"TxjlCell" owner:nil options:nil]lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.txjlModel=_data[indexPath.row];
    return cell;
}
#pragma mark -delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 150;
}
-(void)back{
    
    [self.navigationController popToRootViewControllerAnimated:YES];

}
@end
