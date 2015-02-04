//
//  CompanyDetailViewController.m
//  汇投资
//
//  Created by 杨青源 on 14/11/20.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#import "CompanyDetailViewController.h"
#import "MBProgressHUD.h"
#define ios6  ([[UIDevice currentDevice].systemVersion floatValue]==6)


@interface CompanyDetailViewController ()

@end

@implementation CompanyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameTitle.text =@"公司简介";
    _webWiew = [[UIWebView alloc]init];
    if (ios6) {
        _webWiew.frame = CGRectMake(0, 40, kScreenWidth, kScreenHeight);
    }else{
        _webWiew.frame = CGRectMake(0, 60, kScreenWidth, kScreenHeight);

    }
    NSString *getUrl = @"http://app.huitouzi.com/htzApp/about/company.html";
    _webWiew.delegate = self;
    NSURL *url = [NSURL URLWithString:getUrl];
    NSURLRequest *requst = [NSURLRequest requestWithURL:url];
    [_webWiew loadRequest:requst];

    [self.view addSubview:_webWiew];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{

    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideHUDForView:self.view animated:YES];

}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    UIAlertView *alterview = [[UIAlertView alloc]initWithTitle:@"加载失败" message:@"请检查网络连接" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alterview show];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
- (void)back{

    [self dismissViewControllerAnimated:YES completion:nil];


}
@end
