//
//  SafeViewController.h
//  汇投资
//
//  Created by 杨青源 on 14-10-31.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BassViewController.h"
@interface SafeViewController : BassViewController<UITableViewDataSource,UITableViewDelegate>{


    
    __weak IBOutlet UITableView *_tableView;

}

@property(nonatomic,strong)NSMutableDictionary *data;
@end
