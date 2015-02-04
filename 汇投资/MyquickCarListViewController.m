//
//  MyquickCarListViewController.m
//  汇投资
//
//  Created by 杨青源 on 15/1/14.
//  Copyright (c) 2015年 杨青源. All rights reserved.
//
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#import "MyquickCarListViewController.h"
#import "LoadBankCarList.h"

@interface MyquickCarListViewController (){
    LoadBankCarList *loadMyCar;

}
@property(nonatomic,strong)UITableView *myCarTableView;

@end

@implementation MyquickCarListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    loadMyCar = [[LoadBankCarList alloc]init];
    self.nameTitle.text = @"我的提现银行卡";
    [loadMyCar getMyBankList];
    [self performSelector:@selector(_initView) withObject:nil afterDelay:1];
}

- (void)_initView{
    self.myCarTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 70, kScreenWidth,kScreenHeight-70) style:UITableViewStylePlain];
    self.myCarTableView.backgroundColor = [UIColor clearColor];
    self.myCarTableView.backgroundView.backgroundColor = [UIColor clearColor];
    self.myCarTableView.delegate = self;
    self.myCarTableView.dataSource = self;
    [self.view addSubview:self.myCarTableView];
    NSLog(@"%@",[loadMyCar.mydrawPayBankShow allKeys]);
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [loadMyCar.mydrawPayBankShow allKeys].count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *iden = @"cell_quickcarlist";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
        cell.backgroundColor = [UIColor clearColor];
    }
    cell.textLabel.text = [loadMyCar.mydrawPayBankShow allKeys][indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    [[NSUserDefaults standardUserDefaults]setObject:[loadMyCar.mydrawPayBankShow allKeys][indexPath.row] forKey:@"mydrawbankName"];
    [self back];
}


- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
