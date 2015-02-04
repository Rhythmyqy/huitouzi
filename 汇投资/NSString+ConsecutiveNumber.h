//
//  NSString+ConsecutiveNumber.h
//  03-MapKit的使用
//
//  Created by CHENYI LONG on 14-11-23.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ConsecutiveNumber)
/**
 *  搜索字符串中是否包含有N以上的连续的数字
 *  如当ConsecutiveCount为3时,a12b123这个字符串返回YES
 *  @param ConsecutiveCount 连续数字的最小数量
 *
 *  @return 如果包含返回YES,不包含返回NO
 */
-(BOOL)checkConsecutiveIncrementalNumber:(int)ConsecutiveCount;

@end
