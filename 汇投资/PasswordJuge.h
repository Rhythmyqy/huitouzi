//
//  PasswordJuge.h
//  汇投资
//
//  Created by 杨青源 on 14/11/21.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PasswordJuge : NSObject
+ (NSString*) judgePasswordStrength:(NSString*) _password;
@end
