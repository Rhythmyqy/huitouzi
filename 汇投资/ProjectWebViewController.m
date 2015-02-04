//
//  ProjectWebViewController.m
//  汇投资
//
//  Created by 杨青源 on 14/11/17.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//
#define KScreenWidth [[UIScreen mainScreen] bounds].size.width
#define KScreenHeight [[UIScreen mainScreen] bounds].size.height
#define ios6  ([[UIDevice currentDevice].systemVersion floatValue]==6)
#import "ProjectWebViewController.h"
#import "LicaiNowInvestViewController.h"


#import "CenterViewController.h"
#import "WXDataService.h"
#import "LoginViewController.h"
#import "KKBProgressHUB.h"
@interface ProjectWebViewController ()

@end

@implementation ProjectWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameTitle.text = @"项目详情";
    
    _photoModels = [[NSMutableArray alloc] initWithCapacity:1];
    [self loadData];
    [self _initView];
}

- (void)_initView{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, KScreenHeight -50, KScreenWidth, 50);
    [button setTitle:@"立即投资" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:button];
}


- (void)loadData{
//    NSString *userID =[[[NSUserDefaults standardUserDefaults]objectForKey:@"userInfor"] objectForKey:@"user_id"];
    NSString *baseurl = [NSString stringWithFormat:@"http://app.huitouzi.com/htzApp/app/free/sanProject/detail.json?&pid=%@&type=1",self.projectID];
    
   
    if (ios6) {
       _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 40, KScreenWidth, KScreenHeight-75)];
    }else{
    
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 60, KScreenWidth, KScreenHeight-75)];
    }
    
    NSURL *url = [NSURL URLWithString:baseurl];
    
    NSURLRequest *requset1 = [NSURLRequest requestWithURL:url];
    

    
   
    
    [_webView loadRequest:requset1];
    _webView.delegate = self;
    [self.view addSubview:_webView];

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
    UIAlertView *alterview = [[UIAlertView alloc]initWithTitle:@"加载失败" message:@"请检查网络连接" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alterview show];
   [KKBProgressHUB hideLoadingHubInView:self.view];
}


- (void)setHomeModel:(HomeModel *)homeModel{
    if (_homeModel != homeModel) {
        _homeModel =homeModel;
        
        NSString *proID = [NSString stringWithFormat:@"%@",_homeModel.project_id];
        self.projectID = proID;
        
    }




}

- (void)buttonAction{
    //http://app.huitouzi.com/htzApp/app/htz/isLogin.json
    
    
    
    NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"Cookie"];
  
    
    if (str.length == 0) {
        UIAlertView *alterView = [[UIAlertView alloc]initWithTitle:@"你还没登录,或者登录已经超时" message:@"去登录?" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
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
        LicaiNowInvestViewController *licaiVC = [[LicaiNowInvestViewController alloc]init];
        
        licaiVC.projectID = self.projectID;
        [self presentViewController:licaiVC animated:YES completion:nil];
        
    }else if([code integerValue]==2000){
      
        UIAlertView *alterView = [[UIAlertView alloc]initWithTitle:msg message:@"去登录?" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [alterView show];
    
    }else if ([code integerValue]==2001){
    
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userInfor"];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"Cookie"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        UIAlertView *alterview = [[UIAlertView alloc]initWithTitle:msg message:@"去登录?" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [alterview show];
    
    
    }
    
    
  


}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (buttonIndex==0) {
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        loginVC.isOtherVC = 1;
        [self presentViewController:loginVC animated:YES completion:nil];
        
        
    }


}


- (void)back{
    
    [self dismissViewControllerAnimated:YES completion:nil];

}


@end
