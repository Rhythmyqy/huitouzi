//
//  TXSubmitViewController.m
//  汇投资
//
//  Created by wcf on 14/11/20.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#define KScreenWidth [[UIScreen mainScreen] bounds].size.width
#define KScreenHeight [[UIScreen mainScreen] bounds].size.height

#import "TXSubmitViewController.h"
#import "AppDelegate.h"
#import "BassNavigationViewController.h"
#import "WXDataService.h"

@interface TXSubmitViewController ()

@end

@implementation TXSubmitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameTitle.text=@"提交完成";
    
    [self loadData];
}
- (void)loadData
{
    NSString *userID =[[[NSUserDefaults standardUserDefaults]objectForKey:@"userInfor"] objectForKey:@"user_id"];
    NSString *url = [NSString stringWithFormat:@"http://app.huitouzi.com/htzApp/app/htz/cashapply.json?user_id=%@&cashmoney=%@&cashbankId=%@&paypassword=%@",userID,_cashmoney,_cashbankId,_paypassword];
    
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 60,KScreenWidth,KScreenHeight-75)];
    NSURL *baseUrl = [NSURL URLWithString:url];
    NSURLRequest *requst = [NSURLRequest requestWithURL:baseUrl];
    [_webView loadRequest:requst];
    [self.view addSubview:_webView];
    
}
-(void)back{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
