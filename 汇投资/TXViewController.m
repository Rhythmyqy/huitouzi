//
//  TXViewController.m
//  汇投资
//
//  Created by 杨青源 on 14/11/6.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#import "TXViewController.h"

#import "NIDropDown.h"
#import "AppDelegate.h"
#import "WXDataService.h"
#import "LoadBankCarList.h"
#import "UIViewExt.h"
#import "NetService.h"
#import "MyquickCarListViewController.h"
#import "TXCarViewController.h"
#import "MBProgressHUD.h"

@interface TXViewController (){

    UIButton *bankButton;
    NIDropDown *dropDown;
    LoadBankCarList *loadBackShow;
    UIAlertView *myalterview;
}

@end

@implementation TXViewController

- (void)viewWillAppear:(BOOL)animated{
    NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"mydrawbankName"];
    if (str != nil) {
        [bankButton setTitle:str forState:UIControlStateNormal];
    }
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"mydrawbankName"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.nameTitle.text = @"账户提现";
    loadBackShow = [[LoadBankCarList alloc]init];
    [loadBackShow getMyBankList];
    self.myscrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight+44) ;
    self.myscrollView.backgroundColor = [UIColor clearColor];
    bankButton = [UIButton buttonWithType:UIButtonTypeCustom];
    bankButton.frame = CGRectMake(100, 228, 230, 40);
    [bankButton setTitle:@"请选择银行卡" forState:UIControlStateNormal];
    [bankButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    bankButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [bankButton setBackgroundColor:[UIColor clearColor]];
    [self.myscrollView addSubview:bankButton];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleMoney) name:@"UITextFieldTextDidEndEditingNotification" object:_cashmoney];
    [bankButton addTarget:self action:@selector(bankAction:) forControlEvents:UIControlEventTouchUpInside];
    [self loadData];

    
}

-(void)handleMoney{
    if (self.cashmoney.text.length == 0) {
        return;
    }
    
    
    
//http://app.huitouzi.com/htzApp/htz/cashfee.json? cashmoney=100
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:_cashmoney.text forKey:@"cashmoney" ];
    NSString *url = @"htz/cashfee.json";
    [NetService post:url parameters:dic success:^(id responseObject) {
        
        _handlingchargeLabel.text = [NSString stringWithFormat:@"%@元",[responseObject objectForKey:@"handleMoney"]];
    } failure:^(NSString *error) {
        
    } netError:^(NSString *error) {
        
    }];

    
 

}



//
-(void)loadData{
/*
 url:  /app/htz/cashapplypage.json
 请求参数：无
 返回数据：{msg:“”，code：“”，data：{name 真实姓名，
 ，available_money 可提现金额（double）
 ，available_money_format 可提现金额（格式化的）
 ，withdraw 提现申请冻结金额
 ，investrpay_money 免提现手续费额度}}
 例如：
 http://app.huitouzi.com/htzApp/app/htz/cashapplypage.json
 
 NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"Cookie"];
 
 NSDictionary *dic1 = [[NSMutableDictionary alloc]init];
 
 [dic1 setValue:str forKey:@"Cookie"];
 */
    NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"Cookie"];
    
    NSDictionary *dic1 = [[NSMutableDictionary alloc]init];
    
    [dic1 setValue:str forKey:@"Cookie"];
    NSString *url = @"http://app.huitouzi.com/htzApp/app/htz/cashapplypage.json";
  [WXDataService requestWithURL:url params:nil httpMethod:@"POST" block:^(id result) {
      [self loadFinsh:result];
  } requestHeader:dic1];
    
    
    
}

- (void)loadFinsh:(id)result{
    NSString *code = [result objectForKey:@"code"];
    NSString *msg = [result objectForKey:@"msg"];
    if ([code integerValue]== 0000) {
        NSDictionary *data = [result objectForKey:@"data"];
 
       
        
        self.canUserMoneyLabel.text =[ NSString stringWithFormat:@"%@元",[data objectForKey:@"available_money"] ];
        
        self.getFreeMoney.text = [NSString stringWithFormat:@"%@",[data objectForKey:@"withdraw"]];
        
        
        self.popMoney.text = [NSString stringWithFormat:@"%@元",[data objectForKey:@"investrpay_money"]];
        
    }else if([code integerValue] == 2000){
    
        UIAlertView *alterView = [[UIAlertView alloc]initWithTitle:msg message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alterView show];
    }else if([code integerValue]==2001){
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userInfor"];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"Cookie"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        UIAlertView *alterview = [[UIAlertView alloc]initWithTitle:msg message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alterview show];
    
    
    
    }
    



}



- (void)bankAction:(id)sender{
    
    if ([loadBackShow.mydrawPayBankShow allKeys].count == 0) {
        myalterview = [[UIAlertView alloc]initWithTitle:@"未绑定提现银行卡" message:@"去绑定？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        myalterview.tag = 110;
        [myalterview show];
        return;
    }
    
    MyquickCarListViewController *myquickVC = [[MyquickCarListViewController alloc]init];
    [self.navigationController pushViewController:myquickVC animated:YES];


}

-(void)rel{
    
    dropDown = nil;
}

- (IBAction)nextStep {
    
    if ([self.cashmoney.text intValue]<50) {
        UIAlertView *alterview = [[UIAlertView alloc]initWithTitle:@"最少提现金额50元" message:@"请重新输入" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alterview show];
        _cashmoney.text=nil;
        return;
    }else if([self.cashmoney.text integerValue]>[self.cashmoney.text integerValue]){
        UIAlertView *alterview = [[UIAlertView alloc]initWithTitle:@"用户余额不足" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alterview show];
        return;
    }if ([loadBackShow.mydrawPayBankShow objectForKey:bankButton.titleLabel.text] ==nil) {
        UIAlertView *alterview = [[UIAlertView alloc]initWithTitle:@"请输入银行卡" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alterview show];
        return;
        
    }
    if (_payPWTextField.text.length == 0) {
        UIAlertView *alterview = [[UIAlertView alloc]initWithTitle:@"请输入支付密码" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alterview show];
        return;
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    TXIdentifiViewController *txIdenVC = [[TXIdentifiViewController alloc]init];
//
//    txIdenVC.givemmony = self.cashmoney.text;
//    txIdenVC.bankdetail = bankButton.titleLabel.text;
//    txIdenVC.bankID = [loadBackShow.mydrawPayBankShow objectForKey:bankButton.titleLabel.text];
//    [self.navigationController pushViewController:txIdenVC animated:YES];
    //http://app.huitouzi.com/htzApp/app/
    //http://115.29.138.151:9180/htzApp/app/cash.json?cashmoney=100&cashbankId=75&paypassword=12345678
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:_cashmoney.text forKey:@"cashmoney"];
    [dic setObject:[loadBackShow.mydrawPayBankShow objectForKey:bankButton.titleLabel.text] forKey:@"cashbankId"];
    [dic setObject:_payPWTextField.text forKey:@"paypassword"];
    [NetService post:@"htz/cash.json" parameters:dic success:^(id responseObject) {
        
        UIAlertView *alterview = [[UIAlertView alloc]initWithTitle:@"申请提现成功" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [alterview show];
        [alterview dismissWithClickedButtonIndex:0 animated:YES];
        [self back];
    } failure:^(NSString *error) {
      [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    } netError:^(NSString *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES]; 
    }];


    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
    if (alertView == myalterview) {
        if (buttonIndex == 0) {
            TXCarViewController *txcarVC = [[TXCarViewController alloc]init];
            [self.navigationController pushViewController:txcarVC animated:YES];
        }
    }
    
    
}

-(void)back{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.cashmoney resignFirstResponder];
}
@end
