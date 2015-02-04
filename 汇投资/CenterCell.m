//
//  CenterCell.m
//  汇投资
//
//  Created by 杨青源 on 14-10-31.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import "CenterCell.h"
#import "UIColor+FlatUI.h"


@implementation CenterCell

- (void)awakeFromNib {
        
  
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}


- (void)setImagName:(NSString *)imagName{

    if (_imagName != imagName) {
        _imagName = imagName;
        self.img.image = [UIImage imageNamed:_imagName];
    }
   

}

@end
