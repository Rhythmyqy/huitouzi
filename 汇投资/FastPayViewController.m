//
//  FastPayViewController.m
//  汇投资
//
//  Created by 杨青源 on 14/11/6.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import "FastPayViewController.h"
#import "CarDetailViewController.h"
#import "AppDelegate.h"
#import "WXDataService.h"
#import "FastPayCarWebViewController.h"
#import "LoadBankCarList.h"
#import "bankCarListViewController.h"

@interface FastPayViewController (){
    UIAlertView *alterview1;
    UIAlertView *alterview2;
     LoadBankCarList *loadBank;//加载支持的银行卡
}
@end

@implementation FastPayViewController

- (void)viewWillAppear:(BOOL)animated{
    NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"bankName"];
    if (str != nil) {
        [bankButton setTitle:str forState:UIControlStateNormal];
    }
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"bankName"];
    [[NSUserDefaults standardUserDefaults]synchronize];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameTitle.text=@"添加快捷支付银行卡";
    
    loadBank = [[LoadBankCarList alloc]init];
    
    [loadBank getBankList];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changevlue) name:@"UITextFieldTextDidEndEditingNotification" object:nil];
    
    bankButton = [UIButton buttonWithType:UIButtonTypeCustom];
    bankButton.frame = CGRectMake(40, 81, 230, 40);
    bankButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [bankButton setTitle:@"请选择银行卡" forState:UIControlStateNormal];
    [bankButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [bankButton setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:bankButton];
    [bankButton addTarget:self action:@selector(bankAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.phoneNum.hidden = YES;
}

//手机号
- (void)changevlue
{
    if (_bankPhoneNum.text.length <11&&_bankPhoneNum.text.length !=0) {
        alterview1 = [[UIAlertView alloc]initWithTitle:@"手机号为11位" message:@"请重新输入" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alterview1 show];
    }else if(_bankPhoneNum.text.length >11){
        alterview2 = [[UIAlertView alloc]initWithTitle:@"手机号为11位" message:@"请重新输入" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alterview2 show];
    }else if (_bankPhoneNum.text.length == 0){
        
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView==alterview1||alertView == alterview2) {
        if (buttonIndex==1) {
            _bankPhoneNum.text=nil;
        }
    }
}

- (void)viewWillappear:(BOOL)animated{
    [super viewWillAppear:YES];

}



- (void)bankAction:(id)sender{
    bankCarListViewController *bankListVC = [[bankCarListViewController alloc]init];
    [self.navigationController pushViewController:bankListVC animated:YES];

   
    
//    if(dropDown == nil) {
//        CGFloat f = 200;
//       
//        dropDown = [[NIDropDown alloc]showDropDown:sender :&f : [loadBank.bankNameAndID allKeys]];
//        dropDown.delegate = self;
//    }
//    else {
//        [dropDown hideDropDown:sender];
//        [self rel];
//    }
    
}

- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
    [self rel];
}

-(void)rel{
    
    dropDown = nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)back{
    
  
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (IBAction)getVerificationcode:(id)sender{
    
}
                     
- (IBAction)addCarAction:(id)sender{

    
    FastPayCarWebViewController *fastPayVC=[[FastPayCarWebViewController alloc] init];
    
    if (self.selectBankName.text.length >0) {
      fastPayVC.paycard = self.selectBankName.text;
    [self presentViewController:fastPayVC animated:YES completion:nil];
    }else{
        UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:@"请输入银行卡号" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertview show];
    }
    
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.selectBankName resignFirstResponder];
    [self.bankPhoneNum resignFirstResponder];
    [self.codeNum resignFirstResponder];
}
@end
