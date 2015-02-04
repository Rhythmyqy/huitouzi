//
//  LLLockConfig.h
//  LockSample
//
//  Created by Lixin on 14/11/20.
//  Copyright (c) 2014年 Lixin. All rights reserved.
//

#import <Foundation/Foundation.h>

//#define LLDEBUG
#ifdef LLDEBUG
#define LLLog(format, ...) NSLog(format, ## __VA_ARGS__)
#else
#define LLLog(format, ...)
#endif
