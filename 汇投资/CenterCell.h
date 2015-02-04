//
//  CenterCell.h
//  汇投资
//
//  Created by 杨青源 on 14-10-31.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"

@interface CenterCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong,nonatomic)NSString *imagName;
@property(strong,nonatomic)UserModel *userModel;

@end
