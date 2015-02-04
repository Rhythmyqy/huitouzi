//
//  BassViewController.m
//  汇投资
//
//  Created by 杨青源 on 14/11/4.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//
#define ios  ([[UIDevice currentDevice].systemVersion floatValue])
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#import "BassViewController.h"
#import "AppDelegate.h"
#import "UIColor+FlatUI.h"

@interface BassViewController ()

@end

@implementation BassViewController



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self  = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    
    }
    
    return self;
    
}

    

- (void)_initNav{
    self.view.backgroundColor = [UIColor colorFromHexCode:@"efeff4"];
    
    [self.navigationController setNavigationBarHidden:YES];
    UINavigationBar *bar = [[UINavigationBar alloc]init];
    if (ios == 6) {
        bar.frame = CGRectMake(0, 0, kScreenWidth, 44);
         [bar setBackgroundImage:[UIImage imageNamed:@"top_btn6.png"] forBarMetrics:UIBarMetricsDefault];
    
    }else{
        bar.frame = CGRectMake(0, 0, kScreenWidth, 64);
 
   
  
    [bar setBackgroundImage:[UIImage imageNamed:@"top_btn.png"] forBarMetrics:UIBarMetricsDefault];
    }

    UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:nil];
    //左边按钮
    self.left = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.left setFrame:CGRectMake(-30, 2, 28, 28)];
    [self.left setImage:[UIImage imageNamed:@"返回按钮没选.png"] forState:UIControlStateNormal];
    [self.left addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:self.left];
    [item setLeftBarButtonItem:leftButton];
    //    //中间图标
    self.nameTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    // 右边图标
    self.nameTitle.backgroundColor = [UIColor clearColor];
    self.right2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.right2 setFrame:CGRectMake(0, 280, 28, 28)];
      [self.right2 addTarget:self action:@selector(RegistrationAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:self.right2];
    [item setRightBarButtonItem:rightButton];
    
   
    self.nameTitle.textColor = [UIColor whiteColor];
    [item setTitleView:self.nameTitle];
    
    
    [bar pushNavigationItem:item animated:NO];
    
    [self.view addSubview:bar];
    
}

-(void)back{

        AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
       [appDelegate.mmViewCtrl toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];



}




- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self _initNav];
    
    
}

- (void)RegistrationAction{
   
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
