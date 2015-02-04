//
//  PayPWViewController.h
//  汇投资
//
//  Created by wcf on 14/11/25.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import "BassViewController.h"
#import "UserModel.h"

@interface PayPWViewController : BassViewController<UIAlertViewDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *oldPassWordText;
@property (weak, nonatomic) IBOutlet UITextField *setNewPWText;
@property (weak, nonatomic) IBOutlet UITextField *confirmPassWordText;
@property (weak, nonatomic) IBOutlet UIView *myview;

@property (assign,nonatomic)BOOL passWordType;
@property (weak, nonatomic) IBOutlet UILabel *weakPassword;
@property (weak, nonatomic) IBOutlet UILabel *normelPassword;
@property (weak, nonatomic) IBOutlet UILabel *strongPassword;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

- (IBAction)confirmChangeAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;

@property(nonatomic,strong)UserModel *userModel;
@property(nonatomic,weak)UITextField *textField;

@end
