//
//  LicaiNowInvestViewController.m
//  汇投资
//
//  Created by 杨青源 on 14/11/25.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#import "LicaiNowInvestViewController.h"
#import "QCheckBox.h"
#import "WXDataService.h"
#import "UIViewExt.h"
#import "MBProgressHUD.h"
#import "SanUrlWebViewController.h"
#import "NetService.h"



@interface LicaiNowInvestViewController (){
    
    QCheckBox *_check2;
    QCheckBox *_check3;
    NSString *mid;
    UIActivityIndicatorView *activiteView;
    MBProgressHUD   *HUD;
    UIButton *button;
}


@end


@implementation LicaiNowInvestViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.quanList = [[NSArray alloc]init];
    [self loadData];
    [self _initView];
   self.quanListView.hidden = YES;
    [self _initCheakView];
    self.nameTitle.text = @"投资确认";
    if (self.pushMoney.text != nil) {
           [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(myvalueChange) name:@"UITextFieldTextDidEndEditingNotification" object:self.pushMoney];
    }else{
    
        [[NSNotificationCenter defaultCenter]removeObserver:self name:@"UITextFieldTextDidChangeNotification" object:self.pushMoney];
    }
    


}



//财神劵下拉控件
- (void)_initView{

    bankButton = [UIButton buttonWithType:UIButtonTypeCustom];
    bankButton.frame = CGRectMake(70, self.quanListView.top-6, 250, 50);
    
 
   
    
    [bankButton setTitle:@"请选择加息劵" forState:UIControlStateNormal];
    [bankButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [bankButton addTarget:self action:@selector(bankAction:) forControlEvents:UIControlEventTouchUpInside];
    [bankButton setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:bankButton];
    


}

- (void)bankAction:(id)sender{
    NSMutableArray *arr = [NSMutableArray arrayWithArray:[self.csqShowdic allKeys]];
    [arr insertObject:@"不使用加息劵" atIndex:0];
    
    if(dropDown == nil) {
        CGFloat f = 200;
        if (self.quanList.count == 0) {
            self.quanList=@[@"当前无可用加息劵"];
            
        }
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :arr];
        dropDown.delegate = self;
    }
    else {
        [dropDown hideDropDown:sender];
        [self rel];
    }
    
}


- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
    [self rel];
}

-(void)rel{
    
    dropDown = nil;
}

- (void)myvalueChange{
   
    if (self.pushMoney.text.length == 0) {
        return;
    }
    if ([self.canUseMoney.text integerValue] < [self.pushMoney.text integerValue]) {
        self.messageLabel.text = @"账户余额不足请充值";
        return;
    }
    
    NSString *_mid = [self.csqShowdic objectForKey:bankButton.titleLabel.text];
    if (self.pushMoney.text != nil) {
        NSString *reward = @"0";
        if ([bankButton.titleLabel.text isEqualToString:@"请选择加息劵"]||[bankButton.titleLabel.text isEqualToString:@"不使用加息劵"] ) {
           _mid =@"0";
        }
        
        if(_check2.checked){
            reward = self.CSLabel.text;
        }
        NSString *url = [NSString stringWithFormat:@"http://app.huitouzi.com/htzApp/app/free/invest/tender_calc.json?pid=%@&amount=%@&isRepeat=0&mid=%@&reward=0",self.projectID,self.pushMoney.text,_mid];

        [WXDataService requestWithURL:url params:nil httpMethod:@"POST" block:^(id result) {
            [self LOADgetMoneyFinsh:result];
        } requestHeader:nil];
    }else   if (self.pushMoney.text == nil){
        
        UIAlertView *alterView = [[UIAlertView alloc]initWithTitle:@"请输入投资金额" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [alterView show];
        
    }
    



}
- (void)LOADgetMoneyFinsh:(id)result{
    NSString *code = [result objectForKey:@"code"];
    NSString *msg = [result objectForKey:@"msg"];
    if ([code integerValue]== 0000) {
        NSDictionary *dic = [result objectForKey:@"data"];
      
        

        
         self.CSLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"need_reward_money"]];
        if ([[dic objectForKey:@"app_aval_reward"] integerValue] ==1) {
            if ([NSString stringWithFormat:@"%@",[dic objectForKey:@"need_reward_money"]] != nil) {
                
                self.CSLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"avalible_rewardmoney"]];
            }else if ([[dic objectForKey:@"app_aval_reward"] integerValue]==2){
            
                _check2.hidden = YES;
               
            }
        }
      
        
        
        
    }else if([code integerValue]== 2000 ){
       
        
        UIAlertView *alterview = [[UIAlertView alloc]initWithTitle:msg message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alterview show];
    
    
    
    }else if([code integerValue]==2001){
    
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userInfor"];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"Cookie"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        UIAlertView *alterview = [[UIAlertView alloc]initWithTitle:msg message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alterview show];
       
    
    }
    



}



-(void)_initCheakView{
    
    
    _check2 = [[QCheckBox alloc] initWithDelegate:self];
    _check2.frame = CGRectMake(200, 0, 100, 40);
    [_check2 setTitle:@"用红包支付" forState:UIControlStateNormal];
    [_check2 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_check2.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
    [self.csQuanView addSubview:_check2];
    
    _check3 = [[QCheckBox alloc] initWithDelegate:self];
    [_check3 setChecked:TRUE];
   
    _check3.frame = CGRectMake(20, self.payButton.top-40, 20, 20);
    [_check3 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_check3.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
    [self.view addSubview:_check3];
   button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(URLButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [button setTitle:@"信贷及担保合同" forState:UIControlStateNormal];
    button.frame = CGRectMake(30, self.payButton.top-40, 150, 21);
    [self.view addSubview:button];
    
}

- (void)URLButtonAction:(UIButton *)button{
    SanUrlWebViewController *webView = [[SanUrlWebViewController alloc]init];
    webView.urlStr = self.urlStr;
    [self presentViewController:webView animated:YES completion:nil];
   



}

#pragma mark - 加载数据

- (void)loadData{
    NSString *url =  [NSString stringWithFormat:@"http://app.huitouzi.com/htzApp/app/free/invest/detail.json?pid=%@",self.projectID];
    
    NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"Cookie"];
    
    NSDictionary *dic1 = [[NSMutableDictionary alloc]init];
    
    [dic1 setValue:str forKey:@"Cookie"];
  [WXDataService requestWithURL:url params:nil httpMethod:@"GET" block:^(id result) {
      
   
      [self loadDataFinsh:result];
     
      
  } requestHeader:dic1];

    



}

- (void)loadDataFinsh:(id)result{

/*
 {
 "msg" : "",
 "data" : {
 "app_aval_reward" : "1",
 "available_invest_money_display" : "2,465,000.00",
 "start_money" : 1000,
 "available_invest_money" : 2465000,
 "add_rate" : 0,
 "quanList" : [
 
 ],
 "app_aval_rewardquan" : "1",
 "avalible_use_display" : "19,989,638.86",
 "avalible_use" : "19989638.86",
 "mammonNotice" : 0,
 "contract_url" : "http:\/\/www.huitouzi.com\/xhtml_template\/contract_current.xhtml",
 "rebate" : 0.5,
 "avalible_rewardmoney" : "83",
 "contract_name" : "借贷及担保服务协议",
 "is_rebate" : "1"
 },
 "code" : "0000"
 }
 
 */

    NSString *code = [result objectForKey:@"code"];
    NSString *msg = [result objectForKey:@"msg"];
    if ([code integerValue] == 0000) {
        NSDictionary *dataData = [result objectForKey:@"data"];
        NSString *app_aval=   [dataData objectForKey:@"app_aval_reward"];

        self.CSLabel.text = [dataData objectForKey:@"avalible_rewardmoney"];
        self.urlStr = [dataData objectForKey:@"contract_url"];
        if([@"1" isEqualToString:app_aval]){
            self.csQuanView.hidden = NO;
            
            
            
        }
        if ([@"1" isEqualToString:[dataData objectForKey:@"app_aval_rewardquan"]]) {
            self.quanListView.hidden = NO;
            bankButton.hidden =NO;
        }else {
            self.quanListView.hidden = YES;
            bankButton.hidden =YES;
        }
        
        if (self.csQuanView.hidden == YES && self.quanListView.hidden == YES) {
           
            
            self.paypasswordView.frame = CGRectMake(0, self.pushmoneyView.bottom +40, kScreenWidth, 40);
            _check3.frame = CGRectMake(20, self.paypasswordView.bottom+25, 10, 10);
            button.frame = CGRectMake(30,self.paypasswordView.bottom+20 , 150, 21);
            self.messageLabel.frame = CGRectMake(10, self.paypasswordView.bottom +40, 212, 21);
            self.payButton.frame = CGRectMake(10, self.paypasswordView.bottom+60, kScreenWidth-20, 45);
            
            
        }else if (self.csQuanView.hidden == NO &&self.quanListView.hidden == YES){
           self.paypasswordView.frame = CGRectMake(0, self.csQuanView.bottom +20, kScreenWidth, 40);
            _check3.frame = CGRectMake(20, self.paypasswordView.bottom+25, 10, 10);
            button.frame = CGRectMake(30,self.paypasswordView.bottom+20 , 150, 21);
            self.messageLabel.frame = CGRectMake(10, self.paypasswordView.bottom +40, 212, 21);
            self.payButton.frame = CGRectMake(10, self.paypasswordView.bottom+60, kScreenWidth-20, 45);
        }else {
        
        }
        
        
        self.canUseMoney.text = [NSString stringWithFormat:@"%@",[dataData objectForKey:@"avalible_use"]];
        
        self.canPushMony.text = [NSString stringWithFormat:@"%@",[dataData objectForKey:@"available_invest_money"]];
       
       NSString *contractName = [dataData objectForKey:@"contract_name"];
        [button setTitle:contractName forState:UIControlStateNormal];
           self.csqShowdic = [[NSMutableDictionary alloc]init];
        self.quanList = [dataData objectForKey:@"quanList"];
  
        for (NSDictionary *quan in [dataData objectForKey:@"quanList"]) {
            
            /*
             quanList：[
             {“code”:“1238idsds”,//财神券名称
             ”rate”:“0.3”,//财神券利率
             “quan_id”:1//财神券ID},{“code”:“wer34343”,//财神券名称
             ”rate”:“1.0”,//财神券利率
             “quan_id”:2//财神券ID }]
             }，
             */
            NSString *code = [quan objectForKey:@"code"];
            NSString *rate = [quan objectForKey:@"rate"];
            NSString *showQuan = [NSString stringWithFormat:@"%@ (%@%%)",code,rate];
           
             NSNumber *number = [quan objectForKey:@"id"];
            NSString *csId = [NSString stringWithFormat:@"%@",number];
         
            
            [self.csqShowdic setObject:csId forKey:showQuan];
          
            
        }

     
        
    }else if([code integerValue] == 2000){
        UIAlertView *alterview = [[UIAlertView alloc]initWithTitle:msg message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
       
        [alterview show];
    
    }else if ([code integerValue]== 2001){
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userInfor"];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"Cookie"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        UIAlertView *alterView = [[UIAlertView alloc]initWithTitle:msg message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [alterView show];
    
    
    }
}


#pragma mark - QCheckBoxDelegate

- (void)didSelectedCheckBox:(QCheckBox *)checkbox checked:(BOOL)checked {
    NSLog(@"did tap on CheckBox:%@ checked:%d", checkbox.titleLabel.text, checked);

}


- (void)back{

    [self dismissViewControllerAnimated:YES completion:nil];

}
- (IBAction)payAction:(id)sender {
    
    if (self.pushMoney.text.length == 0) {
        UIAlertView *alterView = [[UIAlertView alloc]initWithTitle:@"请输入投资金额" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alterView show];
        return;
    }
    if (self.password.text.length == 0) {
        UIAlertView *alterView = [[UIAlertView alloc]initWithTitle:@"请输入支付密码" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alterView show];
        return;
    }
    
    if (_check3.checked == NO) {
        UIAlertView *alterView = [[UIAlertView alloc]initWithTitle:@"请勾选合同" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alterView show];
        return;
    }
    NSString *vitualMoney = @"0";
   
    
    if(_check2.checked == YES){
        vitualMoney = [NSString stringWithString:self.CSLabel.text];
            }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    NSMutableDictionary *paras = [[NSMutableDictionary alloc]init];
    [paras setObject:self.projectID forKey:@"pid"];
    [paras setObject:self.pushMoney.text forKey:@"invest_amount"];
    [paras setObject:self.password.text forKey:@"paypassword"];
    [paras setObject:vitualMoney forKey:@"virtual_money"];
    
    NSString *mycodeid = @"0";
 
  
   
    if ([bankButton.titleLabel.text isEqualToString:@"请选择加息劵"] ||[bankButton.titleLabel.text isEqualToString:@"不使用加息劵"] ) {
        
    }else{
     mycodeid =[NSString stringWithFormat:@"%@",[self.csqShowdic objectForKey:bankButton.titleLabel.text]];
    
    }
 
    NSLog(@"财神卷%@",mycodeid);
    [paras setObject:mycodeid forKey:@"user_quan_id"];
    [paras setObject:@"3" forKey:@"source"];
    NSLog(@"参赛：%@",paras);
    [NetService post:@"htz/invest/ajaxsave.json" parameters:paras
             success:^(id responseObject) {
                 UIAlertView *alterView = [[UIAlertView alloc]initWithTitle:@"投资成功"  message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
                 
                 [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                 [alterView show];
                 [alterView dismissWithClickedButtonIndex:0 animated:YES];
                 [self dismissViewControllerAnimated:YES completion:nil];
             } failure:^(NSString *error) {
                 [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
             } netError:^(NSString *error) {
                 [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
             }];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.pushMoney resignFirstResponder];
    [self.password resignFirstResponder];
    
}




@end
