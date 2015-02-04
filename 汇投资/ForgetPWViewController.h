//
//  ForgetPWViewController.h
//  汇投资
//
//  Created by 杨青源 on 14/11/12.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import "BassViewController.h"

@interface ForgetPWViewController : BassViewController<UITextFieldDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneNumText;
@property (weak, nonatomic) IBOutlet UITextField *codeText;
- (IBAction)getCodeAction:(id)sender;
- (IBAction)changPWAction:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *codeTimeLabel;
@property(nonatomic,weak)UITextField *textField;
@property(nonatomic,copy)NSString *phonecode;

@property (strong, nonatomic) UIButton *button;
@property (strong, nonatomic) NSTimer *timer;
@property (weak, nonatomic) IBOutlet UIButton *getCodeButton;

@end
