//
//  LoginViewController.h
//  汇投资
//
//  Created by 杨青源 on 14/11/4.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BassViewController.h"
#import "STAlertView.h"
#import "UserModel.h"
#import "NSString+ConsecutiveNumber.h"

@interface LoginViewController : BassViewController<UITextFieldDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *pwTextView;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIView *bgView;
- (IBAction)loginAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *UserNameText;
@property(strong,nonatomic) STAlertView *stAlertView;
@property(nonatomic,assign)BOOL isGust;
@property(nonatomic,assign)BOOL ismyCount;
@property(nonatomic,assign)BOOL isback;
@property(nonatomic,assign)BOOL isOtherVC;
- (IBAction)forgetPWAction:(id)sender;

@property(nonatomic,weak)UITextField *textField;

@property(nonatomic,strong)UserModel *userModel;

-(IBAction)textFieldDoneEditing:(id)sender;



- (IBAction)qqLoginAction:(id)sender;


- (IBAction)weiboLoginAction:(id)sender;




@end
