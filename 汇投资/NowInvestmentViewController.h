//
//  NowInvestmentViewController.h
//  汇投资
//
//  Created by 杨青源 on 14/11/18.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import "BassViewController.h"
#import "QCheckBox.h"
#import "MBProgressHUD.h"

@interface NowInvestmentViewController : BassViewController<UITextFieldDelegate,QCheckBoxDelegate,UIAlertViewDelegate,MBProgressHUDDelegate>
@property (weak, nonatomic) IBOutlet UILabel *canUseMoney;

@property (weak, nonatomic) IBOutlet UILabel *canPushMoney;
@property (weak, nonatomic) IBOutlet UITextField *pushNum;
@property (weak, nonatomic) IBOutlet UILabel *mayGetMoney;
@property (weak, nonatomic) IBOutlet UILabel *mastPayMoney;
@property (weak, nonatomic) IBOutlet UITextField *payPassword;
@property (copy,nonatomic)NSString *projectID;
- (IBAction)payAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *payButton;
@property (copy,nonatomic)NSString *geturl;



@property (weak, nonatomic) IBOutlet UILabel *monyStatus;
@end
