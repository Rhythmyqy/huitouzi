//
//  FastPayCarWebViewController.h
//  汇投资
//
//  Created by 杨青源 on 14/11/19.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import "BassViewController.h"

@interface FastPayCarWebViewController : BassViewController<UIWebViewDelegate>
{
    UIWebView *_webView;
}

@property(nonatomic,copy)NSString *user_id;
@property(nonatomic,copy)NSString *paycard;

@end
