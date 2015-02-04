//
//  XtxxCell.m
//  汇投资
//
//  Created by wcf on 14/11/19.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import "XtxxCell.h"
@implementation XtxxCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}
/*
 "fromname" : "汇投资",
 "status" : 1,
 "title" : "恭喜您成功充值0.01元",
 "uid" : 1551,
 "mid" : 15227,
 "sendtime" : "2014-10-17 15:52:15"
 */
- (void)setXtxxModel:(XtxxModel *)xtxxModel
{
    if (_xtxxModel!=xtxxModel) {
        _xtxxModel=xtxxModel;
        self.title.text=_xtxxModel.title;
        self.sendtime.text=_xtxxModel.sendtime;
    }
}
@end
