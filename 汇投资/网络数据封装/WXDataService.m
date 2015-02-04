//
//  WXDataService.m
//  汇投资
//
//  Created by 杨青源 on 14-10-30.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import "WXDataService.h"

@implementation WXDataService


+ (AFHTTPRequestOperation *)requestWithURL:(NSString *)url
                                    params:(NSMutableDictionary *)params
                                httpMethod:(NSString *)httpMethod
                                     block:(CompletionLoad)block
                             requestHeader:(NSDictionary *)header
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    
    //添加请求头
    for (NSString *key in header.allKeys) {
        [request addValue:header[key] forHTTPHeaderField:key];
    }
    
    //get请求
    NSComparisonResult compResult1 =[httpMethod caseInsensitiveCompare:@"GET"];
    if (compResult1 == NSOrderedSame) {
        [request setHTTPMethod:@"GET"];
    
        //添加参数，将参数拼接在url后面
        NSMutableString *paramsString = [NSMutableString string];
        NSArray *allkeys = [params allKeys];
        for (NSString *key in allkeys) {
            NSString *value = [params objectForKey:key];
            
            [paramsString appendFormat:@"&%@=%@", key, value];
        }
        
        if (paramsString.length > 0) {
            //重新设置url
            [request setURL:[NSURL URLWithString:[url stringByAppendingString:paramsString]]];
           
        }
    }

    //post请求
    NSComparisonResult compResult2 =[httpMethod caseInsensitiveCompare:@"POST"];
    if (compResult2 == NSOrderedSame) {
        [request setHTTPMethod:@"POST"];
        
        //添加参数
        for (NSString *key in params) {
            id value = params[key];
            //如果参数无key，直接设置HTTPBody
            if ([value isKindOfClass:[NSData class]]) {
                [request setHTTPBody:value];
            }else{
                [request setValue:value forKey:key];
            }
        }
    }
    
    //发送请求
    AFHTTPRequestOperation *requstOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    //设置返回数据的解析方式
    requstOperation.responseSerializer = [AFJSONResponseSerializer serializer];
    [requstOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (block != nil) {
            block(responseObject);
        
            NSString *str= [[operation.response allHeaderFields] valueForKey:@"Set-Cookie"];
          
            if (str != nil && str.length >100) {
                 [[NSUserDefaults standardUserDefaults] setObject:str forKey:@"Cookie"];
            }
         
            
         
 
         
            
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", [error localizedDescription]);
        
        if (block != nil) {
            
          
        }
        
    }];
    [requstOperation start];
    
    return requstOperation;
}


+ (NSMutableURLRequest *)requestWithURL:(NSString *)url
                                params:(NSMutableDictionary *)params
                          requestHeader:(NSDictionary *)header
                            httpMethod:(NSString *)httpMethod
                                block:(CompletionLoad)block

{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    
    //添加请求头
    for (NSString *key in header.allKeys) {
        [request addValue:header[key] forHTTPHeaderField:key];
    }
    
    //get请求
    NSComparisonResult compResult1 =[httpMethod caseInsensitiveCompare:@"GET"];
    if (compResult1 == NSOrderedSame) {
        [request setHTTPMethod:@"GET"];
        
        //添加参数，将参数拼接在url后面
        NSMutableString *paramsString = [NSMutableString string];
        NSArray *allkeys = [params allKeys];
        for (NSString *key in allkeys) {
            NSString *value = [params objectForKey:key];
            
            [paramsString appendFormat:@"&%@=%@", key, value];
        }
        
        if (paramsString.length > 0) {
            //重新设置url
            [request setURL:[NSURL URLWithString:[url stringByAppendingString:paramsString]]];
        }
    }
    
    //post请求
    NSComparisonResult compResult2 =[httpMethod caseInsensitiveCompare:@"POST"];
    if (compResult2 == NSOrderedSame) {
        [request setHTTPMethod:@"POST"];
        
        //添加参数
        for (NSString *key in params) {
            id value = params[key];
            //如果参数无key，直接设置HTTPBody
            if ([value isKindOfClass:[NSData class]]) {
                [request setHTTPBody:value];
            }else{
                [request setValue:value forKey:key];
            }
        }
    }
    
    //发送请求
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            NSLog(@"error:%@", connectionError);
            if (block != nil) {
                block(connectionError);
            }
        }else{
            if (block != nil) {
                id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:NULL];
                block(result);
            }
        }
    }];
    
    return request;
}



@end
