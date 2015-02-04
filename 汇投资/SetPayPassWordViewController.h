//
//  SetPayPassWordViewController.h
//  汇投资
//
//  Created by 杨青源 on 14/11/28.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import "BassViewController.h"

@interface SetPayPassWordViewController : BassViewController

@property (weak, nonatomic) IBOutlet UITextField *passWord;
@property (weak, nonatomic) IBOutlet UITextField *passWordConfim;
@property (weak, nonatomic) IBOutlet UIButton *passwordBurron;
- (IBAction)showPasswordAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *confirmPWButton;

- (IBAction)confirmPWShowAction:(id)sender;

- (IBAction)buttonAction:(id)sender;

@end
