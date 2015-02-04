//
//  RechargeViewController.h
//  汇投资
//
//  Created by 杨青源 on 14/11/24.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import "BassViewController.h"
#import "NIDropDown.h"

@interface RechargeViewController : BassViewController<NIDropDownDelegate,UITextFieldDelegate,UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *rechargeNum;
- (IBAction)confirmRecharge:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *ownBankCarView;
@property (weak, nonatomic) IBOutlet UIView *userNewCarView;
- (IBAction)useNewCarAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *mycarView;
@property (weak, nonatomic) IBOutlet UIView *myMoneyView;
@property (weak, nonatomic) IBOutlet UIButton *addcarButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@end
