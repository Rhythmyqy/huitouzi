//
//  MessgeDetailViewController.m
//  汇投资
//
//  Created by wcf on 14/11/19.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//
#define KScreenWidth [[UIScreen mainScreen] bounds].size.width
#define KScreenHeight [[UIScreen mainScreen] bounds].size.height

#import "MessgeDetailViewController.h"
#import "WXDataService.h"
@interface MessgeDetailViewController ()

@end

@implementation MessgeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameTitle.text=@"消息详情";
   
    [self loadData];
}
- (void)loadData
{
    
   
   
    NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"Cookie"];
    NSDictionary *dic1 = [[NSMutableDictionary alloc]init];
    [dic1 setValue:str forKey:@"Cookie"];
    NSString *url = [NSString stringWithFormat:@"http://app.huitouzi.com/htzApp/app/htz/messageDetail.json?&mid=%@",self.mid];
    
    [WXDataService requestWithURL:url params:nil httpMethod:@"POST" block:^(id result) {
        
        [self _loadFinsh:result];
    } requestHeader:dic1];
 
    
    
}
- (void)_loadFinsh:(id)result{
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = [result objectForKey:@"data"];
    self.tTitle.text = [dic objectForKey:@"title"];
    self.sendtime.text = [dic objectForKey:@"sendtime"];
    self.content.text =  [NSString stringWithFormat:@"        %@",[dic objectForKey:@"content"]];
}

-(void)back{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
