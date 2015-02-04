//
//  NowInvestmentViewController.m
//  汇投资
//
//  Created by 杨青源 on 14/11/18.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import "NowInvestmentViewController.h"
#import "WXDataService.h"
#import "QCheckBox.h"
#import "LoginViewController.h"
#import "MBProgressHUD.h"
#import "URLWebViewViewController.h"
#import "NetService.h"

@interface NowInvestmentViewController ()

@end

@implementation NowInvestmentViewController{

    NSString *userId;
    QCheckBox *_check2;
    UIAlertView *_alertView1;
    UIButton *button;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameTitle.text = @"立即投资";
    [self loadData];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(valueChange) name:@"UITextFieldTextDidChangeNotification" object:nil];
    [self _initCheakView];
}

-(void)_initCheakView{


    _check2 = [[QCheckBox alloc] initWithDelegate:self];
    _check2.frame = CGRectMake(20, 360, 20, 20);
    [_check2 setChecked:true];
    [_check2 setTitle:@"" forState:UIControlStateNormal];
    [_check2 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_check2.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
    [self.view addSubview:_check2];
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(40, 360, 200, 20);
    [button setTitle:@"信贷及担保协议" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    

}

- (void)buttonAction:(UIButton *)button{

    URLWebViewViewController *urlWeb = [[URLWebViewViewController alloc]init];
    urlWeb.urlStr = self.geturl;
    
    [self presentViewController:urlWeb animated:YES completion:nil];


}


#pragma mark - QCheckBoxDelegate

- (void)didSelectedCheckBox:(QCheckBox *)checkbox checked:(BOOL)checked {
    NSLog(@"did tap on CheckBox:%@ checked:%d", checkbox.titleLabel.text, checked);
}

- (void)loadData{


    
  
    NSString *url = [NSString stringWithFormat:@"http://app.huitouzi.com/htzApp/app/free/invest/detail.json?pid=%@",self.projectID];
    //http://app.huitouzi.com/htzApp/app/free/invest/detail.json?pid=119
    NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"Cookie"];
    NSDictionary *dic1 = [[NSMutableDictionary alloc]init];
    [dic1 setValue:str forKey:@"Cookie"];
        [WXDataService requestWithURL:url params:nil httpMethod:@"GET" block:^(id result) {
            if (result !=nil) {
                [self loadFinsh:result];
            }
            
        } requestHeader:dic1];
        

    
}



- (void)loadFinsh:(id)result{
   
    NSString *code = [result objectForKey:@"code"];
    
    NSString *msg = [result objectForKey:@"msg"];
    if ([code integerValue] == 2000) {
        _alertView1 = [[UIAlertView alloc]initWithTitle:@"" message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [_alertView1 show];
    }else if([code integerValue] == 0000){
    
    
        NSDictionary *dic = [result objectForKey:@"data"];
        self.geturl = [dic objectForKey:@"contract_url"];
        /*
         {data: {avalible_use：用户可用余额，
         start_money：项目最低投资金额，
         available_invest_money：项目可投金额 ，
         mammonNotice 财神计划一期是否返利（0--不返利；1--返利 ）（滚雪球没有），
         add_rate 财神计划一期返的利率的（滚雪球没有），
         is_rebate 财神计划二期是否返利：2--不返利；1--返利（滚雪球没有）
         rebate 财神计划二期返的利率（滚雪球没有）
         app_aval_reward 是否展示财神币，1-展示 2-不展示
         app_aval_rewardquan 是否展示财神券，1-展示 2-不展示
         avalible_rewardmoney：用户可用财神币（滚雪球没有），
         quanList：可用财神券（滚雪球没有）}，
         code：0000，
         msg：“”}
         */
        self.canUseMoney.text = [dic objectForKey:@"avalible_use"];
    self.canPushMoney.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"available_invest_money"]];
        NSString *str = [dic objectForKey:@"contract_name"];
        [button setTitle:str forState:UIControlStateNormal];
   
    }else if ([code integerValue]==2001){
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userInfor"];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"Cookie"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        UIAlertView *alterview = [[UIAlertView alloc]initWithTitle:msg message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alterview show];
      
    
    }
  


}




- (void)valueChange{
    

 

  
 
    NSString *URL1 = [NSString stringWithFormat:@"http://app.huitouzi.com/htzApp/app/free/invest/tender_calc.json?pid=%@&amount=%@&isRepeat=0&mid=0&reward=0",self.projectID,_pushNum.text];
    
    [WXDataService requestWithURL:URL1 params:nil httpMethod:@"POST" block:^(id result) {
      
        [self loadFinsh1:result];
    } requestHeader:nil];
    
    
    
    NSMutableString *string=[NSMutableString stringWithString:self.canUseMoney.text];
    
    
    [string replaceOccurrencesOfString:@"," withString:@"" options:1 range:NSMakeRange(0, string.length)];
    
  
    
    if ([_pushNum.text intValue] >[string intValue]) {
     
        _monyStatus.text = @"你的账户余额不足，请充值";
    }else{
    _monyStatus.text = @"";
    }
  
    
}


- (void)loadFinsh1:(id)result{
 NSInteger code = [[result objectForKey:@"code"] integerValue];
    if (code == 0000) {
        
       NSDictionary *dic = [result objectForKey:@"data"];
       NSString *money = [dic objectForKey:@"allRate"];
        NSString *use_money = [dic objectForKey:@"need_money"];
        _mayGetMoney.text = money;
        _mastPayMoney.text = use_money;
    }


}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.payPassword resignFirstResponder];
    [self.pushNum resignFirstResponder];
}

-(void)back{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
    
}



- (IBAction)payAction:(id)sender {
   
    if (_check2.checked == NO) {
        UIAlertView *alterview = [[UIAlertView alloc]initWithTitle:@"请勾选合同" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alterview show];
        return;
    }
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setObject:self.projectID forKey:@"pid"];
    [params setObject:self.pushNum.text forKey:@"invest_amount"];
    [params setObject:self.payPassword.text forKey:@"paypassword"];
    [params setObject:@"1" forKey:@"handleType"];
    [params setObject:@"3" forKey:@"source"];
    [NetService post:@"htz/fixincome/ajaxsave.json" parameters:params success:^(id responseObject) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"投资成功"
                                                           message:nil
                                                          delegate:self
                                                 cancelButtonTitle:nil
                                                 otherButtonTitles:nil];
        [alertView show];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [alertView dismissWithClickedButtonIndex:0 animated:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSString *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    } netError:^(NSString *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
    
    



}



@end
