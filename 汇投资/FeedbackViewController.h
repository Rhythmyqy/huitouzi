//
//  FeedbackViewController.h
//  汇投资
//
//  Created by 杨青源 on 14/11/6.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import "BassViewController.h"

@interface FeedbackViewController : BassViewController<UITextViewDelegate,UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;


- (IBAction)Submit;

@end
