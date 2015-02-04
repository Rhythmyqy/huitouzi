//
//  MoreViewController.m
//  汇投资
//
//  Created by 杨青源 on 14-10-31.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import "MoreViewController.h"
#import "MoreCell.h"
#import "FeedbackViewController.h"
#import "CompanyProfileViewController.h"
#import "LoginViewController.h"
#import "BassNavigationViewController.h"
#import "AppDelegate.h"
#import "CompanyDetailViewController.h"
#import "NetService.h"
#import <ShareSDK/ShareSDK.h>
#import "MBProgressHUD.h"
#define ios6  ([[UIDevice currentDevice].systemVersion floatValue]==6)


@interface MoreViewController ()

@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameTitle.text = @"更多";
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"userInfor"]==nil) {
        self.getoutButton.hidden = YES;
    }
    if (ios6) {
        self.myTableView.frame = CGRectMake(0, 44, 320, 176);
        self.getoutButton.frame = CGRectMake(15, 252, 290, 45);
    }
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 4;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
static NSString *iden = @"cell_more";
    MoreCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"MoreCell" owner:self options:nil].lastObject;
        
    }
    if (indexPath.row == 0) {
        [cell.titleView setImage:[UIImage imageNamed:@"公司简介"]];
        cell.titleLabel.text = @"公司简介";
    }else if(indexPath.row == 1){
        [cell.titleView setImage:[UIImage imageNamed:@"用户反馈"]];
        cell.titleLabel.text = @"用户反馈";
    
    }else if(indexPath.row == 2){
    
        [cell.titleView setImage:[UIImage imageNamed:@"联系我们"]];
        cell.titleLabel.text = @"联系我们";
        
        
    }else if(indexPath.row ==3 ){
        [cell.titleView setImage:[UIImage imageNamed:@"检测更新"]];
        cell.titleLabel.text = @"检测更新";
    
    }
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 0) {
        CompanyDetailViewController *companyDetailVC = [[CompanyDetailViewController alloc]init];
        [self presentViewController:companyDetailVC animated:YES completion:nil];

        
        
    }else if(indexPath.row == 1){
     
        FeedbackViewController *feedbackCtrl = [[FeedbackViewController alloc]init];
        [self.navigationController pushViewController:feedbackCtrl animated:YES];
       
    
    }else if(indexPath.row == 2){
    
        CompanyProfileViewController *cpCtrl = [[CompanyProfileViewController alloc]init];
        [self.navigationController pushViewController:cpCtrl animated:YES];
    
    
    }else if(indexPath.row == 3){
     

        [self onCheckVersion];
        
    
    }




}

- (void)getversionAction:(id)result{
    NSString *mesg = [result objectForKey:@"msg"];
    
    self.stAlertView = [[STAlertView alloc] initWithTitle:@"提示"
                                                  message:mesg
                                        cancelButtonTitle:@"我知道了"
                                        otherButtonTitles:nil
                        
                                        cancelButtonBlock:^{
                                            
                                        } otherButtonBlock:^{
                                            
                                        }];


}





- (IBAction)getOutAction:(id)sender {
    
    if ( [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfor"] != nil ) {
        
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userInfor"];
       
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"Cookie"];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"mydefultType"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [ShareSDK cancelAuthWithType:ShareTypeSinaWeibo];
        [ShareSDK cancelAuthWithType:ShareTypeQQSpace];
        
        
        
        UIAlertView *altview = [[UIAlertView alloc]initWithTitle:@"已安全退出" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [altview show];
        
        
        [altview dismissWithClickedButtonIndex:0 animated:YES];
        //安全退出后跳转到登录页面
        LoginViewController *login = [[LoginViewController alloc]init];
        //点击单元格跳转到对应的视图
        AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        appDelegate.baseNav = [[BassNavigationViewController alloc] initWithRootViewController:login];
        appDelegate.mmViewCtrl.centerViewController = appDelegate.baseNav;
        //实现两个视图之间的切换
        [appDelegate.mmViewCtrl toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    }
    
    
}

#pragma mark 版本检测更新
-(void)onCheckVersion
{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [infoDic objectForKey:@"CFBundleVersion"];
    NSString *URL = @"http://itunes.apple.com/lookup?id=954974026";
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:URL]];
    [request setHTTPMethod:@"POST"];
    NSHTTPURLResponse *urlResponse = nil;
    NSError *error = nil;
    NSData *recervedData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    if (!recervedData) {
        //        [KKBProgressHUB hideLoadingHubInView:self.view];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请检查网络" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alterView show];
        return;
    }
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:recervedData options:0 error:nil ];
    NSArray *infoArray = [dic objectForKey:@"results"];
    //  NSLog(@"inforArray == %@",infoArray);
    //  NSLog(@" %@",currentVersion);
    if ([infoArray count]) {
        NSDictionary *releaseInfo = [infoArray objectAtIndex:0];
        NSString *lastVersion = [releaseInfo objectForKey:@"version"];
        if (![lastVersion isEqualToString:currentVersion]) {
            //trackViewURL = [releaseInfo objectForKey:@"trackVireUrl"];
            //            [KKBProgressHUB hideLoadingHubInView:self.view];
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];//加载成功
          
            
            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"有新的版本更新" message:@"是否前往更新？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
            [alterView show];
            
            return;
        }
        else
        {
            //            [KKBProgressHUB hideLoadingHubInView:self.view];
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];//加载成功
            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"此版本为最新版本" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alterView show];
            return;
        }
    }else{
        
        //        [KKBProgressHUB hideLoadingHubInView:self.view];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];//加载成功
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"此版本为最新版本" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alterView show];
        return;
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/us/app/hui-tou-zi/id945301230?l=zh&ls=1&mt=8"];
        [[UIApplication sharedApplication]openURL:url];
    }

}

@end
