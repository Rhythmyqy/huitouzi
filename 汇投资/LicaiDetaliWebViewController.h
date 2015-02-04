//
//  LicaiDetaliWebViewController.h
//  汇投资
//
//  Created by 杨青源 on 14/11/26.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import "BassViewController.h"
#import "LiCaiModel.h"

@interface LicaiDetaliWebViewController : BassViewController<UIWebViewDelegate>
@property(nonatomic,strong)LiCaiModel *licaiModel;

@end
