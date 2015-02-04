//
//  bankCarListViewController.m
//  汇投资
//
//  Created by 杨青源 on 15/1/14.
//  Copyright (c) 2015年 杨青源. All rights reserved.
//
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#import "bankCarListViewController.h"
#import "TXCarViewController.h"


@interface bankCarListViewController (){

LoadBankCarList *loadBank;//加载支持的银行卡
}

@end

@implementation bankCarListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.nameTitle.text = @"可用银行列表";
    loadBank = [[LoadBankCarList alloc] init];
    [loadBank getBankList];//异步加载银行卡
    [self performSelector:@selector(_initView) withObject:nil afterDelay:1];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)_initView{


    
    self.myTabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 70, kScreenWidth, kScreenHeight-70) style:UITableViewStylePlain];
    self.myTabelView.backgroundColor = [UIColor clearColor];
    self.myTabelView.backgroundView.backgroundColor = [UIColor clearColor];
    self.myTabelView.delegate = self;
    self.myTabelView.dataSource = self;
    [self.view addSubview:self.myTabelView];
    
    

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [loadBank.bankNameAndID allKeys].count;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static  NSString *iden = @"cell_mybanklist";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
        cell.backgroundColor = [UIColor clearColor];
    }

      cell.textLabel.text = [loadBank.bankNameAndID allKeys][indexPath.row];
  
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
    
    [[NSUserDefaults standardUserDefaults]setObject:[loadBank.bankNameAndID allKeys][indexPath.row] forKey:@"bankName"];
    [self back];
}


- (void)back{
    [self.navigationController popViewControllerAnimated:YES];

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
