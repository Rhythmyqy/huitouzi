//
//  LoadBankCarList.h
//  汇投资
//
//  Created by 杨青源 on 14/11/26.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoadBankCarList : NSObject


- (void)getBankList;
- (void)getUnitsList;
- (void)getMyBankList;
- (void)getBankList1;
@property (nonatomic ,strong) NSMutableDictionary *bankNameAndID;
@property (nonatomic,strong)NSMutableDictionary *cityNameAndId;
@property (nonatomic,strong)NSMutableDictionary *provinceNameAndId;
@property (nonatomic,strong)NSMutableDictionary *myQuickBankShow;
@property (nonatomic,strong)NSMutableDictionary *mydrawPayBankShow;
@property (nonatomic,copy)NSString *fastPaybankName;
@property (nonatomic,copy)NSString *fastPaybankNUM;
@property (nonatomic,copy)NSString *drawpaybankName;
@property (nonatomic,copy)NSString *drawpaybankNum;

@property (nonatomic,strong)NSMutableArray *fastpaycarName;
@property (nonatomic,strong)NSMutableArray *txCarname;

@property (nonatomic,strong)NSMutableDictionary *fastBankNameAndID;

@property(nonatomic,strong)NSMutableArray *provinceArray;

@end
