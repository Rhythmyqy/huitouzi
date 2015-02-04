//
//  FastPayCarWebViewController.m
//  汇投资
//
//  Created by 杨青源 on 14/11/19.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//
#define KScreenWidth [[UIScreen mainScreen] bounds].size.width
#define KScreenHeight [[UIScreen mainScreen] bounds].size.height

#import "FastPayCarWebViewController.h"
#import "AppDelegate.h"
#import "BassNavigationViewController.h"
#import "WXDataService.h"


@interface FastPayCarWebViewController ()

@end

@implementation FastPayCarWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameTitle.text=@"我的银行卡";
    
    [self loadData];
}
- (void)loadData
{
    
    NSString *url = [NSString stringWithFormat:@"http://app.huitouzi.com/htzApp/app/htz/iossign.json?paycard=%@",self.paycard];
 
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 60,KScreenWidth,KScreenHeight-75)];
    NSURL *baseUrl = [NSURL URLWithString:url];
    NSMutableURLRequest *requst = [NSMutableURLRequest requestWithURL:baseUrl];
     NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"Cookie"];
    [requst setValue:str forHTTPHeaderField:@"Cookie"];
    [requst setHTTPMethod:@"POST"];
    
    [_webView loadRequest:requst];
    [self.view addSubview:_webView];
    
}
-(void)back{
    
    [self dismissViewControllerAnimated:YES completion:nil];
   
    
}
@end

