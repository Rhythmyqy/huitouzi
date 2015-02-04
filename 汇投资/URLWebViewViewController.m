//
//  URLWebViewViewController.m
//  汇投资
//
//  Created by 杨青源 on 14/12/3.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#import "URLWebViewViewController.h"

@interface URLWebViewViewController ()

@end

@implementation URLWebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameTitle.text = @"合同详情";
    UIWebView *WebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 60, kScreenWidth, kScreenHeight-60)];
    
    NSURL *url = [NSURL URLWithString:self.urlStr];
    NSURLRequest *requst = [NSURLRequest requestWithURL:url];
    [WebView loadRequest:requst];
    
    [self.view addSubview:WebView];
   
}

- (void)back{

    [self dismissViewControllerAnimated:YES completion:nil];

}

@end
