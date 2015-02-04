//
//  LicaiNowInvestViewController.h
//  汇投资
//
//  Created by 杨青源 on 14/11/25.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import "BassViewController.h"
#import "NIDropDown.h"

@interface LicaiNowInvestViewController : BassViewController<UITextFieldDelegate,NIDropDownDelegate>{

    UIButton *bankButton;
    NIDropDown *dropDown;

}

@property (weak, nonatomic) IBOutlet UIView *quanListView;

@property (weak, nonatomic) IBOutlet UILabel *csTypeLabel;

@property (weak, nonatomic) IBOutlet UIButton *payButton;
@property (weak, nonatomic) IBOutlet UILabel *canUseMoney;
@property (weak, nonatomic) IBOutlet UILabel *canPushMony;
@property (weak, nonatomic) IBOutlet UITextField *pushMoney;
@property (weak, nonatomic) IBOutlet UILabel *CSLabel;
@property (nonatomic,copy)NSString *codeID;
@property (weak, nonatomic) IBOutlet UIView *pushmoneyView;

@property (weak, nonatomic) IBOutlet UIView *paypasswordView;



@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
- (IBAction)payAction:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIView *csQuanView;
@property (strong,nonatomic)NSArray *quanList;
@property (copy,nonatomic)NSString *urlStr;
@property (copy,nonatomic)NSString *csBi;
@property (copy,nonatomic)NSString *csQuan;

@property(copy,nonatomic)NSString *projectID;

@property (strong,nonatomic)NSMutableDictionary *csqShowdic;

@end
