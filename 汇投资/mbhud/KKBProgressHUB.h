//
//  KKBProgressHub.h
//  learn
//
//  Created by zengmiao on 10/28/14.
//  Copyright (c) 2014 kaikeba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

typedef NS_ENUM(NSInteger, LoadingActivityType) {
    IndicatorWhite = 0,
    IndicatorBlack
};

@interface KKBProgressHUB : NSObject

/**
 *  成功Hub hub中带一张小勾的图片 默认 2s自动隐藏 调用者无需手动添加隐藏逻辑
 *
 *  @param message message description
 *  @param view    需要将hub加载到那个view上面 如果为nil 则默认加载到keywindow上
                    一般view 为viewcontroller.view 或者NavigationController.view
 */
+ (void)showSuccessHubWithMessage:(NSString *)message toView:(UIView *)view;

/**
 *  失败Hub hub中带一张哭脸的图片 默认 2s自动隐藏 调用者无需手动添加隐藏逻辑
 *
 *  @param message message description
 *  @param view    需要将hub加载到那个view上面 如果为nil 则默认加载到keywindow上
 一般view 为viewcontroller.view 或者NavigationController.view
 */
+ (void)showFailureHubWithMessage:(NSString *)message toView:(UIView *)view;

/**
 *  message Hub  默认 2s自动隐藏 调用者无需手动添加隐藏逻辑
 *
 *  @param message message description
 *  @param view     需要将hub加载到那个view上面 如果为nil
 则默认加载到keywindow上
                    一般view 为viewcontroller.view 或者NavigationController.view
 */
+ (void)showMessageHubWithMessage:(NSString *)message toView:(UIView *)view;

/**
 *  show loading hub
 *
 *  @param type type description
 *  @param view 需要将hub加载到那个view上面 如果为nil 则默认加载到keywindow上
        一般view 为viewcontroller.view 或者NavigationController.view
 */
+ (void)showLoadingHubWithType:(LoadingActivityType)type toView:(UIView *)view;

+ (void)showLoadingHubWithType:(LoadingActivityType)type
                        toView:(UIView *)view
          allowUserInteraction:(BOOL)allow;

+ (void)showLoadingHubWithType:(LoadingActivityType)type
                        toView:(UIView *)view
          allowUserInteraction:(BOOL)allow
                   showMessage:(NSString *)message;

//暂未用到
+ (void)showLoadingHubWithType:(LoadingActivityType)type
                        toView:(UIView *)view
                     edgeInset:(UIEdgeInsets)edgeInset;
/**
 *  hide views hub
 *
 *  @param view 需要将hub加载到那个view上面 如果为nil 则默认加载到keywindow上
                一般view 为viewcontroller.view 或者NavigationController.view
 */
+ (void)hideLoadingHubInView:(UIView *)view;

@end
