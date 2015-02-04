//
//  LeftViewController.m
//  汇投资
//
//  Created by 杨青源 on 14-10-31.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//
#define ios6  ([[UIDevice currentDevice].systemVersion floatValue]==6)

#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#import "LeftViewController.h"
#import "CenterCell.h"
#import "MoneyManageViewController.h"
#import "CenterViewController.h"
#import "SellDetailViewController.h"
#include "SafeViewController.h"
#import "MessgeViewController.h"
#import "MoreViewController.h"
#import "BassNavigationViewController.h"
#import "WXDataService.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "UIViewExt.h"
#import "User.h"
#import "UIColor+FlatUI.h"
@interface LeftViewController (){
    
    CenterCell *cell;
    
    UIAlertView *alterview1;
    UIAlertView *alterview2;
    UIAlertView *alterview3;
    UIAlertView *alterview4;
}

@property(nonatomic,strong)NSArray *imgnameArry;

@end

@implementation LeftViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self  = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.title = @"我的账户";
        
        
    }
    
    return self;
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
    self.userModel = [[UserModel alloc]initWithDataDic:[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfor"]];
    [self _initViewHeaderView];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor= [UIColor colorFromHexCode:@"3a3a3a"];
    self.tableView.separatorColor = [UIColor clearColor];
    
    
    
    UIView *nav = [[UIView alloc]initWithFrame:CGRectMake(20, 0, 320, 60)];
    nav.backgroundColor = [UIColor colorFromHexCode:@"3a3a3a"];
    [self.view addSubview:nav];
    UILabel *titlLabel = [[UILabel alloc]init];
    titlLabel.frame = CGRectMake(0, 20, 80, 40);
    titlLabel.backgroundColor = [UIColor clearColor];
    titlLabel.textColor = [UIColor whiteColor];
    titlLabel.text = @"我的账户";
    
    
    
    [nav addSubview:titlLabel];
    
}

- (void)_initViewHeaderView{
    
    UIView *headerView  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.width, 150)];
    
    self.tableView.tableHeaderView = headerView;
    
    UIImageView *nickImage = [[UIImageView alloc]initWithFrame:CGRectMake(40, 50, 60, 60)];
    
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"userInfor"]==nil) {
      [nickImage setImage:[UIImage imageNamed:@"个人中心未登陆5尺寸_03.png"]];
    }else{
    
        [nickImage setImage:[UIImage imageNamed:@"个人中心已登录5尺寸_03.png"]];
    }
    
    
    [[[NSUserDefaults standardUserDefaults]objectForKey:@"userInfor"]objectForKey:@"pic"];
    [headerView addSubview:nickImage];
   
     UIImageView *lineImage1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 35, 320, 1)];
    lineImage1.image = [UIImage imageNamed:@"个人中心未登陆5尺寸_02.png"];
    [headerView addSubview:lineImage1];
   
    
  
    UILabel *nickNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(nickImage.right+20, 55, 160, 45)];
    
    nickNameLabel.backgroundColor = [UIColor clearColor];
    nickNameLabel.textColor = [UIColor whiteColor];
    
    
    UIImageView *lineImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, headerView.bottom, 320, 1)];
    lineImage.image = [UIImage imageNamed:@"个人中心未登陆5尺寸_02.png"];
    [headerView addSubview:lineImage];
    
    
    if (self.userModel.username != nil) {
        nickNameLabel.text = self.userModel.username;
        
    }else{
        nickNameLabel.text = @"未登录";
    }
    [headerView addSubview:nickNameLabel];
    
    //手机 身份证 邮箱 实名
    NSInteger phone=[self.userModel.phoneactivestatus integerValue];
    NSString *phoneImg = [[NSString alloc]init];
    NSString *phonestr = [[NSString alloc]init];
    if (phone == 1) {
        phoneImg = @"手机绑定没绑定.png";
        phonestr = @"未绑定";
    }else if (phone==2){
        phoneImg = @"手机绑定已绑定.png";
        phonestr = @"已认证";
    }else {
        phoneImg = @"手机绑定没绑定.png";
        phonestr = @"未绑定";
    }
    NSInteger realname= [_userModel.is_realname integerValue];
    NSString *realnameimg = [[NSString alloc]init];
    NSString *realnameStr = [[NSString alloc]init];
    if (realname==1) {
        realnameimg = @"身份证没认证.png";
        realnameStr = @"未认证";
    }else if(realname == 2){
        realnameimg = @"身份证已认证.png";
        realnameStr = @"已认证";
    }else{
        realnameimg = @"身份证没认证.png";
        realnameStr = @"未认证";
    }
    
    
    NSInteger email= [_userModel.emailactivestatus integerValue];
    NSString *emailPImg = [[NSString alloc]init];
    NSString *emailstr= [[NSString alloc]init];
    if (email == 1) {
        emailstr = @"未绑定";
        emailPImg = @"邮箱没认证.png";
    }else if (email == 2){
        emailstr = @"已绑定";
        emailPImg = @"邮箱已认证.png";
    }else{
        emailstr = @"未绑定";
        emailPImg = @"邮箱没认证.png";
    }
    NSInteger payment= [_userModel.has_payment_pwd integerValue];
    NSString *paymentimg = [[NSString alloc]init];
    NSString *paymentstr = [[NSString alloc]init];
    if (payment == 1) {
        paymentstr = @"未设置";
        paymentimg = @"支付密码没设置.png";
    }else if (payment == 2){
        paymentstr = @"已设置";
        paymentimg = @"支付密码已认证.png";
    }else{
        paymentstr = @"未设置";
        paymentimg = @"支付密码没设置.png";
    }
    NSArray *imageNameArr = @[phoneImg,realnameimg,emailPImg,paymentimg];
    NSArray *nameArr = @[phonestr,realnameStr,emailstr,paymentstr];
    for (int i =0; i<imageNameArr.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*(250/4)+20, 120, 20, 20);
        [button setImage:[UIImage imageNamed:imageNameArr[i]] forState:UIControlStateNormal];
        [headerView addSubview:button];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(button.right, 120, 45, 21)];
        label.text = nameArr[i];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:11];
        label.textColor= [UIColor lightGrayColor];
        [headerView addSubview:label];
    }
    UIButton *loginbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    loginbutton.frame = CGRectMake(0, 0, headerView.width, headerView.height);
    [loginbutton addTarget:self action:@selector(ButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:loginbutton];
    
}

- (void)ButtonAction:(UIButton *)button{
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"userInfor"] objectForKey:@"user_id"]==nil) {
        LoginViewController *login = [[LoginViewController alloc]init];
        //点击单元格跳转到对应的视图
        AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        appDelegate.baseNav = [[BassNavigationViewController alloc] initWithRootViewController:login];
        appDelegate.mmViewCtrl.centerViewController = appDelegate.baseNav;
        //实现两个视图之间的切换
        [appDelegate.mmViewCtrl toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
        

        
        
    }
    
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 6;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString  *iden = @"cell_1";
    _imgnameArry = @[@"项目列表没选",@"资金管理没选",@"交易明细没选",@"安全中心没选",@"系统消息没选",@"更多 没选"];
    
    NSArray *nameArray =@[@"项目列表",@"资金管理",@"交易明细",@"安全中心",@"系统消息",@"更多"];
    cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"CenterCell" owner:self options:nil]lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    
    cell.titleLabel.text = nameArray[indexPath.row];
    
    cell.imagName = _imgnameArry[indexPath.row];
    
    
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}

//判断是否登陆
- (BOOL)isLogin{
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"userInfor"] != nil) {
        return YES;
    }else {
        
        alterview1 = [[UIAlertView alloc]initWithTitle:@"登录后才能查看我哟！" message:@"去登录？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
        
        [alterview1 show];
        return NO;
        
    }
    
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    if (indexPath.row == 1) {
        MoneyManageViewController *moneyMageCtrl = [[MoneyManageViewController alloc]init];
        
        //点击单元格跳转到对应的视图
        if ([self isLogin] == YES) {
            AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
            appDelegate.baseNav = [[BassNavigationViewController alloc] initWithRootViewController:moneyMageCtrl];
            
            appDelegate.mmViewCtrl.centerViewController = appDelegate.baseNav;
            //实现两个视图之间的切换
            [appDelegate.mmViewCtrl toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
        }
        
        
    }else if(indexPath.row == 2){
        
        if ([self isLogin] == YES) {
            SellDetailViewController *sellDetail= [[SellDetailViewController alloc]init];
            //点击单元格跳转到对应的视图
            AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
            appDelegate.baseNav = [[BassNavigationViewController alloc] initWithRootViewController:sellDetail];
            appDelegate.mmViewCtrl.centerViewController = appDelegate.baseNav;
            //实现两个视图之间的切换
            [appDelegate.mmViewCtrl toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
            
        }
        
    }else if(indexPath.row == 3){
        if ([self isLogin]== YES) {
            SafeViewController *safeCtrl = [[SafeViewController alloc]init];
            //点击单元格跳转到对应的视图
            AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
            appDelegate.baseNav = [[BassNavigationViewController alloc] initWithRootViewController:safeCtrl];
            appDelegate.mmViewCtrl.centerViewController = appDelegate.baseNav;
            //实现两个视图之间的切换
            [appDelegate.mmViewCtrl toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
            
        }
        
    }else if(indexPath.row == 4){
        if ([self isLogin] == YES) {
            MessgeViewController *messge = [[MessgeViewController alloc]init];
            //点击单元格跳转到对应的视图
            AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
            appDelegate.baseNav = [[BassNavigationViewController alloc] initWithRootViewController:messge];
            appDelegate.mmViewCtrl.centerViewController = appDelegate.baseNav;
            //实现两个视图之间的切换
            [appDelegate.mmViewCtrl toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
        }
        
        
    }else if(indexPath.row == 5){
        MoreViewController *moreCtrl = [[MoreViewController alloc]init];
        //点击单元格跳转到对应的视图
        AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        appDelegate.baseNav = [[BassNavigationViewController alloc] initWithRootViewController:moreCtrl];
        appDelegate.mmViewCtrl.centerViewController = appDelegate.baseNav;
        //实现两个视图之间的切换
        [appDelegate.mmViewCtrl toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    }else if(indexPath.row == 0){
        
        
        CenterViewController *centerVC = [[CenterViewController alloc]init];
        AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        appDelegate.baseNav = [[BassNavigationViewController alloc] initWithRootViewController:centerVC];
        appDelegate.mmViewCtrl.centerViewController = appDelegate.baseNav;
        //实现两个视图之间的切换
        [appDelegate.mmViewCtrl toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
        
        [centerVC.navigationController setNavigationBarHidden:YES];
        
        UINavigationBar *bar = [[UINavigationBar alloc]init];
        if (ios6) {
            bar.frame = CGRectMake(0, 0, kScreenWidth, 44);
            [bar setBackgroundImage:[UIImage imageNamed:@"top_btn6.png"] forBarMetrics:UIBarMetricsDefault];
            
        }else{
            bar.frame = CGRectMake(0, 0, kScreenWidth, 64);
            
            
            
            [bar setBackgroundImage:[UIImage imageNamed:@"top_btn.png"] forBarMetrics:UIBarMetricsDefault];
        }
        UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:nil];
        //左边按钮
        UIButton *left = [UIButton buttonWithType:UIButtonTypeCustom];
        [left setFrame:CGRectMake(0, 2, 28, 28)];
        [left setImage:[UIImage imageNamed:@"头像.png"] forState:UIControlStateNormal];
        [left addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:left];
        [item setLeftBarButtonItem:leftButton];
        //中间图标
        UIButton *title = [UIButton buttonWithType:UIButtonTypeCustom];
        [title setFrame:CGRectMake(0, 2, 32, 32)];
        [title setImage:[UIImage imageNamed:@"LOGO.png"]forState:UIControlStateNormal];
        
        [item setTitleView:title];
        
        
        [bar pushNavigationItem:item animated:NO];
        
        [centerVC.navigationController.view addSubview:bar];
        
        
        
    }
}

#pragma mark alertViewdelegete


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        
        LoginViewController *loginViewVC = [[LoginViewController alloc]init];
        AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        appDelegate.baseNav = [[BassNavigationViewController alloc] initWithRootViewController:loginViewVC];
        appDelegate.mmViewCtrl.centerViewController = appDelegate.baseNav;
        //实现两个视图之间的切换
        [appDelegate.mmViewCtrl toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    }
    
    
    
}

- (void)back{
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate.mmViewCtrl toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    
}




@end
