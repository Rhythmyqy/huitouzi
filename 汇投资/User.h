//
//  User.h
//  汇投资
//
//  Created by 杨青源 on 14/11/4.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject


//相关属性

+ (User *)shareInstance;

#pragma mark - 用户的相关方法
//注册
- (BOOL)registerWithName:(NSString *)name password:(NSString *)password;
//登录
- (BOOL)loginWithName:(NSString *)name password:(NSString *)password;
//是否登录
- (BOOL)isLogin;
@property (nonatomic,copy)NSString *userNa;
@property (nonatomic,copy)NSString *pw;

@end
