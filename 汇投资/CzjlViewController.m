//
//  CzjlViewController.m
//  汇投资
//
//  Created by 杨青源 on 14/11/6.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import "CzjlViewController.h"
#import "CzjlCell.h"
#import "WXDataService.h"
#import "CzjlModel.h"
#import "Reachability.h"
#import "UIViewExt.h"


@interface CzjlViewController ()

@end

@implementation CzjlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.bottom = self.view.bottom;
    self.nameTitle.text = @"充值记录";
    self.data = [[NSMutableArray alloc]init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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


- (void)loadData{
    NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"Cookie"];
    
    NSDictionary *dic1 = [[NSMutableDictionary alloc]init];
    
    [dic1 setValue:str forKey:@"Cookie"];
    
    
    NSString *url = @"http://app.huitouzi.com/htzApp/app/htz/rechargeLog.json?pageIndex=1&pageSize=10";
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
            CzjlModel *czjlModel = [[CzjlModel alloc]initWithDataDic:dic];
            [self.data addObject:czjlModel];
        }
        [_tableView reloadData];
    }else {
    
        UIAlertView *alterview = [[UIAlertView alloc]initWithTitle:nil message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
       [alterview show];
    }
}

#pragma mark
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _data.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *iden = @"cell_czjl";
    CzjlCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"CzjlCell" owner:nil options:nil]lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.czjlModel = _data[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

-(void)back{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
