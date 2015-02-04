//
//  RegistrationViewController.h
//  汇投资
//
//  Created by 杨青源 on 14/11/7.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import "BassViewController.h"
#import "UserModel.h"
#import "NSString+ConsecutiveNumber.h"

@interface RegistrationViewController : BassViewController<UITextFieldDelegate,UIAlertViewDelegate>

- (IBAction)registrationAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *userNameText;
@property (weak, nonatomic) IBOutlet UILabel *codeTimerlabel;
@property (weak, nonatomic) IBOutlet UITextField *passWordText;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumText;
@property (weak, nonatomic) IBOutlet UITextField *idenCodeText;
@property(nonatomic,strong)UserModel *userModel;
@property(nonatomic,strong)NSTimer *timer;
@property (weak, nonatomic) IBOutlet UIButton *getCodeNumButton;

- (IBAction)getIdenCodeAction:(id)sender;
@property(nonatomic,weak)UITextField *textField;
@end
