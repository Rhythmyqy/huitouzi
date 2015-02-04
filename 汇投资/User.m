//
//  User.m
//  汇投资
//
//  Created by 杨青源 on 14/11/4.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import "User.h"
#import "LeftViewController.h"
#import "WXDataService.h"

static User *instance = nil;

@implementation User



#pragma mark - 实现单例
+ (User *)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[User alloc] init];
    });
    return instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}

#pragma mark - 用户的相关方法
#pragma mark 注册
- (BOOL)registerWithName:(NSString *)name password:(NSString *)password
{
    
    
    NSString *url = @"http://app.huitouzi.com/htzApp/app/free/login.json?";
    
    NSMutableDictionary *mDic = [[NSMutableDictionary alloc]init];
    
    [mDic setObject:name forKey:@"account"];
    [mDic setObject:password forKey:@"password"];
    [WXDataService requestWithURL:url
                           params:mDic
                       httpMethod:@"GET"
                            block:^(id result) {
                                
                                
                                
                                
                            } requestHeader:nil];
    return true;
    
}



#pragma mark 登录
- (BOOL)loginWithName:(NSString *)name password:(NSString *)password
{
    
  
    return true;
   
    
    
    
}

#pragma mark 是否登录
- (BOOL)isLogin
{
    return true;
}

@end
