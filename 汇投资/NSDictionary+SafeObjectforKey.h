//
//  NSDictionary+SafeObjectforKey.h
//  汇投资
//
//  Created by 杨青源 on 14/11/15.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#define checkNULL(__X__)  (__X__) ==[NSNull null] || (__X__) ==nil ? @"" :[NSString stringWithFormat:@"%@",(__X__)]
#import <Foundation/Foundation.h>

@interface NSDictionary (SafeObjectforKey)

- (NSString *)safeObjectforKey:(id)key;

@end
