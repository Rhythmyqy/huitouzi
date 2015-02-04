//
//  MessgeViewController.m
//  汇投资
//
//  Created by 杨青源 on 14-10-31.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//
#define ios6  ([[UIDevice currentDevice].systemVersion floatValue]==6)


#import "MessgeViewController.h"
#import "AppDelegate.h"
#import "XtxxCell.h"
#import "WXDataService.h"
#import "XtxxModel.h"
#import "MessgeDetailViewController.h"


@interface MessgeViewController ()

@property (weak, nonatomic) IBOutlet UIView *centerSelectView;
@end

@implementation MessgeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self  = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    if (ios6) {
        self.wdButton.frame = CGRectMake(0, 44, 160, 45);
        self.ydButton.frame = CGRectMake(160, 44, 160, 45);
        self.leftSelectView.frame = CGRectMake(0, 89, 160, 2);
        self.rightSelectView.frame = CGRectMake(160, 89, 160, 2);
        self.centerSelectView.frame = CGRectMake(160, 55, 1, 25);
        self.tableView.frame = CGRectMake(0, 97, 320, 456);
    }
    [self loadData:_wdButton];


}
- (void)viewDidLoad {
    [super viewDidLoad];
  
    
    self.nameTitle.text = @"系统消息";
    [self loadData:_wdButton];
    self.data = [[NSMutableArray alloc] init];
   
}
- (void)loadData:(id)sender{
    
   
    NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"Cookie"];
    NSDictionary *dic1 = [[NSMutableDictionary alloc]init];
    [dic1 setValue:str forKey:@"Cookie"];
    if (sender == _wdButton) {
        NSString *url = [NSString stringWithFormat:@"http://app.huitouzi.com/htzApp/app/htz/messageList.json?&status=2&pageIndex=1&pageSize=20"];
        [WXDataService requestWithURL:url params:nil httpMethod:@"POST" block:^(id result) {
            [self _loadFinsh:result];
        } requestHeader:dic1];
    }
    else if(sender == _ydButton){
        NSString *url = [NSString stringWithFormat:@"http://app.huitouzi.com/htzApp/app/htz/messageList.json?&status=1&pageIndex=1&pageSize=20"];
        [WXDataService requestWithURL:url params:nil httpMethod:@"POST" block:^(id result) {
            [self _loadFinsh:result];
        } requestHeader:dic1];
    }
    
}

- (void)_loadFinsh:(id)result{
    NSString *code = [result objectForKey:@"code"];
    NSString *msg = [result objectForKey:@"msg"];
    if ([code integerValue] == 0000) {
        NSArray *arr = [[result objectForKey:@"data"] objectForKey:@"list"];
        
        for (NSDictionary *dic in arr) {
            XtxxModel *xtxxModel = [[XtxxModel alloc]initWithDataDic:dic];
            [self.data addObject:xtxxModel];
        }
        [_tableView reloadData];
    }else if([code integerValue] == 2000){
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:msg message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    
    }
}
#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{    
    return _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *iden = @"cell_message";
    XtxxCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"XtxxCell" owner:nil options:nil]lastObject];
    }
    cell.xtxxModel=_data[indexPath.row];
    
    if (self.wdButton.selected) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"XtxxCell" owner:nil options:nil]lastObject];
       
    }
    if (self.ydButton.selected) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"XtxxCell" owner:nil options:nil]lastObject];
    }
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MessgeDetailViewController *messageDtailVC = [[MessgeDetailViewController alloc]init];
  
    messageDtailVC.mid =  ((XtxxModel *)_data[indexPath.row]).mid;
    
    [self.navigationController pushViewController:messageDtailVC animated:YES];
 
   
}

// 未读消息
- (IBAction)whButton:(id)sender {
    _leftSelectView.backgroundColor=[UIColor orangeColor];
    _rightSelectView.backgroundColor=[UIColor lightGrayColor];
    [_data removeAllObjects];
    [self loadData:sender];
    
}
//已读消息
- (IBAction)ydButton:(id)sender {
    [_data removeAllObjects];
    _rightSelectView.backgroundColor=[UIColor orangeColor];
    _leftSelectView.backgroundColor=[UIColor lightGrayColor];
    
    [self loadData:sender];
    
}

@end
