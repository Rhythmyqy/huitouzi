//
//  LoginViewController.m
//  汇投资
//
//  Created by 杨青源 on 14/11/4.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//


#import "LoginViewController.h"
#import "AppDelegate.h"
#import "RegistrationViewController.h"
#import "User.h"
#import "LeftViewController.h"
#import "WXDataService.h"
#import "ForgetPWViewController.h"
#import "NSDictionary+SafeObjectforKey.h"
#import "Reachability.h"
#import "NetService.h"
#import "MoneyManageViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <QZoneConnection/ISSQZoneApp.h>

#import "AuthViewController.h"
#import "LLLockPassword.h"
#import "LLLockViewController.h"
#import "SafeViewController.h"
#import "MBProgressHUD.h"
@interface LoginViewController ()

@property (strong, nonatomic) LLLockViewController* lockVc; // 添加解锁界面

@end

@implementation LoginViewController{


}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self  = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
   if (self) {

    

       
    }
    
    return self;
}

- (void)endChange{
    [self.UserNameText resignFirstResponder];
    [self.pwTextView resignFirstResponder];


}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameTitle.text = @"登录";
    if (self.isback == 1 || self.isGust ==1|| self.ismyCount == 1) {
        self.left.hidden = YES;
    }
    
    [self.right2 setTitle:@"注册" forState:UIControlStateNormal];
    self.right2.titleLabel.font = [UIFont systemFontOfSize:14];
    self.right2.titleLabel.textColor = [UIColor whiteColor];
    

}
#pragma mark - 收起键盘


-(IBAction)textFieldDoneEditing:(id)sender
{
    [sender resignFirstResponder];
}

- (IBAction)qqLoginAction:(id)sender {
    id<ISSQZoneApp> app =(id<ISSQZoneApp>)[ShareSDK getClientWithType:ShareTypeQQSpace];
    [app setIsAllowWebAuthorize:YES];
    
[ShareSDK getUserInfoWithType:ShareTypeQQSpace authOptions:nil result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
    if (result) {
     [self reloadStateWithType:ShareTypeQQSpace];
        
    }
    
}];


}
- (IBAction)weiboLoginAction:(id)sender {
  
    [ShareSDK getUserInfoWithType:ShareTypeSinaWeibo authOptions:nil result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
        if (result) {
          [self reloadStateWithType:ShareTypeSinaWeibo];
        }
        
        
    }];
    
    
}

-(void)reloadStateWithType:(ShareType)type{
    //现实授权信息，包括授权ID、授权有效期等。
    //此处可以在用户进入应用的时候直接调用，如授权信息不为空且不过期可帮用户自动实现登录。
    NSString *str = [NSString string];
    if (type== ShareTypeSinaWeibo) {
        str = @"1";
    }else if(type== ShareTypeQQSpace){
        
        str =@"2";
    }
    
    id<ISSPlatformCredential> credential = [ShareSDK getCredentialWithType:type];

   
    //http://115.29.138.151:9180/htzApp/app/free/thirdlogin/check.json?thirdtype=1&uuid=12345678
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:[credential uid] forKey:@"uuid"];
    [dic setObject:str forKey:@"thirdtype"];
    [NetService post:@"free/thirdlogin/check.json" parameters:dic success:^(id responseObject) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self authLoginFinsh:responseObject uuid:[credential uid] type:type];
        
        
    } failure:^(NSString *error) {
       [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    } netError:^(NSString *error) {
       [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
    
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    
    
}

- (void)authLoginFinsh:(id)result uuid:(NSString *)uuid type:(ShareType)type{
    NSString *str = [NSString string];
    if (type== ShareTypeSinaWeibo) {
        str = @"1";
    }else if(type== ShareTypeQQSpace){
    
    str =@"2";
    }
    NSString *logintype = [result objectForKey:@"infoComplete"];
    
    if ([logintype isEqualToString:@"false"]) {
        AuthViewController *authVC = [[AuthViewController alloc]init];
        authVC.uuid = uuid;
        authVC.authType = str;
        
        [self.navigationController pushViewController:authVC animated:YES];
        
    }else if([logintype isEqualToString:@"true"]){
        NSDictionary *dic = [result objectForKey:@"userInfo"];
        [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"userInfor"];
//        _userModel = [[UserModel alloc]initWithDataDic:dic];
        UIAlertView *altview = [[UIAlertView alloc]initWithTitle:@"登录成功" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [altview show];
        
        
        

        
        
        
        if (self.isGust == 1 && self.ismyCount == 0 &&self.isOtherVC == 0) {
            [altview dismissWithClickedButtonIndex:0 animated:YES];
            
            self.lockVc = [[LLLockViewController alloc] init];
            self.lockVc.nLockViewType = LLLockViewTypeCreate;
            
            self.lockVc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            [self presentViewController:self.lockVc animated:YES completion:nil];
            
            
            
            
            
            
            
            
            
            
            
        }else if (self.isGust == 0 && self.ismyCount == 1 &&self.isOtherVC == 0){
            [altview dismissWithClickedButtonIndex:0 animated:YES];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"mycount" object:nil];
            
        }else if(self.isOtherVC == 1){
         [altview dismissWithClickedButtonIndex:0 animated:YES];
            [self dismissViewControllerAnimated:YES completion:nil];
        
        }else{
            
            AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
            [appDelegate.mmViewCtrl openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
            
            [appDelegate.mmViewCtrl openDrawerSide:MMDrawerSideLeft animated:YES completion:^(BOOL finished) {
                
            }];
            MoneyManageViewController *moneyMY = [[MoneyManageViewController alloc]init];
            [self.navigationController pushViewController:moneyMY animated:YES];
            [altview dismissWithClickedButtonIndex:0 animated:YES];
        }
    }
    


}


//键盘代理方法
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.UserNameText resignFirstResponder];
    [self.pwTextView resignFirstResponder];
}


- (void)RegistrationAction{
   
    RegistrationViewController *regisVC = [[RegistrationViewController alloc]init];
    [self presentViewController:regisVC animated:YES completion:nil];
}


#pragma -mark 登录方法

- (IBAction)loginAction:(id)sender {
    
    if (self.UserNameText.text.length == 0) {
        UIAlertView *alterview = [[UIAlertView alloc]initWithTitle:@"请输入用户名" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alterview show];
        return;
    }
    if (self.pwTextView.text.length == 0) {
        UIAlertView *alterview = [[UIAlertView alloc]initWithTitle:@"请输入密码" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alterview show];
        return;
    }
   
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [self.UserNameText resignFirstResponder];
    [self.pwTextView resignFirstResponder];
    

    
  
    Reachability *r = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
            // 没有网络连接
        {
           
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"没有网络连接"
                                                               message:nil
                                                              delegate:self
                                                     cancelButtonTitle:@"确定"
                                                     otherButtonTitles:nil];
            
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [alertView show];
        }
            break;
        case ReachableViaWWAN:{
            // 使用3G网络
            [self _loadData];
        }
            break;
        case ReachableViaWiFi:{
             // 使用WiFi网络
            [self _loadData];
        }
            break;
    }
}

- (void)_loadData{
    NSString *userName = _UserNameText.text;
    NSString *pw = _pwTextView.text;


    
    
    
    

    
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:userName forKey:@"account"];
    [dic setObject:pw forKey:@"password"];
    [NetService post:@"free/login.json" parameters:dic success:^(id responseObject) {
        [self loginFinsh:responseObject];
    } failure:^(NSString *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    } netError:^(NSString *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
    
    
}
- (void)loginFinsh:(id)result
{

         
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    
        NSMutableDictionary *dic = result;
        if ([[dic objectForKey:@"name"] isKindOfClass:[NSNull class]]) {
            [dic setObject:@"123456" forKey:@"name"];
            
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"userInfor"];
        _userModel = [[UserModel alloc]initWithDataDic:dic];
        UIAlertView *altview = [[UIAlertView alloc]initWithTitle:@"登录成功" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [altview show];
    
    if (self.isGust == 1 && self.ismyCount == 0 &&self.isOtherVC == 0) {
        [altview dismissWithClickedButtonIndex:0 animated:YES];
       
        self.lockVc = [[LLLockViewController alloc] init];
        self.lockVc.nLockViewType = LLLockViewTypeCreate;
       
        self.lockVc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:self.lockVc animated:YES completion:nil];
       
        

      
        
        
    
       
       
       
        
    }else if (self.isGust == 0 && self.ismyCount == 1 &&self.isOtherVC == 0){
         [altview dismissWithClickedButtonIndex:0 animated:YES];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"mycount" object:nil];
    
    }else if(self.isOtherVC == 1){
         [altview dismissWithClickedButtonIndex:0 animated:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
    
    }else{
    
        AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        [appDelegate.mmViewCtrl openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
        
        [appDelegate.mmViewCtrl openDrawerSide:MMDrawerSideLeft animated:YES completion:^(BOOL finished) {
            
        }];
        MoneyManageViewController *moneyMY = [[MoneyManageViewController alloc]init];
        [self.navigationController pushViewController:moneyMY animated:YES];
        [altview dismissWithClickedButtonIndex:0 animated:YES];
    }
    

}
#pragma mark - 键盘代理方法
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{

    if (textField == _pwTextView) {
        self.pwTextView.secureTextEntry = YES;
    }else{
    
    }
    return YES;
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];
    self.UserNameText.text = nil;
    self.pwTextView.text = nil;
    

}



- (IBAction)forgetPWAction:(id)sender{
    
    ForgetPWViewController *forgetPWVC = [[ForgetPWViewController alloc]init];
//    [self.navigationController pushViewController:forgetPWVC animated:YES];
    [self presentViewController:forgetPWVC animated:YES completion:nil];
   
}

- (void)back{
    [self.UserNameText resignFirstResponder];
    [self.pwTextView resignFirstResponder];
    if (self.isback == 1) {
        return;
    }
    if (self.isGust == 1 || self.ismyCount == 1 || self.isOtherVC ==1 ) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
   
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
 [appDelegate.mmViewCtrl toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
  
    }
    

}
@end
