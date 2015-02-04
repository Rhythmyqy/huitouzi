//
//  WXDataService.m
//  汇投资
//
//  Created by 杨青源 on 14-10-30.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void(^CompletionLoad)(id result);

@interface WXDataService : NSObject



//演示抓包：AFNetworking
+ (AFHTTPRequestOperation *)requestWithURL:(NSString *)url
                                    params:(NSMutableDictionary *)params
                                httpMethod:(NSString *)httpMethod
                                     block:(CompletionLoad)block
                             requestHeader:(NSDictionary *)header;

//演示抓包：系统自带类库
+ (NSMutableURLRequest *)requestWithURL:(NSString *)url
                                 params:(NSMutableDictionary *)params
                          requestHeader:(NSDictionary *)header
                             httpMethod:(NSString *)httpMethod
                                  block:(CompletionLoad)block;

@end
