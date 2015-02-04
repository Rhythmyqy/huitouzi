//
//  FastPayViewController.h
//  汇投资
//
//  Created by 杨青源 on 14/11/6.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import "BassViewController.h"
#import "NIDropDown.h"

@interface FastPayViewController : BassViewController<NIDropDownDelegate,UITextFieldDelegate,UIAlertViewDelegate>{
       NIDropDown *dropDown;
       UIButton *bankButton;
}

@property (weak, nonatomic) IBOutlet UIView *bankView;
@property (weak, nonatomic) IBOutlet UITextField *selectBankName;
@property (weak, nonatomic) IBOutlet UITextField *bankPhoneNum;
- (IBAction)getVerificationcode:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *codeNum;
@property (weak, nonatomic) IBOutlet UIView *bgBankView;
@property (weak, nonatomic) IBOutlet UIButton *ConfirmOpenAction;

@property(nonatomic,copy)NSString *user_id;
@property(nonatomic,copy)NSString *paycard;

- (IBAction)addCarAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *view;

@property (weak, nonatomic) IBOutlet UIView *phoneNum;
@property(nonatomic,weak)UITextField *textField;
@end
