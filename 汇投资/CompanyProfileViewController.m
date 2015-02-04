//
//  CompanyProfileViewController.m
//  汇投资
//
//  Created by 杨青源 on 14/11/6.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import "CompanyProfileViewController.h"

@interface CompanyProfileViewController ()

@end

@implementation CompanyProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.nameTitle.text = @"公司简介";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
static NSString *iden = @"cpCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:iden];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.row == 0) {
        cell.textLabel.text = @"版本号";
        cell.detailTextLabel.text =[NSString stringWithFormat:@"v%@", [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey]];
        
  
    }else if(indexPath.row == 1){
        cell.textLabel.text = @"官方微信";
        cell.detailTextLabel.text = @"微信号huitouzicom";
    
    }else if(indexPath.row== 2){
        cell.textLabel.text = @"官方微博";
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        cell.detailTextLabel.text = @"http//weibo.com/huitouziwang";
    
    }else if(indexPath.row == 3){
    
        cell.textLabel.text = @"客服电话";
        
        cell.detailTextLabel.text = @"400-082-8888";
    }
    
    return cell;
}




-(void)back{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    
}
@end
