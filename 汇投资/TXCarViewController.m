//
//  TXCarViewController.m
//  汇投资
//
//  Created by 杨青源 on 14/11/6.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import "TXCarViewController.h"
#import "CarDetailViewController.h"
#import "AppDelegate.h"
#import "WXDataService.h"
#import "LoadBankCarList.h"
#import "HZAreaPickerView.h"
#import "bankCarListViewController.h"
#import "MBProgressHUD.h"

@interface TXCarViewController () <HZAreaPickerDelegate>
{
    LoadBankCarList *loadBank;//加载支持的银行卡
    BOOL bankseletType;
    BOOL sfSeletType;
    BOOL citySeletType;
    BOOL isPickerShow;
    NSInteger seconds;
    NSString *provinceId;
    NSString *cityId;
}
@end

@implementation TXCarViewController{


  NSMutableArray *chooseArray ;
    NSMutableArray *bankNameArr;
    NSMutableDictionary *bankNameAndID;//银行卡 和id 字典
    
  
}

- (void)viewWillAppear:(BOOL)animated{


    NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"bankName"];
    if (str != nil) {
       [self.bankButton setTitle:str forState:UIControlStateNormal];
    }
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"bankName"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    

}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameTitle.text = @"添加提现银行卡";
    bankNameAndID = [[NSMutableDictionary alloc]init];

    isPickerShow = NO;
    loadBank = [[LoadBankCarList alloc] init];
    [loadBank getBankList];//异步加载银行卡

    [loadBank getUnitsList];//异步记载省市
    [self _initView];
    bankseletType = 0;
    seconds =90;
    
    
}



- (void)_initView{

    self.bankButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.bankButton.frame = CGRectMake(90, 80, 230, 40);
    [self.bankButton setTitle:@"请选择银行" forState:UIControlStateNormal];
    [self.bankButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.bankButton setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:self.bankButton];
    
    [self.bankButton addTarget:self action:@selector(bankAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    bankButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    bankButton1.frame = CGRectMake(90, 190, 230, 40);
    [bankButton1 setTitle:@"请选择省份" forState:UIControlStateNormal];
    [bankButton1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [bankButton1 setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:bankButton1];
    
    [bankButton1 addTarget:self action:@selector(bankAction1:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)pickerDidChaneStatus:(HZAreaPickerView *)picker
{
    
    if(picker.locate.provinceId != nil){
        provinceId =picker.locate.provinceId;
    
    }else{
    
    provinceId = @"2";
    }
    
    
    cityId = picker.locate.cityId;
    NSString *title = [NSString stringWithFormat:@"%@ %@", picker.locate.provinceName,picker.locate.cityName];
    [bankButton1 setTitle:title forState:UIControlStateNormal];
    
}
- (void)bankAction1:(id)sender{
    if(isPickerShow){
        return;
    }
    isPickerShow = YES;
    //NSMutableArray *provinces = [[NSMutableArray alloc]initWithArray:loadBank.provinceArray];
   

    
        self.locatePicker = [[HZAreaPickerView alloc] initWithStyle:self provinces:loadBank.provinceArray];
        [self.locatePicker showInView:self.view];
    
}

- (void)bankAction:(id)sender{
    
    bankCarListViewController *bankVC = [[bankCarListViewController alloc]init];
    [self.navigationController pushViewController:bankVC animated:YES];
    bankseletType = 1;
//  NSLog(@"bankcar:%@",[loadBank.bankNameAndID allKeys]);
//    bankseletType = 1;
//    if(dropDown == nil) {
//        CGFloat f = 200;
//        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :[loadBank.bankNameAndID allKeys]];
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
  
    [self.navigationController popViewControllerAnimated:YES];
    
  }

- (IBAction)getCodeNum:(id)sender {
    
      NSString *phone = [[[NSUserDefaults standardUserDefaults]objectForKey:@"userInfor"]objectForKey:@"phone"];
    NSString *str = [NSString stringWithFormat:@"http://app.huitouzi.com/htzApp/app/free/getPhoneMsgCode.json?phone=%@&innerType=3",phone];
    
  [WXDataService requestWithURL:str params:nil httpMethod:@"post" block:^(id result) {
    
  } requestHeader:nil];
_timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];

    
}


-(void)timerFireMethod:(NSTimer *)theTimer {
    if (seconds == 1) {
        [theTimer invalidate];
        seconds = 90;
        [_getCodeNumButton setTitle:@"重试" forState: UIControlStateNormal];
        [_getCodeNumButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_getCodeNumButton setEnabled:YES];
    }else{
        seconds--;
        NSString *title = [NSString stringWithFormat:@"%ld",(long)seconds];
        
        self.codeTimeLabel.text=title;
        [_getCodeNumButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_getCodeNumButton setEnabled:NO];
        [_getCodeNumButton setTitle:@"秒后重试" forState:UIControlStateNormal];
    }
}
- (void)loaddataFinsh:(id)result{
    NSString *code = [result objectForKey:@"code"];
    NSString *msg = [result objectForKey:@"msg"];
    if ([code integerValue] == 0000) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:msg message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }
    
    UIAlertView *alertView1 = [[UIAlertView alloc]initWithTitle:msg message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView1 show];
}


- (IBAction)addCarAction:(id)sender {
 
    if (bankseletType ==1 && self.bankNumtext.text.length >0 &&self.codeNumText.text.length>0) {
        NSString *bankid = [[NSString alloc]initWithFormat:@"%@",[loadBank.bankNameAndID objectForKey:self.bankButton.titleLabel.text]];
//    NSString *provinceID = [loadBank.provinceNameAndId objectForKey:bankButton1.titleLabel.text];
//    NSString *cityID = [loadBank.cityNameAndId objectForKey:bankButton2.titleLabel.text];
  

    NSString *baseUrl = @"http://app.huitouzi.com/htzApp/app/htz/withdrawbank.json?";
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    //添加请求头
    NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"Cookie"];
    [manager.requestSerializer setValue:str forHTTPHeaderField:@"Cookie"];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] initWithCapacity:2];
    
    /*
     url:  /app/htz/withdrawbank.json
     请求参数：bank_id：银行代号
     bankcard 银行卡号
     phonecode 短信验证码
     provinceId：省ID
     cityId：所在城市ID；
     返回数据：成功或失败
     例如：
     http://app.huitouzi.com/htzApp/app/htz/withdrawbank.json?bank_id=100&bankcard=6222020200109634509&phonecode=111111&provinceId=1&cityId=1
     */
    [parameters setObject:bankid forKey:@"bank_id"];
    [parameters setObject:self.bankNumtext.text forKey:@"bankcard"];
    [parameters setObject:self.codeNumText.text forKey:@"phonecode"];
    [parameters setObject:provinceId forKey:@"provinceId"];
    [parameters setObject:cityId forKey:@"cityId"];
    
    [manager POST:baseUrl parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
     
        
        NSString *code = [responseObject objectForKey:@"code"];
        NSString *message = [responseObject objectForKey:@"msg"];
        if ( [code intValue] == 2000 ||[code integerValue] == 2001) {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:message message:nil delegate:self cancelButtonTitle:@"重试" otherButtonTitles:nil];
            [alertView show];
        }else if ([code intValue] == 0000){
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:message message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    }else if(bankseletType == 0 || self.bankNumtext.text.length==0||self.codeNumText.text.length==0){
        UIAlertView *alterView = [[UIAlertView alloc]initWithTitle:@"请输入完整信息" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alterView show];
    
    }
    
    
}

- (void)loadDataFinsh:(id)result{
    NSString *code = [result objectForKey:@"code"];
    NSString *msg = [result objectForKey:@"msg"];
    if ([code integerValue] == 0000) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:msg message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
          [self.navigationController popViewControllerAnimated:YES];
    }else if([code integerValue]==2000||[code integerValue]==0000){
    
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:msg message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
      
    
    }
 
   


}
-(void)cancelLocatePicker
{
    [self.locatePicker cancelPicker];
    self.locatePicker.delegate = nil;
    self.locatePicker = nil;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    isPickerShow = NO;
    [self cancelLocatePicker];
    [self.bankNumtext resignFirstResponder];
    [self.codeNumText resignFirstResponder];
    
}
@end
