//
//  AppDelegate.h
//  汇投资
//
//  Created by 杨青源 on 14-10-30.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMDrawerController.h"
#import "BassNavigationViewController.h"
#import "LLLockViewController.h"

#define SUPPORT_IOS8 0

@interface AppDelegate : UIResponder <UIApplicationDelegate>{

    BassNavigationViewController *navCtrl;
   

}

// 手势解锁相关
@property (strong, nonatomic) LLLockViewController* lockVc; // 添加解锁界面
- (void)showLLLockViewController:(LLLockViewType)type;

@property (strong, nonatomic) UIWindow *window;

@property (readonly, nonatomic)MMDrawerController *mmViewCtrl;
@property(strong,nonatomic)BassNavigationViewController *baseNav;
@property (strong, nonatomic) NSMutableArray *viewCtrlArray;
@property (assign,nonatomic)BOOL isCenter;
@end

