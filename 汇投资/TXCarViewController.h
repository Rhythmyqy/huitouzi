//
//  TXCarViewController.h
//  汇投资
//
//  Created by 杨青源 on 14/11/6.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import "BassViewController.h"
#import "NIDropDown.h"
#import "HZAreaPickerView.h"


@interface TXCarViewController : BassViewController<NIDropDownDelegate,UITextFieldDelegate>{
    
    NIDropDown *dropDown;
    
    UIButton *bankButton1;
    UIButton *bankButton2;
  
}
@property (weak, nonatomic) IBOutlet UITextField *bankNumtext;
- (IBAction)getCodeNum:(id)sender;
@property(nonatomic,strong)UIButton *bankButton;
@property (weak, nonatomic) IBOutlet UIView *bankView;
@property (weak, nonatomic) IBOutlet UIView *cityView;
@property (weak, nonatomic) IBOutlet UITextField *codeNumText;
@property (weak, nonatomic) IBOutlet UILabel *codeTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *getCodeNumButton;
@property (nonatomic,copy)NSString *bankNameStr;
@property (strong,nonatomic)NSTimer *timer;
- (IBAction)addCarAction:(id)sender;


@property (strong, nonatomic) HZAreaPickerView *locatePicker;

@end
