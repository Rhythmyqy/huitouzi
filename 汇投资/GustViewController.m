//
//  GustViewController.m
//  汇投资
//
//  Created by 杨青源 on 15/1/13.
//  Copyright (c) 2015年 杨青源. All rights reserved.
//
#define ios6  ([[UIDevice currentDevice].systemVersion floatValue]==6)


#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

#import "GustViewController.h"
#import "UIViewExt.h"
#import "NetService.h"
#import "AppDelegate.h"
#import "SetPayPassWordViewController.h"

@interface GustViewController (){

    UIAlertView *alterView1;
    UIAlertView *alterView2;

}

@end

@implementation GustViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameTitle.text = @"手势密码管理";
    [self _initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)_initView{

    UIView *myView = [[UIView alloc]init];
    if (ios6) {
        myView.frame = CGRectMake(0, 60, kScreenWidth, 88);
    }else{
        myView.frame = CGRectMake(0, 80, kScreenWidth, 88);
    
    }
    myView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:myView];
    
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
    lineView1.alpha = 0.5;
    lineView1.backgroundColor = [UIColor lightGrayColor];
    [myView addSubview:lineView1];
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 43.5, kScreenWidth, 0.5)];
    lineView2.alpha = 0.5;
    lineView2.backgroundColor = [UIColor lightGrayColor];
    [myView addSubview:lineView2];
    
    UIView *lineView3 = [[UIView alloc]initWithFrame:CGRectMake(0, 87.5, kScreenWidth, 0.5)];
    lineView3.alpha = 0.5;
    lineView3.backgroundColor = [UIColor lightGrayColor];
    [myView addSubview:lineView3];
 
    UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectMake(kScreenWidth-80, 7, 40, 40)];
   
    switchView.tag = 106;
    switchView.on = [[NSUserDefaults standardUserDefaults]boolForKey:@"mydefultType"];//设置初始为ON的一边
  
    [myView addSubview:switchView];
    [switchView addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    
    UILabel *messagelabel = [[UILabel alloc]initWithFrame:CGRectMake(15, (44-21)/2, 80, 21)];
    messagelabel.text = @"手势密码";
    messagelabel.textColor = [UIColor blackColor];
    messagelabel.font = [UIFont systemFontOfSize:16];
    [myView addSubview:messagelabel];
    
    UILabel *messagelabel1 = [[UILabel alloc]initWithFrame:CGRectMake(15, 55, 120, 21)];
    messagelabel1.text = @"设置手势密码";
    messagelabel1.textColor = [UIColor blackColor];
    messagelabel1.font = [UIFont systemFontOfSize:16];
    [myView addSubview:messagelabel1];
    
    UIImageView *imageView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"箭头.png"]];
    imageView.frame = CGRectMake(kScreenWidth-40, 46, 40, 40);
    [myView addSubview:imageView];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 50, kScreenWidth, 30);
    [myView addSubview:button];
    
}

- (void)buttonAction{
    UISwitch *myswitch =(UISwitch *) [self.view viewWithTag:106];
    if (myswitch.on == NO) {
        UIAlertView *alterview = [[UIAlertView alloc]initWithTitle:@"请开启手势密码" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil , nil];
        [alterview show];
        return;
    }
    
    NSString *phone = [[[NSUserDefaults standardUserDefaults]objectForKey:@"userInfor"]objectForKey:@"phone"];
    alterView2 = [[UIAlertView alloc]initWithTitle:@"身份验证" message:phone delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    alterView2.alertViewStyle = UIAlertViewStyleSecureTextInput;
    
    [[alterView2 textFieldAtIndex:0]setPlaceholder:@"请输入支付密码"];
    [alterView2 show];

}


- (void)switchAction:(UISwitch *)myswitch{
    
    
 
        
        [NetService post:@"htz/isSetPayPwd.json" parameters:nil success:^(id responseObject) {
         
            if ([[responseObject objectForKey:@"status"] integerValue]==1) {
            
                alterView1 = [[UIAlertView alloc]initWithTitle:@"未设置支付密码" message:@"去设置？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
                [alterView1 show];
                
            }else if([[responseObject objectForKey:@"status"] integerValue]==2){
                BOOL mybool ;
                if (myswitch.on == NO) {
                    
                    mybool = NO;
                    
                    
                    
                }else if(myswitch.on == YES){
                    
                    mybool = YES;
                }else {
                    mybool =NO;
                    
                }
                [[NSUserDefaults standardUserDefaults]setBool:mybool forKey:@"mydefultType"];
            
            }
      
            
        } failure:^(NSString *error) {
           
            
            myswitch.on = NO;
        } netError:^(NSString *error) {
            myswitch.on = NO;
        }];
        
    
    
    
   
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView == alterView2) {
        if (buttonIndex==1) {
            
            
            
            UITextField *textfield = [alertView textFieldAtIndex:0];
            NSLog(@"%@",textfield.text);
            
           [textfield resignFirstResponder];
            
            
            if (textfield.text.length == 0) {
                
                return;
            }
            NSString *pw = textfield.text;
            
            
            
            
            
            
            
            
            
            NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
           
            [dic setObject:pw forKey:@"paypassword"];
            [NetService post:@"htz/isRightPayPwd.json" parameters:dic success:^(id responseObject) {
                [self loginFinsh:responseObject];
            } failure:^(NSString *error) {
                
            } netError:^(NSString *error) {
                
            }];
        }
        
    }else if (alertView == alterView1){
    
        if (buttonIndex == 0) {
            SetPayPassWordViewController *setpaypwVC = [[SetPayPassWordViewController alloc]init];
            [self.navigationController pushViewController:setpaypwVC animated:YES];
        }else if(buttonIndex == 1){
            UISwitch *myswitch = (UISwitch *)[self.view viewWithTag:106];
            myswitch.on = NO;
        
        }
        
    
    }



}


- (void)loginFinsh:(id)result{
    
    NSLog(@"数据：%@",result);
   NSString *str = [result objectForKey:@"status"];
    NSString *msg = [result objectForKey:@"validateMsg"];
  
    if ([str integerValue]== 1) {
        UIAlertView *myalterview1 = [[UIAlertView alloc]initWithTitle:msg message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [myalterview1 show];
       
        
     
    }else if([str integerValue]==2){
        UIAlertView *alterview = [[UIAlertView alloc]initWithTitle:msg message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [alterview show];
        [alterview dismissWithClickedButtonIndex:0 animated:YES];
        AppDelegate *ap = [UIApplication sharedApplication].delegate;
        
        [ap showLLLockViewController:LLLockViewTypeCreate];
    }else if([str integerValue]==3){
  
   
    }
    


}
- (void)back{

    [self.navigationController popViewControllerAnimated:YES];

}




@end
