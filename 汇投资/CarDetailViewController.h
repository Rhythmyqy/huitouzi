//
//  CarDetailViewController.h
//  汇投资
//
//  Created by 杨青源 on 14/11/10.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import "BassViewController.h"

@interface CarDetailViewController : BassViewController<UITableViewDataSource,UITableViewDelegate>
- (IBAction)addFastCarAction:(id)sender;
- (IBAction)addTXCarAction:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *fastPayTableView;
- (IBAction)fastPayCarAction:(id)sender;

- (IBAction)txCarButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *addFastPayCarButton;
@property (weak, nonatomic) IBOutlet UITableView *txTableView;
@property (weak, nonatomic) IBOutlet UIButton *addTXCarButton;
@property (strong,nonatomic)NSArray *fastPatBankCarListArr;
@property (strong,nonatomic)NSArray *drawPatBankCarListArr;
@property (weak, nonatomic) IBOutlet UIView *selectViewone;
@property (weak, nonatomic) IBOutlet UIView *selectViewtwo;
@property (weak, nonatomic) IBOutlet UIView *addTxCarView;
@property (weak, nonatomic) IBOutlet UIView *addFastPayCarView;






@end
