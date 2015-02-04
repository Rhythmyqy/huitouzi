//
//  ChangePWViewController.m
//  汇投资
//
//  Created by 杨青源 on 14/11/4.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//
#define ios6  ([[UIDevice currentDevice].systemVersion floatValue]==6)


#import "ChangePWViewController.h"
#import "AppDelegate.h"
#import "WXDataService.h"
#import "LoginViewController.h"
#import "PasswordJuge.h"

@interface ChangePWViewController (){
    UIAlertView *alterview1;
    UIAlertView *alterview2;
    UIAlertView *alterview3;
    UIAlertView *alterview4;
    UIAlertView *alterview5;
    UIAlertView *alterview6;
    UIAlertView *alterview7;
    UIAlertView *alterview8;
    UIAlertView *alterview9;
}
@property(nonatomic,copy)NSString *oldpw;
@property(nonatomic,copy)NSString *newpw;
@property(nonatomic,copy)NSString *conPW;

@end

@implementation ChangePWViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameTitle.text = @"修改密码";
    if (ios6) {
        self.myBGView.frame = CGRectMake(0, 73, 320, 132);
        self.messageLabel.frame = CGRectMake(20, 220, 280, 21);
        self.weakPassword.frame = CGRectMake(14, 251, 98, 12);
        self.normelPassword.frame = CGRectMake(113, 251, 98, 12);
        self.strongPassword.frame = CGRectMake(212, 251, 98, 12);
        self.confirmButton.frame = CGRectMake(17, 279, 290, 45);
        
        
    }
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(myvalueChange) name:@"UITextFieldTextDidChangeNotification" object:self.setNewPWText];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(myvalueChange1) name:@"UITextFieldTextDidChangeNotification" object:self.oldPassWordText];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(myvalueChange2) name:@"UITextFieldTextDidChangeNotification" object:self.confirmPassWordText];

}
-(void)myvalueChange{
  _newpw =  [PasswordJuge judgePasswordStrength:self.setNewPWText.text];
    if ([_newpw isEqualToString:@"弱"]) {
        [self.weakPassword setBackgroundColor:[UIColor redColor]];
        [self.normelPassword setBackgroundColor:[UIColor lightGrayColor]];
        [self.strongPassword setBackgroundColor:[UIColor lightGrayColor]];
    }else if([_newpw isEqualToString:@"中"]){
        [self.weakPassword setBackgroundColor:[UIColor redColor]];
        [self.normelPassword setBackgroundColor:[UIColor orangeColor]];
        [self.strongPassword setBackgroundColor:[UIColor lightGrayColor]];
    }else if ([_newpw isEqualToString:@"强"]){
        [self.weakPassword setBackgroundColor:[UIColor redColor]];
        [self.normelPassword setBackgroundColor:[UIColor orangeColor]];
        [self.strongPassword setBackgroundColor:[UIColor greenColor]];
    }
   

}

- (void)myvalueChange1{
    _oldpw =  [PasswordJuge judgePasswordStrength:self.oldPassWordText.text];
    if ([_oldpw isEqualToString:@"弱"]) {
        [self.weakPassword setBackgroundColor:[UIColor redColor]];
        [self.normelPassword setBackgroundColor:[UIColor lightGrayColor]];
        [self.strongPassword setBackgroundColor:[UIColor lightGrayColor]];
    }else if([_oldpw isEqualToString:@"中"]){
        [self.weakPassword setBackgroundColor:[UIColor redColor]];
        [self.normelPassword setBackgroundColor:[UIColor orangeColor]];
        [self.strongPassword setBackgroundColor:[UIColor lightGrayColor]];
    }else if ([_oldpw isEqualToString:@"强"]){
        [self.weakPassword setBackgroundColor:[UIColor redColor]];
        [self.normelPassword setBackgroundColor:[UIColor orangeColor]];
        [self.strongPassword setBackgroundColor:[UIColor greenColor]];
    }




}
- (void)myvalueChange2{

    _conPW =  [PasswordJuge judgePasswordStrength:self.confirmPassWordText.text];
    if ([_conPW isEqualToString:@"弱"]) {
        [self.weakPassword setBackgroundColor:[UIColor redColor]];
        [self.normelPassword setBackgroundColor:[UIColor lightGrayColor]];
        [self.strongPassword setBackgroundColor:[UIColor lightGrayColor]];
    }else if([_conPW isEqualToString:@"中"]){
        [self.weakPassword setBackgroundColor:[UIColor redColor]];
        [self.normelPassword setBackgroundColor:[UIColor orangeColor]];
        [self.strongPassword setBackgroundColor:[UIColor lightGrayColor]];
    }else if ([_conPW isEqualToString:@"强"]){
        [self.weakPassword setBackgroundColor:[UIColor redColor]];
        [self.normelPassword setBackgroundColor:[UIColor orangeColor]];
        [self.strongPassword setBackgroundColor:[UIColor greenColor]];
    }


}



//原密码
- (void)changevlue
{
//    if (_oldPassWordText.text.length <8&&_oldPassWordText.text.length !=0) {
//        alterview1 = [[UIAlertView alloc]initWithTitle:@"原密码8-16字符" message:@"请重新输入" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        [alterview1 show];
//    }else if(_oldPassWordText.text.length >16){
//        alterview2 = [[UIAlertView alloc]initWithTitle:@"原密码8-16字符" message:@"请重新输入" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        [alterview2 show];
//    }else if (_oldPassWordText.text.length == 0){
//        
//    }
}
//新密码
- (void)changevlue2
{
//    if (_setNewPWText.text.length <8&&_setNewPWText.text.length !=0) {
//        alterview3 = [[UIAlertView alloc]initWithTitle:@"新密码8-16字符" message:@"请重新输入" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        [alterview3 show];
//    }else if(_setNewPWText.text.length >16){
//        alterview4 = [[UIAlertView alloc]initWithTitle:@"新密码8-16字符" message:@"请重新输入" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        [alterview4 show];
//    }else if (_setNewPWText.text.length == 0){
//        
//    }
}

//新密码
- (void)changevlue3
{
//    if (_confirmPassWordText.text.length <8&&_confirmPassWordText.text.length !=0) {
//        alterview5 = [[UIAlertView alloc]initWithTitle:@"确认密码8-16字符" message:@"请重新输入" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        [alterview5 show];
//    }else if(_confirmPassWordText.text.length >16){
//        alterview6 = [[UIAlertView alloc]initWithTitle:@"确认密码8-16字符" message:@"请重新输入" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        [alterview6 show];
//    }else if (_confirmPassWordText.text.length == 0){
//        
//    }
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

#pragma -mark 修改登录密码
- (void)_loadData{
   //http://app.huitouzi.com/htzApp/app/htz/updateloginpassword.json?currentpassword=12444&password=123456
    

    
    NSString *currentpassword = self.oldPassWordText.text;
    NSString *passWord = self.setNewPWText.text;
    NSString *confirmPassword = self.confirmPassWordText.text;
    
    NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"Cookie"];
    
    NSDictionary *dic1 = [[NSMutableDictionary alloc]init];
    
    [dic1 setValue:str forKey:@"Cookie"];
    NSString *url =[NSString stringWithFormat:@"http://app.huitouzi.com/htzApp/app/htz/updateloginpassword.json?&currentpassword=%@&password=%@",currentpassword,passWord];
    
    if ([passWord isEqualToString:confirmPassword]&&self.passWordType == 1) {
        [WXDataService requestWithURL:url params:nil httpMethod:@"POST" block:^(id result) {
            [self _loadDataFinsh:result];
        } requestHeader:dic1];
        
    }else if([passWord isEqualToString:confirmPassword]&&self.passWordType == 0){
        NSString *url1 =[NSString stringWithFormat:@"http://app.huitouzi.com/htzApp/app/htz/updatepaypass.json?&currentpassword=%@&password=%@",currentpassword,passWord];
        [WXDataService requestWithURL:url1 params:nil httpMethod:@"POST" block:^(id result) {
            [self changPayPW:result];
        } requestHeader:dic1];
        
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
        UIAlertView *altview = [[UIAlertView alloc]initWithTitle:msg message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [altview show];
        [altview dismissWithClickedButtonIndex:0 animated:YES];
    
    }else if([code integerValue] == 2001){
    
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"userInfor"];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"Cookie"];
        UIAlertView *altview = [[UIAlertView alloc]initWithTitle:msg message:@"请重新登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        altview.delegate = self;
        [altview show];
        
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:loginVC animated:YES];
        
        
    
    }
    
    
    
    
}

#pragma -mark 修改支付密码
- (void)changPayPW:(id)result{
   /*
    url: /app/htz/updatepaypass.json
    请求参数： currentpassword：当前密码, password：设置密码，user_id:用户id
    支付密码设置时，当前密码currentpassword为空，password必填
    修改支付密码时，当前密码currentpassword必须是用户的密码，password必填
    
    返回数据：成功，失败
    */
    NSString *code = [result objectForKey:@"code"];
    NSString *msg = [result objectForKey:@"msg"];
    if ([code integerValue]== 0000) {
        UIAlertView *alterView = [[UIAlertView alloc]initWithTitle:msg message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alterView show];
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else {
        UIAlertView *alterView = [[UIAlertView alloc]initWithTitle:msg message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alterView show];
    }
    
    
  
    
    

    
    
}


- (IBAction)confirmChangeAction:(id)sender {
    
    if(![self isValidate]){
        return;
    }

    if (self.passWordType == 1) {
        [self _loadData];
    }else if (self.passWordType == 0){

        [self _loadData];
    }
    
}

-(BOOL)isValidate{
    NSString *oldPwd = _oldPassWordText.text;
    NSString *newPwd = _setNewPWText.text;
    NSString *confirmPwd = _confirmPassWordText.text;
    if([self isEmpty:oldPwd]){
        [self showAlert:@"原密码不能为空"];
        return NO;
    }else if([self isEmpty:newPwd]){
        [self showAlert:@"新密码不能为空"];
        return NO;
    }else if([self isEmpty:confirmPwd]){
        [self showAlert:@"确认密码不能为空"];
        return NO;
    }else if(![_setNewPWText.text isEqualToString:_confirmPassWordText.text]){
        [self showAlert:@"确认密码与新密码不同"];
        _confirmPassWordText.text = nil;
        return NO;
    }else if(![self isInRange:oldPwd]){
        [self showAlert:@"原密码为8-16字符"];
        return NO;
    }else if(![self isInRange:newPwd]){
        [self showAlert:@"新密码为8-16字符"];
        return NO;
    }
    return YES;
}
-(void)showAlert:(NSString*)msg{
    UIAlertView *alterview = [[UIAlertView alloc]initWithTitle:msg message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alterview show];
}
-(BOOL)isEmpty:(NSString*)str{
    if(str==nil||str.length==0){
        return YES;
    }
    return NO;
}
-(BOOL)isInRange:(NSString*)pwd{
    if(pwd.length<8||pwd.length>16){
        return NO;
    }
    return YES;
}
//键盘代理方法
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.oldPassWordText resignFirstResponder];
    [self.setNewPWText resignFirstResponder];
    [self.confirmPassWordText resignFirstResponder];
}
- (IBAction)showOldPWAction:(id)sender {
    if (self.oldPassWordText.secureTextEntry == YES) {
        [self.oldPwButton setImage:[UIImage imageNamed:@"眼睛标图标选中.png"] forState: UIControlStateNormal];
        self.oldPassWordText.secureTextEntry = NO;
    }else if (self.oldPassWordText.secureTextEntry == NO){
        [self.oldPwButton setImage:[UIImage imageNamed:@"眼睛图标没选.png"] forState: UIControlStateNormal];
        self.oldPassWordText.secureTextEntry = YES;
        
        
    }
    
}

- (IBAction)showSetPWAction:(id)sender {
    if (self.setNewPWText.secureTextEntry == YES) {
        [self.setNewButton setImage:[UIImage imageNamed:@"眼睛标图标选中.png"] forState: UIControlStateNormal];
        self.setNewPWText.secureTextEntry = NO;
    }else if (self.setNewPWText.secureTextEntry == NO){
        [self.setNewButton setImage:[UIImage imageNamed:@"眼睛图标没选.png"] forState: UIControlStateNormal];
        self.setNewPWText.secureTextEntry = YES;
        
        
    }
    
    
}

- (IBAction)showConfirmPWAction:(id)sender {
    if (self.confirmPassWordText.secureTextEntry == YES) {
        [self.confirmPWButton setImage:[UIImage imageNamed:@"眼睛标图标选中.png"] forState: UIControlStateNormal];
        self.confirmPassWordText.secureTextEntry = NO;
    }else if (self.confirmPassWordText.secureTextEntry == NO){
        [self.confirmPWButton setImage:[UIImage imageNamed:@"眼睛图标没选.png"] forState: UIControlStateNormal];
        self.confirmPassWordText.secureTextEntry = YES;
        
        
    }
    
    
    
}
@end
