//
//  NetService.h
//  汇投资
//
//  Created by fish on 14/12/2.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import <Foundation/Foundation.h>
//http://115.29.138.151:9180/htzApp/app/
//http://app.huitouzi.com/htzApp/app/
#define SERVER_URL @"http://app.huitouzi.com/htzApp/app/"

@interface NetService : NSObject


+(void)post:(NSString *)url
    parameters:(id)parameters
    success:(void (^)(id responseObject))success
    failure:(void (^)(NSString *error))failure
    netError:(void (^)(NSString *error))netError;

@end
