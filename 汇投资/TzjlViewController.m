//
//  TzjlViewController.m
//  汇投资
//
//  Created by 杨青源 on 14/11/6.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//
#define ios6  ([[UIDevice currentDevice].systemVersion floatValue]==6)


#import "TzjlViewController.h"
#import "AppDelegate.h"
#import "TzjlCell.h"
#import "WXDataService.h"
#import "TzjlModel.h"

@interface TzjlViewController ()

@end

@implementation TzjlViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self  = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
  self.data=[NSMutableArray array];
    
    self.nameTitle.text = @"投资记录";

    self.data = [[NSMutableArray alloc] init];
    [self loadData:_whButton];
    if (ios6) {
        self.whButton.frame = CGRectMake(0, 44, 160, 42);
        self.yhButton.frame = CGRectMake(160, 44, 160, 42);
        self.leftSelectView.frame = CGRectMake(0, 87, 160, 2);
        self.rightSelectView.frame = CGRectMake(160, 87, 160, 2);
        self.centerSelectimg.frame = CGRectMake(160, 55, 1, 21);
    }
    
}


- (void)loadData:(id)sender{
    
    NSString *userId = [[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfor"]objectForKey:@"user_id"];
    NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"Cookie"];
    NSDictionary *dic1 = [[NSMutableDictionary alloc]init];
    [dic1 setValue:str forKey:@"Cookie"];
    if (sender == _whButton) {
        NSString *url = [NSString stringWithFormat:@"http://app.huitouzi.com/htzApp/app/htz/investLog.json?user_id=%@&invest_status=1&pageIndex=1&pageSize=20",userId];
        [WXDataService requestWithURL:url params:nil httpMethod:@"POST" block:^(id result) {
            [self _loadFinsh:result];
        } requestHeader:dic1];
    }
    else if(sender == _yhButton){
        NSString *url = [NSString stringWithFormat:@"http://app.huitouzi.com/htzApp/app/htz/investLog.json?user_id=%@&invest_status=2&pageIndex=1&pageSize=20",userId];
        [WXDataService requestWithURL:url params:nil httpMethod:@"POST" block:^(id result) {
            [self _loadFinsh:result];
        } requestHeader:dic1];
    }
    
}
- (void)_loadFinsh:(id)result{
    
    NSString *code = [result objectForKey:@"code"];
    NSString *msg = [result objectForKey:@"msg"];
    if ([code integerValue] == 0000) {
        NSArray *arr =  [[result objectForKey:@"data"] objectForKey:@"list"];
        
        for (NSDictionary *dic in arr) {
            TzjlModel *tzjlModel = [[TzjlModel alloc]initWithDataDic:dic];
            [self.data addObject:tzjlModel];
        }
        
        [_tableView reloadData];
    }else {
        UIAlertView *altview = [[UIAlertView alloc]initWithTitle:msg message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [altview show];
    
    }

}
#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *iden = @"cell_tzjl";
    TzjlCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"TzjlCell" owner:nil options:nil]lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.tzjlModel=_data[indexPath.row];

    if (self.whButton.selected) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"TzjlCell" owner:nil options:nil]lastObject];
    }
    if (self.yhButton.selected) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"TzjlCell" owner:nil options:nil]lastObject];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}

-(void)back{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
// 未还款
- (IBAction)whButton:(id)sender {
    _leftSelectView.backgroundColor=[UIColor orangeColor];
    _rightSelectView.backgroundColor=[UIColor lightGrayColor];
    [_data removeAllObjects];
    [self loadData:sender];
  
}
- (IBAction)yhButton:(id)sender {
    [_data removeAllObjects];
    _rightSelectView.backgroundColor=[UIColor orangeColor];
    _leftSelectView.backgroundColor=[UIColor lightGrayColor];
    
    [self loadData:sender];

}


@end