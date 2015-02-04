//
//  RealAuthViewController.m
//  汇投资
//
//  Created by 杨青源 on 14/11/4.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import "RealAuthViewController.h"
#import "WXDataService.h"
#import "AppDelegate.h"
#import "NetService.h"

@interface RealAuthViewController ()

@end

@implementation RealAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

//键盘代理方法
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.RealNameText resignFirstResponder];
    [self.idCarText resignFirstResponder];
}

-(void)back{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.nameTitle.text =@"实名认证";
}



- (NSString *)encodeToPercentEscapeString: (NSString *) input
{
    // Encode all the reserved characters, per RFC 3986
    // (<http://www.ietf.org/rfc/rfc3986.txt>)
    NSString *outputStr = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                            (CFStringRef)input,
                                            NULL,
                                            (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                            kCFStringEncodingUTF8));
    return outputStr;
}

- (NSString *)decodeFromPercentEscapeString: (NSString *) input
{
    NSMutableString *outputStr = [NSMutableString stringWithString:input];
    [outputStr replaceOccurrencesOfString:@"+"
                               withString:@" "
                                  options:NSLiteralSearch
                                    range:NSMakeRange(0, [outputStr length])];
    
    return [outputStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}


- (void)_loadData{
    
    NSString *url =  @"htz/realNameInterfaceAuth.json";
    
    
    NSString *realName = self.RealNameText.text;
    NSString *cardId = self.idCarText.text;
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] initWithCapacity:2];
    [parameters setObject:realName forKey:@"realname"];
    [parameters setObject:cardId forKey:@"card_id"];
    [NetService post:url parameters:parameters success:^(id responseObject) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"恭喜您,认证成功" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        
        
        [alertView show];
        [self.navigationController popToRootViewControllerAnimated:YES];
    } failure:^(NSString *error) {
        NSLog(@"Error: %@", error);
    } netError:^(NSString *error) {
        
    }];
    

    
}
//认证回调方法

- (IBAction)authAction:(id)sender {
    if (self.RealNameText.text.length == 0 || self.idCarText.text.length==0) {
        UIAlertView *alterView = [[UIAlertView alloc]initWithTitle:@"请输入完整信息" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alterView show];
        return;
    }
    
    
    [self _loadData];
}
@end
