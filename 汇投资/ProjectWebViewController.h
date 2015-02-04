//
//  ProjectWebViewController.h
//  汇投资
//
//  Created by 杨青源 on 14/11/17.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BassViewController.h"
#import "HomeModel.h"

@interface ProjectWebViewController : BassViewController<UIWebViewDelegate,UIAlertViewDelegate>

@property (nonatomic,strong)UIWebView *webView;
@property (nonatomic,copy)NSString *userId;
@property (nonatomic,copy)NSString *projectID;
@property (nonatomic,strong)NSMutableArray *photoModels;
@property (strong,nonatomic)HomeModel *homeModel;
@end
