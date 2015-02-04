//
//  Common.h
//  yqy_wxweibo
//
//  Created by wxhl23 on 14-9-15.
//  Copyright (c) 2014年 wxhl23. All rights reserved.
//

#ifndef yqy_wxweibo_Common_h
#define yqy_wxweibo_Common_h


//获取屏幕的尺寸
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

//判断是否是ios7

#define iOS7 ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)

//tabbar的坐标

#define KScreenContentHeight (iOS7 ? (kScreenHeight - 49) : (kScreenHeight-49-20))

#endif
