//
//  SellDetailViewController.m
//  汇投资
//
//  Created by 杨青源 on 14-10-31.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#import "SellDetailViewController.h"
#import "TzjlViewController.h"
#import "TxjlViewController.h"
#import "CzjlViewController.h"

@interface SellDetailViewController ()

@end

@implementation SellDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorColor = [UIColor clearColor];
    
    if ([[UIDevice currentDevice].systemVersion integerValue]==6) {
        self.tableView.frame = CGRectMake(0, 64, 320, 133);
    }else {
    
    self.tableView.frame = CGRectMake(0, 64, 320, 153);
    
    }
   self.nameTitle.text = @"交易明细";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *iden = @"Detailcell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textColor = [UIColor lightGrayColor];
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [cell addSubview:lineView];
    }
    if (indexPath.row == 0) {
        cell.textLabel.text = @"投资记录";
     
    }else if(indexPath.row ==1){
    cell.textLabel.text = @"提现记录";
       
    }else if(indexPath.row == 2){
    
    cell.textLabel.text = @"充值记录";
     
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 0) {
        TzjlViewController *tzCtrl = [[TzjlViewController alloc]init];
        [self.navigationController pushViewController:tzCtrl animated:YES];
        
    }else if(indexPath.row == 1){
        TxjlViewController *txCtrl = [[TxjlViewController alloc]init];
        [self.navigationController pushViewController:txCtrl animated:YES];
    
    }else if(indexPath.row == 2){
    
        CzjlViewController *czCtrl = [[CzjlViewController alloc]init];
        [self.navigationController pushViewController:czCtrl animated:YES];
    }else{
    
    }
    
}

@end
