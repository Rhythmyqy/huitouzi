//
//  AuthViewController.m
//  汇投资
//
//  Created by 杨青源 on 14/12/29.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import "AuthViewController.h"
#import "NetService.h"
#import <ShareSDK/ShareSDK.h>

@interface AuthViewController (){
 NSInteger seconds;
}

@end

@implementation AuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameTitle.text = @"注册";
    seconds =90;
   
}







- (IBAction)getCodeButtonAction:(id)sender {
    //free/getPhoneMsgCode.json
    

    
    
    
    if (self.phone.text.length == 0) {
        UIAlertView *alterView = [[UIAlertView alloc]initWithTitle:@"请输入手机号" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alterView show];
        return;
    }
    
    NSMutableDictionary *dic = [[NSMutableDictionary   alloc]init];
    [dic setObject:_phone.text forKey:@"phone"];
    [dic setObject:@"12" forKey:@"innerType"];
    [NetService post:@"free/getPhoneMsgCode.json" parameters:dic success:^(id responseObject) {
        UIAlertView *alterView = [[UIAlertView alloc]initWithTitle:@"已发送到你的手机" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alterView show];
       
        
        
    } failure:^(NSString *error) {
        
    } netError:^(NSString *error) {
        
    }];
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
        self.numLabel.text = title;
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
- (IBAction)rigisAction:(id)sender {
    if (self.passWordTextField.text.length == 0) {
        UIAlertView *alterView = [[UIAlertView alloc]initWithTitle:@"请输入密码" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alterView show];
        return;
    }
    if (self.rePasswordTextField.text.length == 0) {
        UIAlertView *alterView = [[UIAlertView alloc]initWithTitle:@"请再次输入密码" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alterView show];
        return;
    }
    if (self.phone.text.length == 0) {
        UIAlertView *alterView = [[UIAlertView alloc]initWithTitle:@"请输入手机号" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alterView show];
        return;
    }
    if (self.codeNum.text.length == 0) {
        UIAlertView *alterView = [[UIAlertView alloc]initWithTitle:@"请输入验证码" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alterView show];
        return;
    }
    if (self.codeNum.text.length != 6) {
        UIAlertView *alterView = [[UIAlertView alloc]initWithTitle:@"验证码输入错误" message:@"请重新输入" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alterView show];
        return;
    }
    
    
    
    
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:self.uuid forKey:@"uuid"];
    [dic setObject:self.passWordTextField.text forKey:@"password"];
    [dic setObject:self.rePasswordTextField.text forKey:@"repassword"];
    [dic setObject:self.phone.text forKey:@"phone"];
    [dic setObject:self.codeNum.text forKey:@"phoneCheckCode"];
    [dic setObject:self.authType forKey:@"thirdtype"];
   
    [NetService post:@"free/thirdlogin/save_auth_info.json" parameters:dic success:^(id responseObject) {
        UIAlertView *alterView = [[UIAlertView alloc]initWithTitle:@"注册成功" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alterView show];
        [alterView dismissWithClickedButtonIndex:0 animated:YES];
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(NSString *error) {
        [ShareSDK cancelAuthWithType:ShareTypeQQSpace];
        [ShareSDK cancelAuthWithType:ShareTypeSinaWeibo];
    } netError:^(NSString *error) {
        [ShareSDK cancelAuthWithType:ShareTypeQQSpace];
        [ShareSDK cancelAuthWithType:ShareTypeSinaWeibo];
    }];
    
    
    
    
}

- (void)back{
    [ShareSDK cancelAuthWithType:ShareTypeQQSpace];
    [ShareSDK cancelAuthWithType:ShareTypeSinaWeibo];
    [self.navigationController popViewControllerAnimated:YES];



}

@end
