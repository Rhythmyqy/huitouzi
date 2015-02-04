//  汇投资
//  NIDropDown.h
//  NIDropDown
//

//  Created by 杨青源 on 14/11/6.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NIDropDown;
@protocol NIDropDownDelegate
- (void) niDropDownDelegateMethod: (NIDropDown *) sender;
@end 

@interface NIDropDown : UIView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) id <NIDropDownDelegate> delegate;
@property(nonatomic,strong)UITableViewCell *cell;

-(void)hideDropDown:(UIButton *)b;
- (id)showDropDown:(UIButton *)b:(CGFloat *)height:(NSArray *)arr;

@end
