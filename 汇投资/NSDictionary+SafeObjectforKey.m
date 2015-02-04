//
//  NSDictionary+SafeObjectforKey.m
//  汇投资
//
//  Created by 杨青源 on 14/11/15.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import "NSDictionary+SafeObjectforKey.h"

@implementation NSDictionary (SafeObjectforKey)

- (NSString *)safeObjectforKey:(id)key{


    return checkNULL([self objectForKey:key]);

}

@end
