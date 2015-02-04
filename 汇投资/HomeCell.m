//
//  HomeCell.m
//  汇投资
//
//  Created by 杨青源 on 14/11/5.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#import "HomeCell.h"
#import "MDRadialProgressLabel.h"
#import "MDRadialProgressTheme.h"
#import "MDRadialProgressView.h"
#import "UIViewExt.h"
#import "HomeModel.h"
#import "UIViewExt.h"

@implementation HomeCell{

    MDRadialProgressView *radialView;
}

- (MDRadialProgressView *)progressViewWithFrame:(CGRect)frame
{
    MDRadialProgressTheme *newTheme = [[MDRadialProgressTheme alloc] init];
    newTheme.completedColor = [UIColor colorWithRed:5/255.0 green:215/255.0 blue:163/255.0 alpha:1.0];
    newTheme.incompletedColor = [UIColor grayColor];
    newTheme.centerColor = [UIColor clearColor];
    newTheme.centerColor = [UIColor whiteColor];
    newTheme.sliceDividerHidden = YES;
    newTheme.labelColor = [UIColor blackColor];
    newTheme.labelShadowColor = [UIColor whiteColor];
    newTheme.drawIncompleteArcIfNoProgress = YES;
    MDRadialProgressView *view = [[MDRadialProgressView alloc] initWithFrame:frame andTheme:newTheme];
    
    // Only required in this demo to align vertically the progress views.
//    view.center = CGPointMake(self.center.x + 100, view.center.y);
    
    return view;
}

- (void)awakeFromNib {
    

    //进度条封装
    CGRect frame = CGRectMake(10, 20, 50, 50);
    radialView = [self progressViewWithFrame:frame];
    _messageLabel.textColor = [UIColor colorWithRed:5/255.0 green:215/255.0 blue:163/255.0 alpha:1.0];
    radialView.progressTotal = 100;
    radialView.theme.sliceDividerHidden = YES;
    [self.progressView addSubview:radialView];
    

    
 
   
}

- (void)setHomeModel:(WXBaseModel *)baseModel{
    
   //invest_new
    if([baseModel isKindOfClass:[HomeModel class]])
    {
        HomeModel *homelModel = (HomeModel *)baseModel;
        if(2 == [homelModel.is_new integerValue]){
            self.isNewImg.hidden = NO;
        }else if(1 == [homelModel.is_new integerValue]){
        
            self.isNewImg.hidden = YES;
        
        }
            
        self.pName.text = homelModel.pname;
        self.financing_limit.text = [NSString stringWithFormat:@"%@个月",homelModel.financing_limit];
        self.financing_amount.text = [NSString stringWithFormat:@"%@万元",homelModel.financing_amount_wanyuan];
        self.year_revenue.text = [NSString stringWithFormat:@"%@%%",homelModel.year_revenue];
        
        if ([homelModel.progress intValue] == 0) {
            radialView.progressCounter = 0;
        }else{
            radialView.progressCounter =[homelModel.progress integerValue];
//            radialView.progressTotal =100/[homelModel.progress floatValue];
        }

        
        if ([homelModel.project_status intValue] == 1) {
            /*
             //1:即将上线  2：项目预告  3：正在募集4：募集截止  5：募集完毕6：正在还款 7：还款完毕
             
             */
            self.project_status.text = @"即将上线";
            
        }else if([homelModel.project_status intValue] ==2){
            self.project_status.text = @"项目预告";
            
        }else if([homelModel.project_status intValue] == 3){
            self.project_status.text = @"正在募集";
            
        }else if([homelModel.project_status intValue] == 4){
            self.project_status.text = @"募集截止";
            
        }else if([homelModel.project_status intValue] == 5){
            self.project_status.text = @"募集完毕";
        }else if([homelModel.project_status intValue] == 6){
            self.project_status.text = @"正在还款";
        }else if([homelModel.project_status intValue] == 7){
            self.project_status.text = @"还款完毕";
            
        }
        
    }else if([baseModel isKindOfClass:[LiCaiModel class]])
    {
        
        LiCaiModel *licai = (LiCaiModel *)baseModel;
        
        //将NSNumber对象转换成NSString对象
        NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setFormatterBehavior: NSNumberFormatterBehavior10_4];
        [numberFormatter setNumberStyle: NSNumberFormatterDecimalStyle];
        NSString *numberString = [numberFormatter stringFromNumber: licai.project_days];
        
        self.financing_limit.text = numberString;
        self.pName.text = licai.pname;
        self.financing_amount.text = licai.min_invest_money;
        self.year_revenue.text = [NSString stringWithFormat:@"%@%%",licai.year_revenue];
        
//        if ([licai.progress intValue] == 0) {
//            radialView.progressTotal = 0;
//        }else{
//            radialView.progressTotal = 100/[licai.progress intValue];
//        }
        
        if ([licai.project_status intValue] == 1) {
            /*
             //1:即将上线  2：项目预告  3：正在募集4：募集截止  5：募集完毕6：正在还款 7：还款完毕
             
             */
            self.project_status.text = @"即将上线";
            
        }else if([licai.project_status intValue] ==2){
            self.project_status.text = @"项目预告";
            
        }else if([licai.project_status intValue] == 3){
            self.project_status.text = @"正在募集";
            
        }else if([licai.project_status intValue] == 4){
            self.project_status.text = @"募集截止";
            
        }else if([licai.project_status intValue] == 5){
            self.project_status.text = @"募集完毕";
        }else if([licai.project_status intValue] == 6){
            self.project_status.text = @"正在还款";
        }else if([licai.project_status intValue] == 7){
            self.project_status.text = @"还款完毕";
            
        }
    }
        
        
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

   
}



@end
