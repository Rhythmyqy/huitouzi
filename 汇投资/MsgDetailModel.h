//
//  MsgDetailModel.h
//  汇投资
//
//  Created by wcf on 14/11/19.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import "WXBaseModel.h"

@interface MsgDetailModel : WXBaseModel
/*
 
 "status" : 1,
 "content" : "亲爱的平家的美,\"Zsm测试项目11111111111,24个月\"已上线！融资金额为：1000万元,年化收益为null%~null%,项目地址：http:\/\/www.huitouzi.com\/project\/detail\/45 期待您的加入,祝您投资愉快！",
 "uid" : 1551,
 "mid" : 10588,
 "fromname" : "汇投资",
 "title" : "Zsm测试11111111111项目上线通知",
 "sendtime" : "2014-07-29 17:53:06"
 */
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *sendtime;
@property(nonatomic,copy)NSString *content;
@property(nonatomic,assign)NSNumber *mid;
@end
