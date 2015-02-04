//
//  AuthViewController.h
//  汇投资
//
//  Created by 杨青源 on 14/12/29.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import "BassViewController.h"

@interface AuthViewController : BassViewController
@property(nonatomic,copy)NSString *uuid;
@property(nonatomic,copy)NSString *authType;
@property (weak, nonatomic) IBOutlet UITextField *passWordTextField;
@property (weak, nonatomic) IBOutlet UITextField *rePasswordTextField;

@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *codeNum;
- (IBAction)getCodeButtonAction:(id)sender;
- (IBAction)rigisAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UIButton *getCodeButton;
@property(nonatomic,strong)NSTimer *timer;

@end
