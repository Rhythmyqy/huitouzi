//
//  UserModel.h
//  汇投资
//
//  Created by 杨青源 on 14/11/3.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import "WXBaseModel.h"

@interface UserModel : WXBaseModel


/*
 
 {
 "msg" : "",
 "data" : {
 "reward_money" : "60.00",
 "phone" : "18614087813",
 "sex" : 2,
 "has_payment_pwd" : 2,
 "available_money" : "20018670.89",
 "emailactivestatus" : 2,
 "pic" : "\/resource\/images\/user_icon.png",
 "user_id" : 1397,
 "is_realname" : 1,
 "username" : "guo",
 "num_of_coupon" : 0,
 "lastlogin_time" : "2014-11-03 15:10:00",
 "email" : "",
 "name" : "",
 "phoneactivestatus" : 2
 },
 "code" : "0000"
 }
 
 */
@property(copy,nonatomic)NSString *username;//用户名
@property(strong,nonatomic)NSNumber *phoneactivestatus;//手机认证状态（1未认证，2已认证）
@property(strong,nonatomic)NSNumber *emailactivestatus;//邮箱认证状态
@property(strong,nonatomic)NSNumber *is_realname;//实名认证状态
@property(strong,nonatomic)NSNumber *has_payment_pwd;//设置支付密码
@property(copy,nonatomic)NSString *pic;//用户头像
@property(nonatomic,copy)NSString *code;               //判断是否登录成功；
@end





