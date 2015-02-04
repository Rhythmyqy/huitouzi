//
//  MoneyManageViewController.m
//  汇投资
//
//  Created by 杨青源 on 14-10-31.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//
#define ios6  ([[UIDevice currentDevice].systemVersion floatValue]==6)
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#import "MoneyManageViewController.h"
#import "AppDelegate.h"
#import "TXViewController.h"

#import "AppDelegate.h"
#import "CenterViewController.h"
#import "RechargeViewController.h"
#import "WXDataService.h"
#import "CarDetailViewController.h"
#import "Common.h"
#import "UIViewExt.h"

@interface MoneyManageViewController ()

@end

@implementation MoneyManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.nameTitle.text = @"资金管理";
    _data = [[NSDictionary alloc]init];
    if (ios6) {
     self.moneyTableView.frame = CGRectMake(0, 202, 320, 44*4);
        self.didGetMoney.frame = CGRectMake(0, 40, 320, 150);
        self.mygetmoneylabel.frame = CGRectMake(0, 130, 161, 40);
        self.myallmoneyLabel.frame = CGRectMake(160, 130, 161, 40);
        self.didGetMoneyLabel.frame = CGRectMake(0, 163, 161, 21);
        self.avaliable_money.frame = CGRectMake(160, 163, 161, 21);
        
    }else{
        self.moneyTableView.frame = CGRectMake(0, 222, 320, 44*4);
    }
    
    
    self.moneyTableView.separatorColor = [UIColor clearColor];
   
    [self loadData];
   
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self loadData];


}

- (void)loadFinsh:(id)result{
    NSString *code = [result objectForKey:@"code"];
    NSString *msg = [result objectForKey:@"msg"];
    if ([code integerValue] == 0000) {
       
        _data = [result objectForKey:@"data"];
        
        if ([_data objectForKey:@"accept_interest"]>0) {
            self.didGetMoneyLabel.text = [_data objectForKey:@"accept_interest"];
        }else if([_data objectForKey:@"accept_interest"]==0){
        
        self.didGetMoneyLabel.text = @"0";
        
        }
        
        
        if ([[_data objectForKey:@"all_money"] integerValue] >0) {
            self.avaliable_money.text = [_data objectForKey:@"all_money"];
        }else if([[_data objectForKey:@"all_money"] integerValue] ==0){
           self.avaliable_money.text = @"0";
        
        }
        
         [_moneyTableView reloadData];
        
        
    }else if([code integerValue] ==2000 ){
        UIAlertView *alterView =[[UIAlertView alloc]initWithTitle:msg message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alterView show];
    
    }else if([code integerValue]==2001){
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userInfor"];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"Cookie"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        UIAlertView *alterview = [[UIAlertView alloc]initWithTitle:msg message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alterview show];
        UIAlertView *alterView =[[UIAlertView alloc]initWithTitle:msg message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alterView show];
    
    
    
    }
    
   
    
/*
 {data:{
 reward_money:财神币数量,
 num_of_coupon：财神券个数,
 available_money:可用余额,
 withdraw:冻结金额，
 all_money:账户总金额,
 accept_                      interest:已收益金额，
 },
 code:0000,
 msg:}
 */


}

- (void)loadData{

    NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"Cookie"];
    NSDictionary *dic1 = [[NSMutableDictionary alloc]init];
    [dic1 setValue:str forKey:@"Cookie"];

//http://app.huitouzi.com/htzApp/app/htz/money.json
    [WXDataService requestWithURL:@"http://app.huitouzi.com/htzApp/app/htz/money.json" params:nil httpMethod:@"POST" block:^(id result) {
        [self loadFinsh:result];
    } requestHeader:dic1];





}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *iden =@"moneycell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:iden];
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [cell addSubview:lineView];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
       
   
    }
    if (indexPath.row == 0) {
        
        NSString *str = [_data objectForKey:@"available_money"];
        cell.textLabel.text =[NSString stringWithFormat:@"可用余额:%@元",[self getShowNum:str]];
        cell.detailTextLabel.text = @"充值";
    }else if(indexPath.row == 1){
        NSString *str = [_data objectForKey:@"withdraw"];
        cell.textLabel.text =[NSString stringWithFormat:@"冻结金额:%@元",[self getShowNum:str]];
        cell.detailTextLabel.text = @"提现";
    }else if(indexPath.row == 2){
        NSString *bankNum = [_data objectForKey:@"bank_num"];
        cell.textLabel.text = [NSString stringWithFormat:@"银行卡:%@张",[self getShowNum:bankNum]];
        cell.detailTextLabel.text = @"管理";
    }else if(indexPath.row == 3){
        //reward_money:财神币数量, num_of_coupon：财神券个数
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 43.5, kScreenWidth, 0.5)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [cell addSubview:lineView];
        NSString *reward_moner = [_data objectForKey:@"num_of_coupon"];
        NSString *num_of_coupon = [_data objectForKey:@"reward_money"];
        NSString *str1 = [NSString stringWithFormat:@"加息券:%@张      红包:%@元",[self getShowNum:reward_moner],[self getShowNum:num_of_coupon]];
        cell.textLabel.text = str1;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}
-(NSString*)getShowNum:(NSString*)data{
    return data?data:@"";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 1) {
        TXViewController *txCtrl = [[TXViewController alloc]init];
        [self.navigationController pushViewController:txCtrl animated:YES];
        
    }else if(indexPath.row == 2){

        CarDetailViewController *cardetaivc = [[CarDetailViewController alloc]init];
        [self.navigationController pushViewController:cardetaivc animated:YES];
    
    }else if(indexPath.row == 0){
        RechargeViewController *rechargeViewVC = [[RechargeViewController alloc]init];
        [self.navigationController pushViewController:rechargeViewVC animated:YES];
    }

}

- (IBAction)tzAction:(id)sender {
    
    CenterViewController *centerview = [[CenterViewController alloc]init];
    [self.navigationController pushViewController:centerview animated:YES];
   
    
    [centerview.navigationController setNavigationBarHidden:YES];
    UINavigationBar *bar = [[UINavigationBar alloc]init];
    if (ios6) {
        bar.frame = CGRectMake(0, 0, kScreenWidth, 44);
        [bar setBackgroundImage:[UIImage imageNamed:@"top_btn6.png"] forBarMetrics:UIBarMetricsDefault];
        
    }else{
        bar.frame = CGRectMake(0, 0, kScreenWidth, 64);
        
        
        
        [bar setBackgroundImage:[UIImage imageNamed:@"top_btn.png"] forBarMetrics:UIBarMetricsDefault];
    }
    UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:nil];
    //左边按钮
    UIButton *left = [UIButton buttonWithType:UIButtonTypeCustom];
    [left setFrame:CGRectMake(0, 2, 28, 28)];
    [left setImage:[UIImage imageNamed:@"头像.png"] forState:UIControlStateNormal];
    [left addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:left];
    [item setLeftBarButtonItem:leftButton];
    //中间图标
    UIButton *title = [UIButton buttonWithType:UIButtonTypeCustom];
    [title setFrame:CGRectMake(0, 2, 32, 32)];
    [title setImage:[UIImage imageNamed:@"LOGO.png"]forState:UIControlStateNormal];
    
    [item setTitleView:title];
    
    
    [bar pushNavigationItem:item animated:NO];
    
    [centerview.navigationController.view addSubview:bar];
    
}

- (void)back{
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate.mmViewCtrl toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    
}

@end
