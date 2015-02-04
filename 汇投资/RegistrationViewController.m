//
//  RegistrationViewController.m
//  汇投资
//
//  Created by 杨青源 on 14/11/7.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import "RegistrationViewController.h"
#import "AppDelegate.h"
#import "WXDataService.h"
#import "NetService.h"

@interface RegistrationViewController (){
    UIAlertView *alterview1;
    UIAlertView *alterview2;
    UIAlertView *alterview3;
    UIAlertView *alterview4;
    UIAlertView *alterview5;
    UIAlertView *alterview6;
    UIAlertView *alterview7;
    UIAlertView *alterview8;
    UIAlertView *alterview9;
    NSInteger seconds;
}
@end

@implementation RegistrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textField.delegate=self;
    self.nameTitle.text = @"注册";
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changevlue) name:@"UITextFieldTextDidEndEditingNotification" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changevlue2) name:@"UITextFieldTextDidEndEditingNotification" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changevlue3) name:@"UITextFieldTextDidEndEditingNotification" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changevlue4) name:@"UITextFieldTextDidEndEditingNotification" object:nil];
    seconds =90;
}

//用户名
- (void)changevlue{
    if (_userNameText.text.length <4&&_userNameText.text.length !=0) {
        alterview1 = [[UIAlertView alloc]initWithTitle:@"用户名4-18个字符" message:@"请重新输入" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alterview1 show];
    }
    else if(_userNameText.text.length >18){
        alterview2 = [[UIAlertView alloc]initWithTitle:@"用户名4-18个字符" message:@"请重新输入" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alterview2 show];
    }
    else if (_userNameText.text.length == 0){
        
    }
    else if ([_userNameText.text checkConsecutiveIncrementalNumber:7]){
       
        alterview3 = [[UIAlertView alloc]initWithTitle:@"不能出现连续7位数字" message:@"请重新输入" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alterview3 show];
    }
}
//密码
- (void)changevlue2
{
    if (_passWordText.text.length <8&&_passWordText.text.length !=0) {
        alterview4 = [[UIAlertView alloc]initWithTitle:@"密码8-16字符" message:@"请重新输入" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alterview4 show];
    }else if(_passWordText.text.length >16){
        alterview5 = [[UIAlertView alloc]initWithTitle:@"密码太长" message:@"请重新输入" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alterview5 show];
    }else if (_passWordText.text.length == 0){
        
    }
}
//手机号
- (void)changevlue3
{
    if (_phoneNumText.text.length <11&&_phoneNumText.text.length !=0) {
        alterview6 = [[UIAlertView alloc]initWithTitle:@"手机号为11位" message:@"请重新输入" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alterview6 show];
    }else if(_phoneNumText.text.length >11){
        alterview7 = [[UIAlertView alloc]initWithTitle:@"手机号为11位" message:@"请重新输入" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alterview7 show];
    }else if (_phoneNumText.text.length == 0){
        
    }
    
}
//验证码
- (void)changevlue4
{
    if (_idenCodeText.text.length <6&&_idenCodeText.text.length !=0) {
        alterview8 = [[UIAlertView alloc]initWithTitle:@"验证码为6位" message:@"请重新输入" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alterview8 show];
    }else if(_idenCodeText.text.length >6){
        alterview9 = [[UIAlertView alloc]initWithTitle:@"验证码位6位" message:@"请重新输入" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alterview9 show];
    }else if (_idenCodeText.text.length == 0){
        
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView==alterview1||alertView == alterview2||alertView==alterview3) {
        if (buttonIndex==1) {
            _userNameText.text=nil;
        }
    }
    else if(alertView == alterview4 || alertView == alterview5) {
        if (buttonIndex == 1) {
            _passWordText.text = nil;
        }
    }
    else if(alertView == alterview6 || alertView == alterview7) {
        if (buttonIndex == 1) {
            _phoneNumText.text = nil;
        }
    }
    else if(alertView == alterview8 || alertView == alterview9) {
        if (buttonIndex == 1) {
            _idenCodeText.text = nil;
        }
    }
}
//键盘代理方法
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.userNameText resignFirstResponder];
    [self.passWordText resignFirstResponder];
    [self.phoneNumText resignFirstResponder];
    [self.idenCodeText resignFirstResponder];
}
-(void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark 注册方法

- (IBAction)registrationAction:(id)sender {
    //判断用户名和密码是否相同
    if (_userNameText.text.length == 0) {
        UIAlertView *alterview = [[UIAlertView alloc]initWithTitle:@"请输入用户名" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alterview show];
        return ;
    }
    if (_passWordText.text.length == 0) {
        UIAlertView *alterview = [[UIAlertView alloc]initWithTitle:@"请输入密码" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alterview show];
        return ;
    }
    if (_phoneNumText.text.length == 0) {
        UIAlertView *alterview = [[UIAlertView alloc]initWithTitle:@"请输入手机号" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alterview show];
        return ;
    }
    if (_idenCodeText.text.length == 0) {
        UIAlertView *alterview = [[UIAlertView alloc]initWithTitle:@"请输入验证码" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alterview show];
        return ;
    }
    
    
    
    if([_userNameText.text isEqualToString:_passWordText.text]){
        UIAlertView *alterview = [[UIAlertView alloc]initWithTitle:@"用户名与密码相同" message:@"请重新输入" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alterview show];
        return ;
    }
   //http://app.huitouzi.com/htzApp/app/free/register.json?username=yangqingyuan123&password=123456&phone=18628115291&phoneCheckCode=584836
    NSString *userName = self.userNameText.text;
    NSString *pW = self.passWordText.text;
    NSString *phone = self.phoneNumText.text;
    NSString *phoneCheckCode = self.idenCodeText.text;
    
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc] initWithCapacity:2];
    
        [parameters setObject:userName forKey:@"username"];
        [parameters setObject:pW forKey:@"password"];
        [parameters setObject:phone forKey:@"phone"];
        [parameters setObject:phoneCheckCode forKey:@"phoneCheckCode"];
    
    
    [NetService post:@"free/register.json" parameters:parameters success:^(id responseObject) {
        [self registrationFinsh:responseObject];
        
    } failure:^(NSString *error) {
        
    } netError:^(NSString *error) {
        
    }];
    

}
//注册成功后回调的方法

- (void)registrationFinsh:(id)result{
    NSString *code = [result objectForKey:@"code"];
    NSString *message = [result objectForKey:@"msg"];
    if ([code intValue] == 2000) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"注册失败" message:message delegate:self cancelButtonTitle:@"重试" otherButtonTitles:nil];
        [alertView show];
        return;
    }
    else if([code intValue] == 0000)
    {

        
        UIAlertView *altview = [[UIAlertView alloc]initWithTitle:@"注册成功" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [altview show];
        ////如果注册成功，停止验证码的倒数，
        [self releaseTImer];
        [self dismissViewControllerAnimated:YES completion:nil];
        [altview dismissWithClickedButtonIndex:0 animated:YES];
    }

}


#pragma mark 获取注册手机验证码
- (IBAction)getIdenCodeAction:(id)sender {
    if ([self.phoneNumText.text integerValue]==0) {
        UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"请输入手机号" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alter show];
        return;
    }
   
    NSString *phoneNUM = self.phoneNumText.text;
    NSString *url =[NSString stringWithFormat:@"http://app.huitouzi.com/htzApp/app/free/getPhoneMsgCode.json?phone=%@&innerType=12",phoneNUM];
   
    [WXDataService requestWithURL:url
                           params:nil
                       httpMethod:@"POST"
                            block:^(id result) {
       
    } requestHeader:nil];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
    
}





-(void)timerFireMethod:(NSTimer *)theTimer {
    if (seconds == 1) {
        [theTimer invalidate];
        seconds = 90;
        _codeTimerlabel.text = @"";
        [_getCodeNumButton setTitle:@"重试" forState: UIControlStateNormal];
        [_getCodeNumButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_getCodeNumButton setEnabled:YES];
    }else{
        seconds--;
        NSString *title = [NSString stringWithFormat:@"%ld",(long)seconds];
        [_getCodeNumButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_getCodeNumButton setEnabled:NO];
        [_getCodeNumButton setTitle:@"秒后重试" forState:UIControlStateNormal];
        
        self.codeTimerlabel.text = title;
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
- (void)GetPhoneCheckCode:(id)result{
    
    NSString *code = [result objectForKey:@"code"];
    
    NSString *message = [result objectForKey:@"msg"];
    
    
    if ([code intValue] == 2000) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"获取验证吗失败" message:message delegate:self cancelButtonTitle:@"重试" otherButtonTitles:nil];
        [alertView show];
        return;
    }
    else
    {
        UIAlertView *altview = [[UIAlertView alloc]initWithTitle:@"已发送验证码到你的手机" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [altview show];
    }

}
#pragma mark 键盘代理方法

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField == _passWordText) {
        self.passWordText.secureTextEntry = YES;
    }else{
        
    }
    return YES;
}
@end
