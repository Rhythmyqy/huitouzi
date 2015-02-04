//
//  SetPasswordViewController.m
//  汇投资
//
//  Created by 杨青源 on 14/11/18.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import "SetPasswordViewController.h"
#import "AppDelegate.h"
#import "LeftViewController.h"
#import "WXDataService.h"
#import "LoginViewController.h"
#import "PasswordJuge.h"

@interface SetPasswordViewController (){
    UIAlertView *alterview1;
    UIAlertView *alterview2;
    UIAlertView *alterview3;
    UIAlertView *alterview4;
    UIAlertView *alterview5;
    UIAlertView *alerView6;
}
@end

@implementation SetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameTitle.text =@"重置登录密码";
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changevlue) name:@"UITextFieldTextDidEndEditingNotification" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(valueChange) name:@"UITextFieldTextDidChangeNotification" object:nil];
}
//密码
- (void)changevlue
{
    if (_passWordText.text.length <8&&_passWordText.text.length !=0) {
        alterview1 = [[UIAlertView alloc]initWithTitle:@"密码为8-16个字符" message:@"请重新输入" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alterview1 show];
    }else if(_passWordText.text.length >16){
        alterview2 = [[UIAlertView alloc]initWithTitle:@"密码为8-16个字符" message:@"请重新输入" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alterview2 show];
    }else if (_passWordText.text.length == 0){
        
    }
}

//http://app.huitouzi.com/htzApp/app/free/updateloginpassword.json?phone=15733332268&password=343432&comfirmpassword=123445
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView==alterview1||alertView == alterview2) {
        if (buttonIndex==1) {
            _passWordText.text=nil;
        }
    }
    else if(alertView==alterview5){
        if(buttonIndex==1){
         _confirmPWText.text = nil;
        }
    }else if(alertView == alerView6 && buttonIndex == 0){
        
       
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }
}
-(void)valueChange{
    NSString *newPW =  [PasswordJuge judgePasswordStrength:self.passWordText.text];
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

#pragma mark - back
-(void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//键盘代理方法
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.passWordText resignFirstResponder];
    [self.confirmPWText resignFirstResponder];
}

- (void)_loadData{
    NSString *url = [NSString stringWithFormat:@"http://app.huitouzi.com/htzApp/app/free/updateloginpassword.json?phone=%@&password=%@&comfirmpassword=%@",self.phone,self.passWordText.text,self.confirmPWText.text];
    [WXDataService requestWithURL:url params:nil httpMethod:@"POST" block:^(id result) {
        [self loadFinsh:result];
    } requestHeader:nil];
}

- (void)loadFinsh:(id)result{
    NSString *msg = [result objectForKey:@"msg"];
    NSString *code = [result objectForKey:@"code"];
    if ([code integerValue] == 0000) {
        alerView6 = [[UIAlertView alloc]initWithTitle:@"修改成功" message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        
        [alerView6 show];
        [alerView6 dismissWithClickedButtonIndex:0 animated:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"dismiss" object:nil];
        
    }else{
    
        UIAlertView *alterView = [[UIAlertView alloc]initWithTitle:msg message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alterView show];
        return;
    
    }
}


- (IBAction)setAction:(id)sender {
    
    
    if (_passWordText.text.length==0) {
        UIAlertView *alterView = [[UIAlertView alloc]initWithTitle:@"请输入密码" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alterView show];
        return;
    }
    if (_confirmPWText.text.length==0) {
        UIAlertView *alterView = [[UIAlertView alloc]initWithTitle:@"请再次输入密码" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alterView show];
        return;
    }
    
    
    if(![_passWordText.text isEqualToString:_confirmPWText.text]){
        alterview5= [[UIAlertView alloc]initWithTitle:@"两次输入密码不相同" message:@"请重新输入" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alterview5 show];
        return;
    }
  
    [self _loadData];
  
}




@end
