//
//  LoadBankCarList.m
//  汇投资
//
//  Created by 杨青源 on 14/11/26.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import "LoadBankCarList.h"

#import "WXDataService.h"

@implementation LoadBankCarList{
    NSMutableArray *bankNameArr;
    NSMutableArray *fastNameArr;
    

}
//提现
- (void)getBankList{
   
    
    
    NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"Cookie"];
    
    NSMutableDictionary *dic1 = [[NSMutableDictionary alloc] init];
    
    [dic1 setValue:str forKey:@"Cookie"];
    // 添加（提现或快捷）银行卡时，查询可以支持的银行
   NSString *url =@"http://app.huitouzi.com/htzApp/app/htz/bankCodeList.json?type=1";
   [WXDataService requestWithURL:url params:nil httpMethod:@"POST" block:^(id result) {
       
       
   [self loadFinsh:result];
    } requestHeader:dic1];

}

- (NSMutableDictionary *)loadFinsh:(id)result{
    bankNameArr = [[NSMutableArray alloc]init];//用于存银行名字
    self.bankNameAndID = [[NSMutableDictionary alloc]init];
    if ([[result objectForKey:@"code"] integerValue] == 0000) {
       NSArray *bankListArray = [[result objectForKey:@"data"]objectForKey:@"bankList"];
        for (NSDictionary *subBankList in bankListArray) {
          NSString *bankName= [subBankList objectForKey:@"bankname"];
          NSNumber *number_id =[subBankList objectForKey:@"bank_id"];
          [self.bankNameAndID setObject:number_id forKey:bankName];
        }
        
        
    }else if ([[result objectForKey:@"code"] integerValue] == 2001||[[result objectForKey:@"code"] integerValue]== 2000){
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:[result objectForKey:@"msg"] message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    
    }

    return self.bankNameAndID;
}

//支付
- (void)getBankList1{
    
    
    
    NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"Cookie"];
    
    NSMutableDictionary *dic1 = [[NSMutableDictionary alloc] init];
    
    [dic1 setValue:str forKey:@"Cookie"];
    // 添加（提现或快捷）银行卡时，查询可以支持的银行
    NSString *url =@"http://app.huitouzi.com/htzApp/app/htz/bankCodeList.json?type=3";
    [WXDataService requestWithURL:url params:nil httpMethod:@"POST" block:^(id result) {
        
        
        [self loadFinsh1:result];
    } requestHeader:dic1];
    
}

- (NSMutableDictionary *)loadFinsh1:(id)result{
    fastNameArr = [[NSMutableArray alloc]init];//用于存银行名字
    self.fastBankNameAndID = [[NSMutableDictionary alloc]init];
    if ([[result objectForKey:@"code"] integerValue] == 0000) {
        NSArray *bankListArray = [[result objectForKey:@"data"]objectForKey:@"bankList"];
        for (NSDictionary *subBankList in bankListArray) {
            NSString *bankName= [subBankList objectForKey:@"bankname"];
            NSNumber *number_id =[subBankList objectForKey:@"bank_id"];
            [self.fastBankNameAndID setObject:number_id forKey:bankName];
        }
        
        
    }else if ([[result objectForKey:@"code"] integerValue] == 2001||[[result objectForKey:@"code"] integerValue]== 2000){
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:[result objectForKey:@"msg"] message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        
    }
    
    return self.fastBankNameAndID;
}




#pragma mark 加载省市
- (void)getUnitsList{
    
//    NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"Cookie"];
//    
//    NSMutableDictionary *dic1 = [[NSMutableDictionary alloc] init];
//    
//    [dic1 setValue:str forKey:@"Cookie"];
    // 添加（提现或快捷）银行卡时，查询可以支持的银行
    NSString *url =@"http://app.huitouzi.com/htzApp/app/free/area.json";
    [WXDataService requestWithURL:url params:nil httpMethod:@"POST" block:^(id result) {
        
        [self getUnitsListFinsh:result];
       
    } requestHeader:nil];




}

- (void)getUnitsListFinsh:(id)result{

    NSString *code = [result objectForKey:@"code"];
    NSString *msg = [result objectForKey:@"msg"];
    self.cityNameAndId = [[NSMutableDictionary alloc]init];
    self.provinceNameAndId = [[NSMutableDictionary alloc]init];
    if ([code integerValue] == 0000) {
        _provinceArray = [[NSMutableArray alloc] init];
        _provinceArray = [result objectForKey:@"data"];
//        NSArray *cityList = [result objectForKey:@"data"];
//        for (NSDictionary *tempDic in cityList) {
//            /*
//             {
//             "cities" : [
//             {
//             "cityId" : "3188",
//             "cityName" : "北京市"
//             }
//             ],
//             "provinceId" : "北京市",
//             "provinceName" : "北京市"
//             },
//
//             */
//            NSString *provinceID = [tempDic objectForKey:@"provinceId"];
//            NSString *provinceName= [tempDic objectForKey:@"provinceName"];
//            [self.provinceNameAndId setObject:provinceID forKey:provinceName];
//            
//            //城市
//            NSArray *cityArr = [tempDic objectForKey:@"cities"];
//            for (NSDictionary *citylist1 in cityArr) {
//                
//                NSString *cityIDstr = [citylist1 objectForKey:@"cityId"];
//                NSString *cityName=  [citylist1 objectForKey:@"cityName"];
//                [self.cityNameAndId setObject:cityIDstr forKey:cityName];
//            }
//        }
        
    }else{
    
        UIAlertView *alterView = [[UIAlertView alloc]initWithTitle:msg message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alterView show];
     
    
    
    }






}
// 我的银行卡 展示
- (void)getMyBankList{

    NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"Cookie"];
    
    NSDictionary *dic1 = [[NSMutableDictionary alloc]init];
    
    [dic1 setValue:str forKey:@"Cookie"];
//http://app.huitouzi.com/htzApp/app/htz/banklist.json
  NSString *url = @"http://app.huitouzi.com/htzApp/app/htz/banklist.json";
  [WXDataService requestWithURL:url params:nil httpMethod:@"POST" block:^(id result) {
      [self getBankListFinsh:result];
  } requestHeader:dic1];



}

- (void)getBankListFinsh:(id)result{
    self.myQuickBankShow = [[NSMutableDictionary alloc]init];
    self.mydrawPayBankShow = [[NSMutableDictionary alloc]init];
    self.fastpaycarName = [[NSMutableArray alloc]init];
    self.txCarname = [[NSMutableArray alloc]init];
    
    NSString *code = [result objectForKey:@"code"];
    NSString *msg = [result objectForKey:@"msg"];
    
    
     NSArray *quickPaybabk =[[NSArray alloc]init];
    NSArray *withdrawbankArry = [[NSArray alloc]init];
    if ([code integerValue] == 0000) {
     //快捷支付银行卡
        quickPaybabk = [[result objectForKey:@"data"] objectForKey:@"quickpaybank"];
        for (NSDictionary *quickbankdetail in quickPaybabk) {
            [quickbankdetail objectForKey:@"cardno"];//尾号
            [quickbankdetail objectForKey:@"bank_name"];//建设银行
            NSString *idstr = [NSString stringWithFormat:@"%@",[quickbankdetail objectForKey:@"card_id"]];
            self.fastPaybankNUM = idstr;
            self.fastPaybankName =[quickbankdetail objectForKey:@"bank_name"];
            
            NSString *myquickBankShow = [NSString stringWithFormat:@"%@  %@",[quickbankdetail objectForKey:@"bank_name"],[quickbankdetail objectForKey:@"cardno"]];
            [self.fastpaycarName addObject:myquickBankShow];
            [self.myQuickBankShow setObject:idstr forKey:myquickBankShow];
           
        }
        //我的提现银行卡
        withdrawbankArry = [[result objectForKey:@"data"]objectForKey:@"withdrawbank"];
        for (NSDictionary *withdrawdic in withdrawbankArry) {
            [withdrawdic objectForKey:@"cardno"];//尾号
            [withdrawdic objectForKey:@"bank_name"];//name
            NSString *strid = [NSString stringWithFormat:@"%@",[withdrawdic objectForKey:@"card_id"]];
            NSString *mydrawbankShow = [NSString stringWithFormat:@"%@ %@",[withdrawdic objectForKey:@"bank_name"],[withdrawdic objectForKey:@"cardno"]];
            [self.txCarname addObject:mydrawbankShow];
            self.drawpaybankName =[withdrawdic objectForKey:@"bank_name"];
            self.drawpaybankNum = strid;
            [self.mydrawPayBankShow setObject:strid forKey:mydrawbankShow];
            
        }
       
        
        
        
        
    }else if([code integerValue] == 2000 ||[code integerValue] == 2001){
        UIAlertView *alterView = [[UIAlertView alloc]initWithTitle:msg message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alterView show];
        
    }
    
 
}


@end
