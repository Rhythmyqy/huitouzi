//
//  HZAreaPickerView.m
//  areapicker
//
//  Created by Cloud Dai on 12-9-9.
//  Copyright (c) 2012年 clouddai.com. All rights reserved.
//
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

#import "HZAreaPickerView.h"
#import <QuartzCore/QuartzCore.h>

#define kDuration 0.3

@interface HZAreaPickerView ()
{
    NSArray *provinces, *cities, *areas;
}

@end

@implementation HZAreaPickerView

@synthesize delegate=_delegate;
@synthesize locate=_locate;
@synthesize locatePicker = _locatePicker;


-(HZLocation *)locate
{
    if (_locate == nil) {
        _locate = [[HZLocation alloc] init];
    }
    
    return _locate;
}

- (id)initWithStyle:(id<HZAreaPickerDelegate>)delegate provinces:(NSMutableArray*)provinceArray
{
    
    self = [[[NSBundle mainBundle] loadNibNamed:@"HZAreaPickerView" owner:self options:nil] objectAtIndex:0] ;
    if (self) {
        self.delegate = delegate;
        self.locatePicker.dataSource = self;
        self.locatePicker.delegate = self;
        
        //加载数据
//            provinces = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"city.plist" ofType:nil]];
        provinces = provinceArray;
        cities = [[provinces objectAtIndex:0] objectForKey:@"cities"];
        self.locate.provinceName = [[provinces objectAtIndex:0] objectForKey:@"provinceName"];
        self.locate.cityName = [[cities objectAtIndex:0] objectForKey:@"cityName"];
    }
        
    return self;
    
}



#pragma mark - PickerView lifecycle

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
        return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return [provinces count];
            break;
        case 1:
            return [cities count];
            break;
        default:
            return 0;
            break;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
        switch (component) {
            case 0:
                return [[provinces objectAtIndex:row] objectForKey:@"provinceName"];
                break;
            case 1:
                return [[cities objectAtIndex:row] objectForKey:@"cityName"];
                break;
            default:
                return @"";
                break;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
        switch (component) {
            case 0:
                cities = [[provinces objectAtIndex:row] objectForKey:@"cities"];
                [self.locatePicker selectRow:0 inComponent:1 animated:YES];
                [self.locatePicker reloadComponent:1];
                
                self.locate.provinceName = [[provinces objectAtIndex:row] objectForKey:@"provinceName"];
                self.locate.provinceId = [[provinces objectAtIndex:row] objectForKey:@"provinceId"];
                self.locate.cityName = [[cities objectAtIndex:0] objectForKey:@"cityName"];
                self.locate.cityId = [[cities objectAtIndex:0] objectForKey:@"cityId"];
                break;
            case 1:
                self.locate.cityName = [[cities objectAtIndex:row] objectForKey:@"cityName"];
                self.locate.cityId = [[cities objectAtIndex:row] objectForKey:@"cityId"];
                break;
            default:
                break;
    }
    
    if([self.delegate respondsToSelector:@selector(pickerDidChaneStatus:)]) {
        [self.delegate pickerDidChaneStatus:self];
    }

}


#pragma mark - animation

- (void)showInView:(UIView *) view
{
    self.frame = CGRectMake(0, view.frame.size.height, kScreenWidth, self.frame.size.height);
    [view addSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, view.frame.size.height - self.frame.size.height, kScreenWidth, self.frame.size.height);
    }];
    
}

- (void)cancelPicker
{
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.frame = CGRectMake(0, self.frame.origin.y+self.frame.size.height, kScreenWidth, self.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         [self removeFromSuperview];
                         
                     }];
    
}

@end
