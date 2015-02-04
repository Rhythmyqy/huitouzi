//
//  TXViewController.h
//  汇投资
//
//  Created by 杨青源 on 14/11/6.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import "BassViewController.h"
#import "NIDropDown.h"

@interface TXViewController : BassViewController<UITextFieldDelegate,UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *cashmoney;

@property (weak, nonatomic) IBOutlet UILabel *canUserMoneyLabel;

@property (weak, nonatomic) IBOutlet UILabel *getFreeMoney;
@property (weak, nonatomic) IBOutlet UILabel *handlingchargeLabel;

@property (weak, nonatomic) IBOutlet UILabel *popMoney;

@property (weak, nonatomic) IBOutlet UITextField *payPWTextField;
@property (weak, nonatomic) IBOutlet UIButton *netStepButton;
@property (weak, nonatomic) IBOutlet UITextView *detailTextView;


@property (weak, nonatomic) IBOutlet UIScrollView *myscrollView;

@end
