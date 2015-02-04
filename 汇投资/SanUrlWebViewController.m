//
//  SanUrlWebViewController.m
//  汇投资
//
//  Created by 杨青源 on 14/12/4.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#import "SanUrlWebViewController.h"

@interface SanUrlWebViewController ()

@end

@implementation SanUrlWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameTitle.text = @"合同详情";
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 60, kScreenWidth, kScreenHeight-60)];
    
    NSURL *url = [NSURL URLWithString:self.urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
    [self.view addSubview:webView];
    
    
    
    
}
- (void)back{


    [self dismissViewControllerAnimated:YES completion:nil];


}





@end
