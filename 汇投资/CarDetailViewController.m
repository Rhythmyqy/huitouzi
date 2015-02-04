//
//  CarDetailViewController.m
//  汇投资
//
//  Created by 杨青源 on 14/11/10.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define ios6  ([[UIDevice currentDevice].systemVersion floatValue]==6)


#import "CarDetailViewController.h"
#import "FastPayViewController.h"
#import "TXCarViewController.h"
#import "UIImageView+WebCache.h"
#import "WXDataService.h"
#import "UIViewExt.h"


@interface CarDetailViewController (){



}
@property (weak, nonatomic) IBOutlet UIButton *payCarButton;
@property (weak, nonatomic) IBOutlet UIButton *txCarButton;
@property (weak, nonatomic) IBOutlet UIImageView *centerSelctImg;
@property (weak, nonatomic) IBOutlet UIView *leftSelctView;
@property (weak, nonatomic) IBOutlet UIView *rightSelctView;

@end

@implementation CarDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameTitle.text = @"我的银行卡";
    self.fastPatBankCarListArr = [[NSArray alloc]init];
    self.drawPatBankCarListArr = [[NSArray alloc]init];
    if (ios6) {
        self.payCarButton.frame = CGRectMake(0, 41, 160, 50);
        self.txCarButton.frame = CGRectMake(158, 41, 160, 50);
        self.leftSelctView.frame = CGRectMake(0, 91, 160, 2);
        self.rightSelctView.frame = CGRectMake(159, 91, 160, 2);
        self.centerSelctImg.frame = CGRectMake(159, 56, 1, 20);
        self.addTxCarView.frame = CGRectMake(0, 101, 320, 44);
        self.addFastPayCarView.frame = CGRectMake(0, 101, 320, 44);
    }else{
        self.addTxCarView.frame = CGRectMake(0, 121, 320, 44);
        self.addFastPayCarView.frame = CGRectMake(0, 121, 320, 44);
    }
    self.addTxCarView.hidden = YES;
    self.txTableView.hidden = YES;
    [self loadData];
   
   
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self loadData];
    
    [self.fastPayTableView reloadData];
    [self.txTableView reloadData];
}

- (void)loadData{
    NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"Cookie"];
    
    NSDictionary *dic1 = [[NSMutableDictionary alloc]init];
    
    [dic1 setValue:str forKey:@"Cookie"];
    //http://app.huitouzi.com/htzApp/app/htz/money.json
    NSString *url = @"http://app.huitouzi.com/htzApp/app/htz/banklist.json";
    [WXDataService requestWithURL:url params:nil httpMethod:@"POST" block:^(id result) {
        [self loadDataFinsh:result];
        
    } requestHeader:dic1];
    
    
    


}

- (void)loadDataFinsh:(id)result{
    NSString *code = [result objectForKey:@"code"];
    NSString *msg = [result objectForKey:@"msg"];
    if ([code integerValue]==0000) {
        //快捷支付卡
        NSArray *quickPatBankCar = [[NSArray alloc]init];
       quickPatBankCar = [[result objectForKey:@"data"]objectForKey:@"quickpaybank"];
        self.fastPatBankCarListArr = quickPatBankCar;
        NSArray *drawPayBankCar= [[NSArray alloc]init];
        drawPayBankCar = [[result objectForKey:@"data"]objectForKey:@"withdrawbank"];
        self.drawPatBankCarListArr = drawPayBankCar;
        
        
        
        
    }else if([code integerValue]==2000 ||[code integerValue]== 2001){
        UIAlertView *alterView = [[UIAlertView alloc]initWithTitle:msg message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    
        [alterView show];
    }

    
    [self.fastPayTableView reloadData];
    [self.txTableView reloadData];
    if (ios6) {
        self.fastPayTableView.frame = CGRectMake(0, 165,kScreenWidth , self.fastPatBankCarListArr.count*44);
        self.txTableView.frame = CGRectMake(0, 165, kScreenWidth, self.drawPatBankCarListArr.count*44);
    }else{
    self.fastPayTableView.frame = CGRectMake(0, 185,kScreenWidth , self.fastPatBankCarListArr.count*44);
    self.txTableView.frame = CGRectMake(0, 185, kScreenWidth, self.drawPatBankCarListArr.count*44);
    }
}



#pragma mark tableviewdatadelege

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.fastPayTableView) {
      
        return self.fastPatBankCarListArr.count;
        
    }else{
        
        return self.drawPatBankCarListArr.count;
    }
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
static NSString *iden = @"cell_fastcar";
 static NSString *iden1 = @"cell_drawbank";
    UITableViewCell *drawCell = [tableView dequeueReusableCellWithIdentifier:iden1];
    UITableViewCell *fastCarCell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (tableView == self.fastPayTableView) {
       
        if (fastCarCell == nil) {
            fastCarCell = [[UITableViewCell alloc]initWithStyle: UITableViewCellStyleValue1 reuseIdentifier:iden];
            
         
        }
        if (self.fastPatBankCarListArr != nil) {
            NSString *strurl = [self.fastPatBankCarListArr[indexPath.row] objectForKey:@"bankpic"];
            NSURL *url = [NSURL URLWithString:strurl];
           [fastCarCell.imageView sd_setImageWithURL:url];
            fastCarCell.textLabel.text = [self.fastPatBankCarListArr[indexPath.row] objectForKey:@"bank_name"];
            fastCarCell.detailTextLabel.text = [self.fastPatBankCarListArr[indexPath.row]objectForKey:@"cardno"];
          
            
        }
       
 
        
        return fastCarCell;
    }else{
    
        if (drawCell == nil) {
            drawCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:iden1];
            
        }
        if (self.drawPatBankCarListArr != nil) {
            NSString *strurl = [self.drawPatBankCarListArr[indexPath.row] objectForKey:@"bankpic"];
            NSURL *url = [NSURL URLWithString:strurl];
            [drawCell.imageView sd_setImageWithURL:url];
           // [drawCell.imageView setImageWithURL:url];
            drawCell.textLabel.text = [self.drawPatBankCarListArr[indexPath.row] objectForKey:@"bank_name"];
            drawCell.detailTextLabel.text = [self.drawPatBankCarListArr[indexPath.row]objectForKey:@"cardno"];
        }
       
       
        return drawCell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{


    return 0.1;
}

-(void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)addFastCarAction:(id)sender {
    FastPayViewController *fastPayVC = [[FastPayViewController alloc]init];
    [self.navigationController pushViewController:fastPayVC animated:YES];
}

- (IBAction)addTXCarAction:(id)sender {
    TXCarViewController *txCarVC = [[TXCarViewController alloc]init];
    [self.navigationController pushViewController:txCarVC animated:YES];
    
}
- (IBAction)fastPayCarAction:(id)sender {
    self.selectViewone.backgroundColor = [UIColor orangeColor];
    self.selectViewtwo.backgroundColor = [UIColor lightGrayColor];
    self.addFastPayCarView.hidden = NO;
    self.addTxCarView.hidden = YES;
    self.txTableView.hidden = YES;
    self.fastPayTableView.hidden = NO;
    
    
}

- (IBAction)txCarButton:(id)sender {
    self.selectViewone.backgroundColor = [UIColor lightGrayColor];
    self.selectViewtwo.backgroundColor = [UIColor orangeColor];
    self.addFastPayCarView.hidden = YES;
    self.addTxCarView.hidden = NO;
    self.txTableView.hidden = NO;
    self.fastPayTableView.hidden = YES;

}
@end
