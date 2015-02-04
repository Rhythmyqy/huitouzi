//
//  LicaiDetaliWebViewController.m
//  汇投资
//
//  Created by 杨青源 on 14/11/26.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//


#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define ios6  ([[UIDevice currentDevice].systemVersion floatValue]==6)
#import "LicaiDetaliWebViewController.h"
#import "NowInvestmentViewController.h"
#import "WXDataService.h"
#import "KKBProgressHUB.h"

@interface LicaiDetaliWebViewController ()

@end

@implementation LicaiDetaliWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameTitle.text = @"项目详情";
    UIWebView *licaiWebView = [[UIWebView alloc]init];
    if (ios6) {
        licaiWebView.frame = CGRectMake(0, 40, kScreenWidth, kScreenHeight-45);
    }else {
        licaiWebView.frame = CGRectMake(0, 60, kScreenWidth, kScreenHeight-45);
           }
   //
    NSString *ure = [NSString stringWithFormat:@"http://app.huitouzi.com/htzApp/app/free/plan/detail.json?pid=%@",_licaiModel.project_id];
    NSURL *url = [NSURL URLWithString:ure];
    NSURLRequest *requst = [NSURLRequest requestWithURL:url];
    [licaiWebView loadRequest:requst];
    licaiWebView.delegate = self;
    [self.view addSubview:licaiWebView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, kScreenHeight-45, kScreenWidth, 45);
    [button setBackgroundColor:[UIColor orangeColor]];
    button.titleLabel.textColor = [UIColor whiteColor];
    [button setTitle:@"立即投资" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(ButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    

}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [KKBProgressHUB showLoadingHubWithType:IndicatorBlack toView:self.view];

    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
  [KKBProgressHUB hideLoadingHubInView:self.view];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    UIAlertView *alterview = [[UIAlertView alloc]initWithTitle:@"加载失败" message:@"请检查网络连接" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alterview show];
    [KKBProgressHUB hideLoadingHubInView:self.view];
}

-(void)ButtonAction{
    
    NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"Cookie"];
    if (str.length==0) {
        UIAlertView *alterView = [[UIAlertView alloc]initWithTitle:@"你还未登录或者登录已经超时，请重新登录" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alterView show];
        return;
    }
    
    NSDictionary *dic1 = [[NSMutableDictionary alloc]init];
    
    [dic1 setValue:str forKey:@"Cookie"];
    NSString *str1 = @"http://app.huitouzi.com/htzApp/app/htz/isLogin.json";
    [WXDataService requestWithURL:str1 params:nil httpMethod:@"POST" block:^(id result) {
        [self loadFinsh:result];
    } requestHeader:dic1];
    



}

- (void)loadFinsh:(id)result{

    NSString *code = [result objectForKey:@"code"];
    NSString *msg = [result objectForKey:@"msg"];
    if ([code integerValue]==0000) {
        NowInvestmentViewController *nowVC = [[NowInvestmentViewController alloc]init];
        NSString *str = [NSString stringWithFormat:@"%@",_licaiModel.project_id];
        nowVC.projectID = str;
        
        [self presentViewController:nowVC animated:YES completion:nil];
    }else{
    
        UIAlertView *alterView = [[UIAlertView alloc]initWithTitle:msg message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [alterView show];
    }



}


- (void)back{

    [self dismissViewControllerAnimated:YES completion:nil];

}

@end
