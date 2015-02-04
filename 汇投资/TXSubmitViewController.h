//
//  TXSubmitViewController.h
//  汇投资
//
//  Created by wcf on 14/11/20.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import "BassViewController.h"

@interface TXSubmitViewController : BassViewController<UIWebViewDelegate>
{
    UIWebView *_webView;
}

@property(nonatomic,copy)NSString *cashmoney;
@property(nonatomic,copy)NSString *cashbankId;
@property(nonatomic,copy)NSString *paypassword;
@end
