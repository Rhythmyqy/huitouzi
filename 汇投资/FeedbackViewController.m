//
//  FeedbackViewController.m
//  汇投资
//
//  Created by 杨青源 on 14/11/6.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//
#define TEXT_MAXLENGTH 140
#import "FeedbackViewController.h"
#import "AppDelegate.h"
#import "NetService.h"
#import "MBProgressHUD.h"

@interface FeedbackViewController (){

    UIAlertView *confirmalterView;
}

@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.nameTitle.text = @"意见反馈";
    self.textView.delegate=self;
    if([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]){
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    
    
}

- (void)setAutomaticallyAdjustsScrollViewInsets:(BOOL)automaticallyAdjustsScrollViewInsets

{
    
    if([[UIDevice currentDevice].systemVersion integerValue]>=7){
        
        [super setAutomaticallyAdjustsScrollViewInsets:automaticallyAdjustsScrollViewInsets];
        
    }
    
}



#pragma mark - 限制输入字数
- (BOOL)textView:(UITextView *)atextView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSString *new = [self.textView.text stringByReplacingCharactersInRange:range withString:text];
    NSInteger res = TEXT_MAXLENGTH-[new length];
    if(res >= 0){
        return YES;
    }
    else{
        NSRange rg = {0,[text length]+res};
        if (rg.length>0) {
            NSString *s = [text substringWithRange:rg];
            [self.textView setText:[self.textView.text stringByReplacingCharactersInRange:range withString:s]];
        }
        return NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)back{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    
}


- (IBAction)Submit {
    NSString *content = self.textView.text;
    long length = [content length];
    if(length<10||length>254){
        UIAlertView *alterView = [[UIAlertView alloc]initWithTitle:@"请输入10～254个文字" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alterView show];
        return;
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
   
    NSString *url =@"htz/saveSuggest.json";
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
   
        
    [dic setObject:self.textView.text forKey:@"content"];
    
    [NetService post:url parameters:dic success:^(id responseObject) {
        [self loadFinsh:responseObject];
    } failure:^(NSString *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    } netError:^(NSString *error) {
         [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
    
    
    
}

- (void)loadFinsh:(id)result{
   
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        confirmalterView = [[UIAlertView alloc]initWithTitle:@"提交成功" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [confirmalterView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView == confirmalterView) {
        if (buttonIndex == 0) {
            [self back];
        }
    }

}



@end
