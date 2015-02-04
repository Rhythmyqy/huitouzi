//
//  KKBProgressHub.m
//  learn
//
//  Created by zengmiao on 10/28/14.
//  Copyright (c) 2014 kaikeba. All rights reserved.
//

#import "KKBProgressHUB.h"
#import "UIColor+FlatUI.h"
//#import "Common.h"

const float hubCornerRadius = 4.0f;
const float hubHideDelayTime = 2.0f;
const float hubTextFontSize = 14.0f;

@implementation KKBProgressHUB

#pragma mark 显示信息
+ (void)show:(NSString *)text
        icon:(NSString *)icon
        view:(UIView *)view
     andStye:(LoadingActivityType)type {

    if (view == nil)
        view = [UIApplication sharedApplication].keyWindow;

    //先取消view中所有的hub 防止重复添加
    [MBProgressHUD hideAllHUDsForView:view animated:NO];

    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelFont = [UIFont systemFontOfSize:hubTextFontSize];

    hud.cornerRadius = hubCornerRadius;
    hud.labelText = text;
    // 设置图片
    hud.customView =
        [[UIImageView alloc] initWithImage:[UIImage imageNamed:icon]];

    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;

    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;

    if (type == IndicatorWhite) {
        hud.dimBackground = YES;
//        hud.color = [UIColor kkb_colorwithHexString:@"ffffff" alpha:0.95];
        hud.color = [UIColor colorFromHexCode:@"ffffff"];
        hud.labelColor = [UIColor colorFromHexCode:@"333333"];
//        hud.labelColor = [UIColor kkb_colorwithHexString:@"333333" alpha:1];
        
        hud.activityIndicatorColor = [UIColor grayColor];
    }

    // 之后再消失
    [hud hide:YES afterDelay:hubHideDelayTime];
}

+ (void)showSuccessHubWithMessage:(NSString *)message toView:(UIView *)view {
    [[self class] show:message
                  icon:@"hub_success"
                  view:view
               andStye:IndicatorBlack];
}

+ (void)showFailureHubWithMessage:(NSString *)message toView:(UIView *)view {
    [[self class] show:message
                  icon:@"hub_loading_failure"
                  view:view
               andStye:IndicatorWhite];
}

+ (void)showMessageHubWithMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil)
        view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD HUDForView:view];

    if (!hud) {
        hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    }
    hud.labelFont = [UIFont systemFontOfSize:hubTextFontSize];

    hud.cornerRadius = hubCornerRadius;
    hud.dimBackground = YES;
//    hud.color = [UIColor kkb_colorwithHexString:@"ffffff" alpha:0.95];
//    hud.labelColor = [UIColor kkb_colorwithHexString:@"333333" alpha:1];
    hud.color = [UIColor colorFromHexCode:@"ffffff"];
    hud.labelColor = [UIColor colorFromHexCode:@"333333"];
    hud.labelText = message;

    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;

    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;

    // 之后再消失
    [hud hide:YES afterDelay:hubHideDelayTime];
}

+ (void)showLoadingHubWithType:(LoadingActivityType)type toView:(UIView *)view {
    [[self class] showLoadingHubWithType:type
                                  toView:view
                    allowUserInteraction:YES];
}

+ (void)showLoadingHubWithType:(LoadingActivityType)type
                        toView:(UIView *)view
          allowUserInteraction:(BOOL)allow {

    [[self class] showLoadingHubWithType:type
                                  toView:view
                    allowUserInteraction:allow
                             showMessage:@"加载中..."];
}

+ (void)showLoadingHubWithType:(LoadingActivityType)type
                        toView:(UIView *)view
          allowUserInteraction:(BOOL)allow
                   showMessage:(NSString *)message {
    if (view == nil)
        view = [UIApplication sharedApplication].keyWindow;
    //先取消view中所有的hub 防止重复添加
    [MBProgressHUD hideAllHUDsForView:view animated:NO];

    MBProgressHUD *hub = [[MBProgressHUD alloc] initWithView:view];
    hub.cornerRadius = hubCornerRadius;
    hub.userInteractionEnabled = !allow;
    hub.labelFont = [UIFont systemFontOfSize:hubTextFontSize];

    hub.labelText = message;
    hub.square = YES;
    hub.removeFromSuperViewOnHide = YES;

    if (type == IndicatorWhite) {
        hub.dimBackground = YES;
//        hub.color = [UIColor kkb_colorwithHexString:@"ffffff" alpha:0.95];
//        hub.labelColor = [UIColor kkb_colorwithHexString:@"333333" alpha:1];
        hub.color = [UIColor colorFromHexCode:@"ffffff"];
        hub.labelColor = [UIColor colorFromHexCode:@"333333"];
        hub.activityIndicatorColor = [UIColor grayColor];
    }

    [view addSubview:hub];
    [view bringSubviewToFront:hub];
    [hub show:YES];
}

+ (void)showLoadingHubWithType:(LoadingActivityType)type
                        toView:(UIView *)view
                     edgeInset:(UIEdgeInsets)edgeInset {
    if (view == nil)
        view = [UIApplication sharedApplication].keyWindow;
    //先取消view中所有的hub 防止重复添加
    [MBProgressHUD hideAllHUDsForView:view animated:NO];
    CGRect frame =
        CGRectMake(view.bounds.origin.x - edgeInset.left,
                   view.bounds.origin.y - edgeInset.top,
                   view.bounds.size.width - edgeInset.left - edgeInset.right,
                   view.bounds.size.height - edgeInset.top - edgeInset.bottom);

    MBProgressHUD *hub = [[MBProgressHUD alloc] initWithFrame:frame];
    hub.cornerRadius = hubCornerRadius;
    hub.labelFont = [UIFont systemFontOfSize:hubTextFontSize];

    hub.labelText = @"加载中...";
    hub.square = YES;
    hub.removeFromSuperViewOnHide = YES;

    if (type == IndicatorWhite) {
        hub.dimBackground = YES;
//        hub.color = [UIColor kkb_colorwithHexString:@"ffffff" alpha:0.95];
//        hub.labelColor = [UIColor kkb_colorwithHexString:@"333333" alpha:1];
        hub.color = [UIColor colorFromHexCode:@"ffffff"];
        hub.labelColor = [UIColor colorFromHexCode:@"333333"];
        hub.activityIndicatorColor = [UIColor grayColor];
    }

    [view addSubview:hub];
    [view bringSubviewToFront:hub];
    [hub show:YES];
}

+ (void)hideLoadingHubInView:(UIView *)view {
    if (view == nil)
        view = [UIApplication sharedApplication].keyWindow;

    [MBProgressHUD hideAllHUDsForView:view animated:YES];
}
@end
