//
//  SafeViewController.m
//  汇投资
//
//  Created by 杨青源 on 14-10-31.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import "SafeViewController.h"
#import "SafeCenterCell.h"
#import "RealAuthViewController.h"
#import "ChangePWViewController.h"
#import "PayPWViewController.h"
#import "SetPayPassWordViewController.h"
#import "AppDelegate.h"
#import "GustViewController.h"
#import "LLLockPassword.h"
@interface SafeViewController (){

    SafeCenterCell *cell;
}

@end

@implementation SafeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self  = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.nameTitle.text = @"安全中心";
    if ([[UIDevice currentDevice].systemVersion integerValue]==6) {
        _tableView.frame = CGRectMake(0, 44, 320, 177);
    }else {
        
        _tableView.frame = CGRectMake(0, 64, 320, 197);
        
    }
    
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"userInfor"] != nil) {
        NSDictionary *dic = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfor"];
        _data = [NSMutableDictionary dictionaryWithDictionary:dic];
        
    }else {
       
        

    }
 
    
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -mark UITableView  DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *iden = @"cell_0122";
    cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (cell ==nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"SafeCenterCell" owner:nil options:nil].lastObject;
        
    }
    if (indexPath.row == 0) {
        cell.authLabel.text = @"实名认证";
        
        if (_data != nil) {
            NSInteger is_realName = [[_data objectForKey:@"is_realname"] integerValue];
            if (is_realName == 1) {
                cell.detalLabel.text = @"未认证";
                cell.authImge.image = [UIImage imageNamed:@"安全中心5尺寸_03.png"];
            }else if(is_realName == 2){
                cell.detalLabel.text = @"已认证";
                cell.authImge.image = [UIImage imageNamed:@"安全中心5尺寸_06.png"];
            }else {
            cell.detalLabel.text = @"未认证";
            
            }
            
        }
     
        
    }else if(indexPath.row == 1){
      cell.authLabel.text = @"登录密码";
        if (_data == nil) {
            cell.detalLabel.text = @"未设置";
            cell.authImge.image = [UIImage imageNamed:@"安全中心5尺寸_03.png"];
        }else {
      cell.detalLabel.text = @"已设置,点击修改";
             cell.authImge.image = [UIImage imageNamed:@"安全中心5尺寸_06.png"];
        }
        
    
    }else if(indexPath.row == 2){
    cell.authLabel.text = @"支付密码";
        cell.detalLabel.text = @"未设置";
        
        if (_data != nil) {
            NSInteger has_payment_pwd = [[_data objectForKey:@"has_payment_pwd"] integerValue];
            
            if (has_payment_pwd == 1) {
                cell.detalLabel.text = @"未设置";
                 cell.authImge.image = [UIImage imageNamed:@"安全中心5尺寸_03.png"];
                
            }else if(has_payment_pwd == 2){
                cell.detalLabel.text = @"已设置,点击修改";
                 cell.authImge.image = [UIImage imageNamed:@"安全中心5尺寸_06.png"];
            }else{
            
              cell.detalLabel.text = @"未设置";
            }
            
        }
       
    
    }else if (indexPath.row == 3){
      cell.authLabel.text = @"手势密码";
        if ([LLLockPassword loadLockPassword]) {
            cell.detalLabel.text = @"已设置";
             cell.authImge.image = [UIImage imageNamed:@"安全中心5尺寸_06.png"];
        }else {
           cell.detalLabel.text = @"未设置";
            cell.authImge.image = [UIImage imageNamed:@"安全中心5尺寸_03.png"];
        }
        
    }
   
    return cell;
}
#pragma - mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        NSInteger is_realName = [[_data objectForKey:@"is_realname"] integerValue];
        if (is_realName==2) {
            UIAlertView *alterview = [[UIAlertView alloc]initWithTitle:@"已认证认证" message:@"请不要重复认证" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alterview show];
            return;
        }
        RealAuthViewController *realAuthCtrl = [[RealAuthViewController alloc]init];
        [self.navigationController pushViewController:realAuthCtrl animated:YES];
        
    }else if (indexPath.row == 1) {
       
  


        ChangePWViewController *changePwVC = [[ChangePWViewController alloc]init];
        changePwVC.passWordType = 1;
        [self.navigationController pushViewController:changePwVC animated:YES];

        
    }else if (indexPath.row == 2) {
        
        NSInteger has_payment_pwd = [[_data objectForKey:@"has_payment_pwd"] integerValue];
        
        if (has_payment_pwd == 1) {
//            cell.detalLabel.text = @"未设置";
            SetPayPassWordViewController *setPaypas = [[SetPayPassWordViewController alloc]init];
            [self.navigationController pushViewController:setPaypas animated:YES];
            
        }else if(has_payment_pwd == 2){
 //           cell.detalLabel.text = @"已设置,点击修改";
            ChangePWViewController *changePwVC = [[ChangePWViewController alloc]init];
            changePwVC.passWordType = 0;
            [self.navigationController pushViewController:changePwVC animated:YES];
        }
        
      
        
    }else if(indexPath.row == 3){
    
       
        GustViewController *gustVC  = [[GustViewController alloc]init];
        [self.navigationController pushViewController:gustVC animated:YES];
    
    }

}


@end
