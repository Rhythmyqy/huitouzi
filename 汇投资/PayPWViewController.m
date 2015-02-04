//
//  PayPWViewController.m
//  汇投资
//
//  Created by wcf on 14/11/25.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import "PayPWViewController.h"
#import "AppDelegate.h"
#import "WXDataService.h"
#import "LoginViewController.h"
#import "PasswordJuge.h"
#define ios6  ([[UIDevice currentDevice].systemVersion floatValue]==6)


@interface PayPWViewController (){
    UIAlertView *alterview1;
    UIAlertView *alterview2;
    UIAlertView *alterview3;
    UIAlertView *alterview4;
    UIAlertView *alterview5;
    UIAlertView *alterview6;
}

@end

@implementation PayPWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nameTitle.text = @"修改密码";
    
    if (ios6) {
        self.myview.frame = CGRectMake(0, 73, 320, 132);
        self.messageLabel.frame = CGRectMake(20, 220, 280, 21);
        self.weakPassword.frame = CGRectMake(14, 251, 98, 12);
        self.normelPassword.frame = CGRectMake(113, 251, 98, 12);
        self.strongPassword.frame = CGRectMake(212, 271, 98, 12);
        self.confirmButton.frame = CGRectMake(17, 279, 290, 45);
        
    }
    
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(valueChange) name:@"UITextFieldTextDidChangeNotification" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changevlue) name:@"UITextFieldTextDidEndEditingNotification" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changevlue2) name:@"UITextFieldTextDidEndEditingNotification" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changevlue3) name:@"UITextFieldTextDidEndEditingNotification" object:nil];
}

-(void)valueChange{
    NSString *newPW =[PasswordJuge judgePasswordStrength:self.setNewPWText.text];
    if ([newPW isEqualToString:@"弱"]) {
        [self.weakPassword setBackgroundColor:[UIColor redColor]];
        [self.normelPassword setBackgroundColor:[UIColor lightGrayColor]];
        [self.strongPassword setBackgroundColor:[UIColor lightGrayColor]];
    }else if([newPW isEqualToString:@"中"]){
        [self.normelPassword setBackgroundColor:[UIColor orangeColor]];
        [self.strongPassword setBackgroundColor:[UIColor lightGrayColor]];
    }else if ([newPW isEqualToString:@"强"]){
        [self.strongPassword setBackgroundColor:[UIColor greenColor]];
    }
}
//原密码
- (void)changevlue
{
    if (_oldPassWordText.text.length <8&&_oldPassWordText.text.length !=0) {
        alterview1 = [[UIAlertView alloc]initWithTitle:@"原密码8-16字符" message:@"请重新输入" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alterview1 show];
    }else if(_oldPassWordText.text.length >16){
        alterview2 = [[UIAlertView alloc]initWithTitle:@"原密码8-16字符" message:@"请重新输入" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alterview2 show];
    }else if (_oldPassWordText.text.length == 0){
        
    }
}
//新密码
- (void)changevlue2
{
    if (_setNewPWText.text.length <8&&_setNewPWText.text.length !=0) {
        alterview3 = [[UIAlertView alloc]initWithTitle:@"新密码8-16字符" message:@"请重新输入" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alterview3 show];
    }else if(_setNewPWText.text.length >16){
        alterview4 = [[UIAlertView alloc]initWithTitle:@"新密码8-16字符" message:@"请重新输入" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alterview4 show];
    }else if (_setNewPWText.text.length == 0){
        
    }
}
//确认密码
- (void)changevlue3
{
    if (_confirmPassWordText.text.length <8&&_confirmPassWordText.text.length !=0) {
        alterview5 = [[UIAlertView alloc]initWithTitle:@"确认密码8-16字符" message:@"请重新输入" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alterview5 show];
    }else if(_confirmPassWordText.text.length >16){
        alterview6 = [[UIAlertView alloc]initWithTitle:@"确认密码8-16字符" message:@"请重新输入" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alterview6 show];
    }else if (_confirmPassWordText.text.length == 0){
        
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView==alterview1||alertView == alterview2) {
        if (buttonIndex==1) {
            _oldPassWordText.text=nil;
        }
    }
    else if(alertView == alterview3 || alertView == alterview4) {
        if (buttonIndex == 1) {
            _setNewPWText.text = nil;
        }
    }
    else if(alertView == alterview5 || alertView == alterview6) {
        if (buttonIndex == 1) {
            _confirmPassWordText.text = nil;
        }
    }
    
}

-(void)back{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma -mark 修改支付密码
- (void)_loadData{
    //http://app.huitouzi.com/htzApp/app/htz/updatepaypass.json?currentpassword=12444&password=123456
    
  
    
    NSString *currentpassword = self.oldPassWordText.text;
    NSString *passWord = self.setNewPWText.text;
    NSString *confirmPassword = self.confirmPassWordText.text;
    
    NSString *url =[NSString stringWithFormat:@"http://app.huitouzi.com/htzApp/app/htz/updateloginpassword.json?&currentpassword=%@&password=%@",currentpassword,passWord];
    
    if ([passWord isEqualToString:confirmPassword]&&self.passWordType == 1) {
        [WXDataService requestWithURL:url params:nil httpMethod:@"POST" block:^(id result) {
            [self _loadDataFinsh:result];
         
        } requestHeader:nil];
        
    }else if([passWord isEqualToString:confirmPassword]&&self.passWordType == 0){
        [WXDataService requestWithURL:@"http://app.huitouzi.com/htzApp/app/htz/updatepaypass.json?" params:nil httpMethod:@"POST" block:^(id result) {
            [self _loadDataFinsh:result];
        } requestHeader:nil];
        
    }else {
        
        UIAlertView *altview = [[UIAlertView alloc]initWithTitle:@"密码输入错误" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [altview show];
        [altview dismissWithClickedButtonIndex:0 animated:YES];
    }
}
- (void)_loadDataFinsh:(id)result{
    NSString *code = [result objectForKey:@"code"];
    NSString *msg = [result objectForKey:@"msg"];
    if ([code intValue] == 0000 && self.passWordType == 1) {
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"userInfor"];
        UIAlertView *altview = [[UIAlertView alloc]initWithTitle:msg message:@"请重新登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        altview.delegate = self;
        [altview show];
        
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:loginVC animated:YES];
        
    }else if([code intValue] == 0000 && self.passWordType == 0){
        UIAlertView *altview = [[UIAlertView alloc]initWithTitle:@"修改成功" message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        altview.delegate = self;
        [altview show];
    }else if([code intValue] == 2000){
        UIAlertView *altview = [[UIAlertView alloc]initWithTitle:msg message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [altview show];
        [altview dismissWithClickedButtonIndex:0 animated:YES];
    }
}
#pragma -mark 修改支付密码
- (void)changPayPW{
    /*
     url: /app/htz/updatepaypass.json
     请求参数： currentpassword：当前密码, password：设置密码，user_id:用户id
     支付密码设置时，当前密码currentpassword为空，password必填
     修改支付密码时，当前密码currentpassword必须是用户的密码，password必填
     
     返回数据：成功，失败
     */
}

//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    
//    if (buttonIndex == 0) {
//        LoginViewController *loginVC = [[LoginViewController alloc]init];
//        [self.navigationController pushViewController:loginVC animated:YES];
//    }
//}

- (IBAction)confirmChangeAction:(id)sender {
    //判断两次设置的密码是否相同
    if(![_setNewPWText.text isEqualToString:_confirmPassWordText.text]){
        UIAlertView *alterview = [[UIAlertView alloc]initWithTitle:@"两次重置密码不相同" message:@"请重置密码" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alterview show];
        _confirmPassWordText.text = nil;
        return ;
    }
    if (self.passWordType == 1) {
        [self _loadData];
    }else{
        [self changPayPW];
    }
    
}
//键盘代理方法
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.oldPassWordText resignFirstResponder];
    [self.setNewPWText resignFirstResponder];
    [self.confirmPassWordText resignFirstResponder];
}
@end
