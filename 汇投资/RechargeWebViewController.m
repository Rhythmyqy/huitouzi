//
//  RechargeWebViewController.m
//  汇投资
//
//  Created by 杨青源 on 14/11/24.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#import "RechargeWebViewController.h"

@interface RechargeWebViewController ()

@end

@implementation RechargeWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _initView];
}


- (void)_initView{

    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 60, kScreenWidth, kScreenHeight)];

    /*
    
     
     url:  app/htz/iosrecharge
     请求参数：money：充值金额
     bindbankid 开通银行卡的id；
     返回数据：成功或失败
     例如：
     http://app.huitouzi.com/htzApp/app/htz/iosrecharge.json?money=0.01&bindbankid=74
     
    NSString *url = [NSString stringWithFormat:@"http://app.huitouzi.com/htzApp/app/htz/iosrecharge.json?money=%@&bindbankid=74",self.rechargeNum];
     */
    
    
    NSString *url = [NSString stringWithFormat:@"http://app.huitouzi.com/htzApp/app/htz/iosrecharge.json?money=%@&bindbankid=%@",self.moneyneed,self.bankID];
    NSURL *url1 = [NSURL URLWithString:url];
    NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"Cookie"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url1];
    [request setHTTPMethod:@"POST"];
    [request setValue:str forHTTPHeaderField:@"Cookie"];
  
    [webView loadRequest:request];
    [self.view addSubview:webView];
    
//    NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"Cookie"];
    
    NSDictionary *dic1 = [[NSMutableDictionary alloc]init];
    
    [dic1 setValue:str forKey:@"Cookie"];

}

- (void)back{

    [self dismissViewControllerAnimated:YES completion:nil];


}
@end
