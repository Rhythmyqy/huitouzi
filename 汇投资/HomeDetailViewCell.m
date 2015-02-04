//
//  HomeDetailViewCell.m
//  汇投资
//
//  Created by 杨青源 on 14/11/21.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import "HomeDetailViewCell.h"
#import "LicaiNowInvestViewController.h"
#import "NowInvestmentViewController.h"
#import "LicaiNowInvestViewController.h"
#import "CenterViewController.h"
#import "WXDataService.h"
@implementation HomeDetailViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setLiCaiModel:(LiCaiModel *)liCaiModel{
    if (_liCaiModel != liCaiModel) {
        _liCaiModel = liCaiModel;
        self.projectTitle.text = _liCaiModel.pname;
        self.mayGetMoney.text = [NSString stringWithFormat:@"%@%%",_liCaiModel.year_revenue];
        
        NSString *str = [NSString stringWithFormat:@"%@天",_liCaiModel.project_days];
        self.projectTime.text = str;
        
         /*
         "project_days" : 7,
         "is_allow_invest" : 1,
         "min_invest_money" : "1000",
         "year_revenue" : "6.5",
         "project_status" : "立即认购",
         "project_id" : 106,
         "pname" : "滚雪球理财计划之小清新系列"
         */
        if ([_liCaiModel.project_status isEqualToString:@"立即认购"]) {
          
            [self.nowInvert setTitle:_liCaiModel.project_status forState:UIControlStateNormal];
            
            [self.nowInvert setBackgroundImage:[UIImage imageNamed:@"投资项目5尺寸修改_03.jpg"] forState:UIControlStateNormal];
            
        }else{
        
            [self.nowInvert setTitle:_liCaiModel.project_status forState:UIControlStateNormal];
            [self.nowInvert setBackgroundImage:[UIImage imageNamed:@"投资项目5尺寸修改_06.jpg"] forState:UIControlStateNormal];
            self.nowInvert.userInteractionEnabled = NO;
        }
    
        
        
    }




}


- (IBAction)NowInvestAction:(id)sender {
    NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"Cookie"];
    
    NSDictionary *dic1 = [[NSMutableDictionary alloc]init];
    
    [dic1 setValue:str forKey:@"Cookie"];
    
    NSString *str1 = @"http://app.huitouzi.com/htzApp/app/htz/isLogin.json";
    [WXDataService requestWithURL:str1 params:nil httpMethod:@"POST" block:^(id result) {
        [self loadFinsh:result];
     } requestHeader:dic1];
    
    
    

    
   
    
}


- (void)loadFinsh:(id)result{
    NSString *code = [result objectForKey:@"code"];
    NSString *msg = [result objectForKey:@"msg"];
    if ([code integerValue]==0000) {
        id next = [self nextResponder];
        while(![next isKindOfClass:[CenterViewController class]])//这里跳不出来。。。有人说这里跳不出来，其实是因为它没有当前这个view放入ViewController中，自然也就跳不出来了，会死循环，使用时需要注意。
        {
            next = [next nextResponder];
        }
        if ([next isKindOfClass:[CenterViewController class]])
        {
            next = (CenterViewController *)next;
        }
        NowInvestmentViewController *payDVC = [[NowInvestmentViewController alloc]init];
        
        NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"Cookie"];
        if (str.length==0) {
            UIAlertView *alterView = [[UIAlertView alloc]initWithTitle:@"你还未登录或者登录已经超时，请重新登录" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alterView show];
            return;
        }
        
        payDVC.projectID = [NSString stringWithFormat:@"%@",_liCaiModel.project_id];
        
        [next presentViewController:payDVC animated:YES completion:nil];
        
    }else{
    
        UIAlertView *alterView = [[UIAlertView alloc]initWithTitle:msg message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alterView show];
        
    }



}

@end
