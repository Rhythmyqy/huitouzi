//
//  SetPasswordViewController.h
//  汇投资
//
//  Created by 杨青源 on 14/11/18.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import "BassViewController.h"

@interface SetPasswordViewController : BassViewController<UITextFieldDelegate,UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *passWordText;
@property (weak, nonatomic) IBOutlet UITextField *confirmPWText;

@property (copy,nonatomic)NSString *phone;

@property (assign,nonatomic)BOOL passWordType;

@property (weak, nonatomic) IBOutlet UILabel *weakPassword;
@property (weak, nonatomic) IBOutlet UILabel *normelPassword;
@property (weak, nonatomic) IBOutlet UILabel *strongPassword;

@property(nonatomic,weak)UITextField *textField;
- (IBAction)setAction:(id)sender;

@end
