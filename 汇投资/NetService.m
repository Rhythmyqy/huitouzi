//
//  NetService.m
//  汇投资
//
//  Created by fish on 14/12/2.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import "NetService.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
@implementation NetService

+(void)post:(NSString *)url
                      parameters:(id)parameters
                        success:(void (^)(id responseObject))success
                        failure:(void (^)(NSString *error))failure
                        netError:(void (^)(NSString *error))netError
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
//    //添加请求头
    NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"Cookie"];
    [manager.requestSerializer setValue:str forHTTPHeaderField:@"Cookie"];
    
    [manager POST:[SERVER_URL stringByAppendingString:url] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
//        NSLog(@"json:%@",[responseObject objectForKey:@"code"]);
        NSString *code = [responseObject objectForKey:@"code"];
        NSString *message = [responseObject objectForKey:@"msg"];
        if ( [code intValue] == 2000 ||[code integerValue] == 2001) {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:message message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
            failure(nil);
        }else if ([code intValue] == 0000){
            id data = [responseObject objectForKey:@"data"];
            NSString *str= [[operation.response allHeaderFields] valueForKey:@"Set-Cookie"];
            if (str != nil && str.length >100) {
                [[NSUserDefaults standardUserDefaults] setObject:str forKey:@"Cookie"];
            }
            success(data);
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"网络异常,请稍候重试" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        netError(nil);
    }];
}
@end
