//
//  ForgetPWViewController.m
//  汇投资
//
//  Created by 杨青源 on 14/11/12.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import "ForgetPWViewController.h"
#import "WXDataService.h"

#import "SetPasswordViewController.h"
#import "AppDelegate.h"


@interface ForgetPWViewController (){
    UIAlertView *alterview1;
    UIAlertView *alterview2;
    UIAlertView *alterview3;
    UIAlertView *alterview4;
    NSInteger seconds;
}
@end

@implementation ForgetPWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   self.nameTitle.text = @"手机找回";
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changevlue) name:@"UITextFieldTextDidEndEditingNotification" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changevlue2) name:@"UITextFieldTextDidEndEditingNotification" object:nil];
    seconds =90;
    
    
}


- (void)viewWillAppear:(BOOL)animated{

[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(back) name:@"dismiss" object:nil];
}

//手机号
- (void)changevlue
{
    if (_phoneNumText.text.length <11&&_phoneNumText.text.length !=0) {
        alterview1 = [[UIAlertView alloc]initWithTitle:@"手机号为11位数字" message:@"请重新输入" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alterview1 show];
    }else if(_phoneNumText.text.length >11){
        alterview2 = [[UIAlertView alloc]initWithTitle:@"手机号为11位数字" message:@"请重新输入" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alterview2 show];
    }else if (_phoneNumText.text.length == 0){
        
    }
}
//验证码
- (void)changevlue2
{
    if (_codeText.text.length <6&&_codeText.text.length !=0) {
        alterview3 = [[UIAlertView alloc]initWithTitle:@"验证码为6位数字" message:@"请重新输入" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alterview3 show];
    }else if(_codeText.text.length >6){
        alterview4 = [[UIAlertView alloc]initWithTitle:@"验证码位6位数字" message:@"请重新输入" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alterview4 show];
    }else if (_codeText.text.length == 0){
        
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView == alterview1 || alertView == alterview2) {
        if (buttonIndex == 1) {
            _phoneNumText.text = nil;
        }
    }
    else if(alertView == alterview3 || alertView == alterview4) {
        if (buttonIndex == 1) {
            _codeText.text = nil;
        }
    }
}

//键盘代理方法
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.phoneNumText resignFirstResponder];
    [self.codeText resignFirstResponder];
}

#pragma mark 获取修改密码验证码
- (IBAction)getCodeAction:(id)sender {
   //http://app.huitouzi.com/htzApp/app/free/getPhoneMsgCode.json?phone=18614087813&innerType=12
    //innerType : 1: 注册验证邮箱 2: 手机号 3: 添加银行帐户 4: 债权转让手机动态码 5: 自动投资 6: 设置支付密码手机动态码 7: 找回支付密码手机动态码 8: 找回登录密码手机动态码 9:解冻资金 10: 删除银行卡 11: 验证身份-修改昵称、已验证手机、邮箱 12: 注册验证手机号 13: 企业融资申请 14: 提前赎回申请
    if ([self.phoneNumText.text integerValue]==0) {
        UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"请输入手机号" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        return;
    }
    NSString *phone =  self.phoneNumText.text;
    NSMutableDictionary *mdic = [[NSMutableDictionary alloc]init];
    
    [mdic setValue:phone forKey:@"phone"];
    [mdic setValue:@"8" forKey:@"innerType"];
   // NSString *url = @"http://app.huitouzi.com/htzApp/app/free/getPhoneMsgCode.json?";
    NSString *url = [NSString stringWithFormat:@"http://app.huitouzi.com/htzApp/app/free/getPhoneMsgCode.json?phone=%@&innerType=8",phone];
    
   [WXDataService requestWithURL:url params:nil httpMethod:@"POST" block:^(id result) {
       [self getCodeFinsh:result];
     
   } requestHeader:mdic];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];

    
}

-(void)timerFireMethod:(NSTimer *)theTimer {
    if (seconds == 1) {
        [theTimer invalidate];
        seconds = 90;
        [_getCodeButton setTitle:@"重试" forState: UIControlStateNormal];
        [_getCodeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_getCodeButton setEnabled:YES];
    }else{
        seconds--;
        NSString *title = [NSString stringWithFormat:@"%ld",(long)seconds];
        [_getCodeButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_getCodeButton setEnabled:NO];
        self.codeTimeLabel.text = title;
        [_getCodeButton setTitle:@"秒后重试" forState:UIControlStateNormal];
    }
}

- (void)releaseTImer {
    if (_timer) {
        if ([_timer respondsToSelector:@selector(isValid)]) {
            if ([_timer isValid]) {
                [_timer invalidate];
                seconds = 90;
            }
        }
    }
}
- (void)getCodeFinsh:(id)result{
    
    NSInteger code = [[result objectForKey:@"code"] integerValue];
    NSString *msg = [result objectForKey:@"msg"];
    if (code == 0000) {
        UIAlertView *altview = [[UIAlertView alloc]initWithTitle:@"已发送到你手机"
                                                         message:msg
                                                        delegate:self
                                               cancelButtonTitle:@"确定"
                                               otherButtonTitles:nil, nil];
        [altview show];
        
        
    }else if(code == 2000){
        UIAlertView *altview = [[UIAlertView alloc]initWithTitle:nil
                                                         message:msg
                                                        delegate:self
                                               cancelButtonTitle:@"确定"
                                               otherButtonTitles:nil, nil];
        [altview show];
    }
}

#pragma mark 修改密码
- (IBAction)changPWAction:(id)sender {
    /*
     url:/app/free/findloginpass/byphone.json
     请求参数：phone 手机号，phonecode 手机验证码
     返回结果：成功或失败
     */
    if ([self.phoneNumText.text integerValue]==0) {
        UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"请输入手机号" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        return;
    }else if([self.codeText.text integerValue]==0){
        UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"请输入验证码" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        return;
    }
    NSString *phone = self.phoneNumText.text;
    NSString *code = self.codeText.text;
    
    NSString *URL = [NSString stringWithFormat:@"http://app.huitouzi.com/htzApp/app/free/findloginpass/byphone.json?phone=%@&phonecode=%@",phone,code];
    [WXDataService requestWithURL:URL params:nil httpMethod:@"POST" block:^(id result) {
       
        [self changFinsh:result];
    } requestHeader:nil];
    
}

- (void)changFinsh:(id)result{
    
    NSString *msg = [result objectForKey:@"msg"];
    
    
    NSInteger code = [[result objectForKey:@"code"] integerValue];
    if (code == 0000) {
        
        [self releaseTImer];
        SetPasswordViewController *setPWVC = [[SetPasswordViewController alloc]init];
        setPWVC.phone = self.phoneNumText.text;
        [self presentViewController:setPWVC animated:YES completion:nil];
       
        
        
    }else if (code == 2000){
        
        UIAlertView *altview = [[UIAlertView alloc]initWithTitle:@"认证失败"
                                                         message:msg
                                                        delegate:self
                                               cancelButtonTitle:@"重试"
                                               otherButtonTitles:nil, nil];
        [altview show];
     
    
    }

}
- (void)back{

    [self dismissViewControllerAnimated:YES completion:nil];


}

@end
