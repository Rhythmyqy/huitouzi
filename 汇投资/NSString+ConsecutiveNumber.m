//
//  NSString+ConsecutiveNumber.m
//  03-MapKit的使用
//
//  Created by CHENYI LONG on 14-11-23.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "NSString+ConsecutiveNumber.h"

@implementation NSString (ConsecutiveNumber)
-(BOOL)checkConsecutiveIncrementalNumber:(int)ConsecutiveCount{
    NSString *consecutiveIncrementalNumber = [NSString stringWithFormat:@".*\\d{%d,}.*",ConsecutiveCount];
    // 谓词是用来评估（判断）对象中是否符合某一个条件的
    // 1. 在实例化谓词的同时制定条件
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",consecutiveIncrementalNumber];
    // 2. 开始评估判断
    BOOL isConsecutiveIncrementalNumber = [predicate evaluateWithObject:self];
    
    if (isConsecutiveIncrementalNumber) {
        return YES;
    } else {
        return NO;
    }
}
@end
