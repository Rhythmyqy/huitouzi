//
//  RealAuthViewController.h
//  汇投资
//
//  Created by 杨青源 on 14/11/4.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import "BassViewController.h"
#import "UserModel.h"

@interface RealAuthViewController : BassViewController<UITextFieldDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *RealNameText;
@property (weak, nonatomic) IBOutlet UITextField *idCarText;
- (IBAction)authAction:(id)sender;

@property(nonatomic,strong)UserModel *userModel;
@property(nonatomic,weak)UITextField *textField;
@end
