//
//  XtxxModel.h
//  汇投资
//
//  Created by wcf on 14/11/19.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import "WXBaseModel.h"

@interface XtxxModel : WXBaseModel
/*
 "fromname" : "汇投资",
 "status" : 1,
 "title" : "恭喜您成功充值1元",
 "uid" : 1551,
 "mid" : 16077,
 "sendtime" : "2014-11-04 11:52:49"
 */
@property(nonatomic,copy)NSString *fromname;
@property(nonatomic,assign)NSNumber *status;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,strong)NSNumber *uid;
@property(nonatomic,strong)NSNumber *mid;
@property(nonatomic,copy)NSString *sendtime;
@end
