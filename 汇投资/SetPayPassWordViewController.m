//
//  SetPayPassWordViewController.m
//  汇投资
//
//  Created by 杨青源 on 14/11/28.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import "SetPayPassWordViewController.h"
#import "WXDataService.h"

@interface SetPayPassWordViewController ()

@end

@implementation SetPayPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameTitle.text = @"设置支付密码";

}





- (IBAction)showPasswordAction:(id)sender {
    if (self.passWord.secureTextEntry == YES) {
        [self.passwordBurron setImage:[UIImage imageNamed:@"眼睛标图标选中.png"] forState: UIControlStateNormal];
        self.passWord.secureTextEntry = NO;
    }else if (self.passWord.secureTextEntry == NO){
        [self.passwordBurron setImage:[UIImage imageNamed:@"眼睛图标没选.png"] forState: UIControlStateNormal];
        self.passWord.secureTextEntry = YES;
    
    
    }
   
    
}

- (IBAction)confirmPWShowAction:(id)sender {
    
    if (self.passWordConfim.secureTextEntry == YES) {
        [self.confirmPWButton setImage:[UIImage imageNamed:@"眼睛标图标选中.png"] forState: UIControlStateNormal];
        self.passWordConfim.secureTextEntry = NO;
    }else if (self.passWordConfim.secureTextEntry == NO){
        [self.confirmPWButton setImage:[UIImage imageNamed:@"眼睛图标没选.png"] forState: UIControlStateNormal];
        self.passWordConfim.secureTextEntry = YES;
        
        
    }
    
}

- (IBAction)buttonAction:(id)sender {
    
    if (self.passWord.text.length ==0 ||self.passWordConfim.text.length==0) {
        UIAlertView *alterView = [[UIAlertView alloc]initWithTitle:@"请输入完整信息" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alterView show];
        return;
    }
    if (![self.passWord.text isEqualToString:self.passWordConfim.text]) {
        UIAlertView *alterView = [[UIAlertView alloc]initWithTitle:@"密码输入不一致" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alterView show];
        return;
    }
    if (self.passWord.text.length <8 || self.passWordConfim.text.length >16) {
        
        UIAlertView *alterView = [[UIAlertView alloc]initWithTitle:@"密码为8－16个字符" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alterView show];
        return;
    }
    
  
    NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"Cookie"];
    
    NSDictionary *dic1 = [[NSMutableDictionary alloc]init];
    
    [dic1 setValue:str forKey:@"Cookie"];
    NSString *urlstr = [NSString stringWithFormat:@"http://app.huitouzi.com/htzApp/app/htz/updatepaypass.json?password=%@",self.passWord.text];
    [WXDataService requestWithURL:urlstr params:nil httpMethod:@"POST" block:^(id result) {
        [self loadFinsh:result];
    } requestHeader:dic1];
    
}

- (void)loadFinsh:(id)result{

    NSString *code = [result objectForKey:@"code"];
    NSString *msg = [result objectForKey:@"msg"];
    if ([code integerValue] == 0000) {
        UIAlertView *alterView = [[UIAlertView alloc]initWithTitle:msg message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        
    
        
        [alterView show];
        [self back];
        
    }else if([code integerValue] == 2000||[code integerValue]== 2001){
    
        UIAlertView *alterView = [[UIAlertView alloc]initWithTitle:msg message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
        [alterView show];
        [self back];
    }



}

- (void)back{

    [self.navigationController popViewControllerAnimated:YES];

}

@end
