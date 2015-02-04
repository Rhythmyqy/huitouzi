//
//  RechargeViewController.m
//  汇投资
//
//  Created by 杨青源 on 14/11/24.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//
#define ios6  ([[UIDevice currentDevice].systemVersion floatValue]==6)


#import "RechargeViewController.h"
#import "RechargeWebViewController.h"
#import "WXDataService.h"
#import "FastPayViewController.h"
#import "AppDelegate.h"
#import "LoadBankCarList.h"
#import "MyTXCarListViewController.h"


@interface RechargeViewController (){

    UIButton *bankButton;
    NIDropDown *dropDown;
    NSMutableArray *fastPayArry;
    LoadBankCarList *loadBankmyCar;
    UIAlertView *myalterview;
}

@end

@implementation RechargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _initView];
    
    loadBankmyCar=[[LoadBankCarList alloc]init];
    [loadBankmyCar getMyBankList];
}

- (void)viewWillAppear:(BOOL)animated{
    NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"myquickbankName"];
    if (str != nil) {
        [bankButton setTitle:str forState:UIControlStateNormal];
    }
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"myquickbankName"];
    [[NSUserDefaults standardUserDefaults]synchronize];


}
- (void)_initView{


    self.nameTitle.text = @"账户充值";
 
    
    bankButton = [UIButton buttonWithType:UIButtonTypeCustom];
    bankButton.frame = CGRectMake(40, 120, 230, 40);
    [bankButton setTitle:@"请选择银行卡" forState:UIControlStateNormal];
    bankButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [bankButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [bankButton setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:bankButton];
    
    [bankButton addTarget:self action:@selector(bankAction:) forControlEvents:UIControlEventTouchUpInside];
        
    if (ios6) {
        bankButton.frame = CGRectMake(40, 100, 230, 40);
        self.nextButton.frame = CGRectMake(15, 227, 290, 50);
        self.mycarView.frame = CGRectMake(0, 94, 320, 50);
        self.myMoneyView.frame = CGRectMake(0, 144, 320, 50);
        self.addcarButton.frame  =CGRectMake(176, 53, 129, 33);
    }
    

}








#pragma mark 银行下拉框

- (void)bankAction:(id)sender{
    
    if ([loadBankmyCar.myQuickBankShow allKeys].count == 0) {
        myalterview = [[UIAlertView alloc]initWithTitle:@"未绑定充值银行卡" message:@"去绑定？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        myalterview.tag = 110;
        [myalterview show];
        return;
    }
    
    MyTXCarListViewController *mycarList = [[MyTXCarListViewController alloc]init];
    [self.navigationController pushViewController:mycarList animated:YES];
    
//    if ([loadBankmyCar.myQuickBankShow allKeys].count == 0) {
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//        [self useNewCarAction:button];
//        return;
//    }
//
//    if(dropDown == nil) {
//        CGFloat f = 200;
//        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :[loadBankmyCar.myQuickBankShow allKeys]];
//        dropDown.delegate = self;
//    }
//    else {
//        [dropDown hideDropDown:sender];
//        [self rel];
//    }
}

- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
    [self rel];
}

-(void)rel{
    
    dropDown = nil;
}

-(void)back{

    [self.navigationController popToRootViewControllerAnimated:YES];

}

- (IBAction)confirmRecharge:(id)sender {
    /*
     
     url:  app/htz/iosrecharge
     请求参数：money：充值金额
     bindbankid 开通银行卡的id；
     返回数据：成功或失败
     例如：
     http://app.huitouzi.com/htzApp/app/htz/iosrecharge.json?money=0.01&bindbankid=74
     */
//    NSString *str = self.rechargeNum.text;
    if (self.rechargeNum.text.length==0) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"请输入充值金额" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    if ([loadBankmyCar.myQuickBankShow objectForKey:bankButton.titleLabel.text] == nil) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"请选择支付方式" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    
    

    RechargeWebViewController *webVC = [[RechargeWebViewController alloc]init];
    webVC.moneyneed = self.rechargeNum.text;
  webVC.bankID =  [loadBankmyCar.myQuickBankShow objectForKey:bankButton.titleLabel.text];
    [self presentViewController:webVC animated:YES completion:nil];
    

    
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

   
    if (alertView == myalterview) {
        if (buttonIndex == 0) {
            FastPayViewController *fastPayViewVC = [[FastPayViewController alloc]init];
            [self.navigationController pushViewController:fastPayViewVC animated:YES];
        }
    }


}


- (IBAction)useNewCarAction:(id)sender {
    
 
    
    FastPayViewController *fastPayViewVC = [[FastPayViewController alloc]init];

    
    
    [self.navigationController pushViewController:fastPayViewVC animated:YES];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.rechargeNum resignFirstResponder];
}
@end
