//
//  ChangePWViewController.h
//  汇投资
//
//  Created by 杨青源 on 14/11/4.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import "BassViewController.h"
#import "UserModel.h"

@interface ChangePWViewController : BassViewController<UIAlertViewDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *oldPassWordText;
@property (weak, nonatomic) IBOutlet UITextField *setNewPWText;
@property (weak, nonatomic) IBOutlet UITextField *confirmPassWordText;
@property (weak, nonatomic) IBOutlet UIView *myBGView;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;

@property (assign,nonatomic)BOOL passWordType;
@property (weak, nonatomic) IBOutlet UILabel *weakPassword;
@property (weak, nonatomic) IBOutlet UILabel *normelPassword;
@property (weak, nonatomic) IBOutlet UILabel *strongPassword;

- (IBAction)confirmChangeAction:(id)sender;

@property(nonatomic,strong)UserModel *userModel;
@property(nonatomic,weak)UITextField *textField;

@property (weak, nonatomic) IBOutlet UIButton *oldPwButton;
@property (weak, nonatomic) IBOutlet UIButton *setNewButton;
@property (weak, nonatomic) IBOutlet UIButton *confirmPWButton;

- (IBAction)showOldPWAction:(id)sender;

- (IBAction)showSetPWAction:(id)sender;

- (IBAction)showConfirmPWAction:(id)sender;


@end
