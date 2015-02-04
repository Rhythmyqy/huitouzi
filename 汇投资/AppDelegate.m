//
//  AppDelegate.m
//  汇投资
//
//  Created by 杨青源 on 14-10-30.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define sinaAPPKey  @"370985467"
#define sinaAppSercet @"3ebf5bb84d30d857b0ab59aa25fdb8c9"
#define ios  ([[UIDevice currentDevice].systemVersion floatValue])
#define qqAPPKey  @"100586975"
#define qqAppSercet @"ee5049a2c7705cf63365dd624fa84348"
#define baiduAPPID @"5323430"
#define baiduAPPKey @"H2BHwNfWGC4TaNTNgs0bsVfBv8fGmDTe"

#import "AppDelegate.h"
#import "LeftViewController.h"
#import "CenterViewController.h"
#import "MMExampleDrawerVisualStateManager.h"
#import "BassNavigationViewController.h"
#import "MoneyManageViewController.h"
#import "SellDetailViewController.h"
#import "SafeViewController.h"
#import "MessgeViewController.h"
#import "MoreViewController.h"
#import "GuideViewController.h"
#import "ProjectWebViewController.h"

#import <ShareSDK/ShareSDK.h>



#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"
#import "WeiboApi.h"
#import "WeiboSDK.h"

#import "BPush.h"
#import "JSONKit.h"
#import "OpenUDID.h"
#define KShowGuide @"showGuide"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
//    //推送通知
    [[UIApplication sharedApplication]setStatusBarHidden:YES];
    NSLog(@"调用了launchOptions方法");
    [BPush setupChannel:launchOptions];
    if (launchOptions != nil&&[[launchOptions objectForKey:@"code"]integerValue]==3) {
        ProjectWebViewController *projectWBVC = [[ProjectWebViewController alloc]init];
        NSString *projectID = [launchOptions objectForKey:@"project_id"];
        projectWBVC.projectID = projectID;
        [self.window.rootViewController presentViewController:projectWBVC animated:NO completion:^{
        }];
        
    }else if(launchOptions != nil&&[[launchOptions objectForKey:@"code"]integerValue]==0){
        NSString *appurl= [launchOptions objectForKey:@"url"];
        NSURL *url = [NSURL URLWithString:appurl];
        [[UIApplication sharedApplication]openURL:url];
        
        
    }else{
        
        
    }
    if (ios == 6) {
        [[UIApplication sharedApplication]setStatusBarHidden:YES];
    }
    NSLog(@"接收到的推送信息%@",launchOptions);
    [BPush setDelegate:self];
   [application setApplicationIconBadgeNumber:0];
    
    if (ios>=8) {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIRemoteNotificationTypeBadge
                                                                                             |UIRemoteNotificationTypeSound
                                                                                             |UIRemoteNotificationTypeAlert)
                                                                                 categories:nil];
        [application registerUserNotificationSettings:settings];
        [application registerForRemoteNotifications];
    }else {
      [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeBadge];
    
    }
    

    
    
    
    
    
   //集成sharesdk组件
    [ShareSDK registerApp:@"4c6ea21f857c"];
    [ShareSDK connectSinaWeiboWithAppKey:sinaAPPKey appSecret:sinaAppSercet redirectUri:@"https://itunes.apple.com/us/app/hui-tou-zi/id945301230?l=zh&ls=1&mt=8"];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [ShareSDK connectQZoneWithAppKey:qqAPPKey
                           appSecret:qqAppSercet
                   qqApiInterfaceCls:[QQApiInterface class]
                     tencentOAuthCls:[TencentOAuth class]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    _isCenter = YES;
    
    
    LeftViewController *leftVC = [[LeftViewController alloc] init];
    [self.viewCtrlArray addObject:leftVC];
    CenterViewController *centerVC = [[CenterViewController alloc] init];
    [self.viewCtrlArray addObject:centerVC];
    navCtrl = [[BassNavigationViewController alloc]initWithRootViewController:centerVC];
    _mmViewCtrl = [[MMDrawerController alloc]initWithCenterViewController:navCtrl leftDrawerViewController:leftVC];
    
    //设置左右菜单的宽度
    
    [_mmViewCtrl setMaximumLeftDrawerWidth:250];
    
    //设置手势操作的有效区域
    [_mmViewCtrl setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [_mmViewCtrl setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    //设置管理动画的block, block实现了所有的动画效果
    [_mmViewCtrl
     setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
         MMDrawerControllerDrawerVisualStateBlock block;
         block = [[MMExampleDrawerVisualStateManager sharedManager]
                  drawerVisualStateBlockForDrawerSide:drawerSide];
         if(block){
             block(drawerController, drawerSide, percentVisible);
         }
     }];
    
    //设置动画类型
    [MMExampleDrawerVisualStateManager sharedManager].leftDrawerAnimationType = MMDrawerAnimationTypeSlide;
    [MMExampleDrawerVisualStateManager sharedManager].rightDrawerAnimationType = MMDrawerAnimationTypeSwingingDoor;
   
    
  
    

    //初始化导航栏
    [self _initbar];
    
    
    
    
     
  
     
    
    
    
    //隐藏状态栏
   [[UIApplication sharedApplication] setStatusBarHidden:YES];

    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"]) {
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunched"];
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
         self.window.rootViewController = [[GuideViewController alloc] init] ;
        NSLog(@"first launch");
        
    }else {
        
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];
        self.window.rootViewController = _mmViewCtrl;
        NSLog(@"second launch");
        
    }
    
    



    
    


  
    
   
    
    
    
    return YES;
}




- (void)_initbar{

    
    [navCtrl setNavigationBarHidden:YES];
    
    UINavigationBar *bar = [[UINavigationBar alloc]init];
    if (ios == 6) {
        bar.frame = CGRectMake(0, 0, kScreenWidth, 44);
        [bar setBackgroundImage:[UIImage imageNamed:@"top_btn6.png"] forBarMetrics:UIBarMetricsDefault];
        
    }else{
        bar.frame = CGRectMake(0, 0, kScreenWidth, 64);
        
        
        
        [bar setBackgroundImage:[UIImage imageNamed:@"top_btn.png"] forBarMetrics:UIBarMetricsDefault];
    }
    UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:nil];
    //左边按钮
    UIButton *left = [UIButton buttonWithType:UIButtonTypeCustom];
    [left setFrame:CGRectMake(0, 2, 28, 28)];
    [left setImage:[UIImage imageNamed:@"头像.png"] forState:UIControlStateNormal];
    [left addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:left];
    [item setLeftBarButtonItem:leftButton];
    //中间图标
    UIButton *title = [UIButton buttonWithType:UIButtonTypeCustom];
    [title setFrame:CGRectMake(0, 2, 32, 32)];
    [title setImage:[UIImage imageNamed:@"LOGO.png"]forState:UIControlStateNormal];
    
    [item setTitleView:title];
    
    
    [bar pushNavigationItem:item animated:NO];
    
       [navCtrl.view addSubview:bar];
    
   [navCtrl setHidesBottomBarWhenPushed:YES];



}

- (void)_initbase{

    [self.baseNav setNavigationBarHidden:YES];
    
    UINavigationBar *bar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
    
    [bar setBackgroundImage:[UIImage imageNamed:@"top_btn.png"] forBarMetrics:UIBarMetricsDefault];
    UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:nil];
    //左边按钮
    UIButton *left = [UIButton buttonWithType:UIButtonTypeCustom];
    [left setFrame:CGRectMake(0, 2, 28, 28)];
    [left setImage:[UIImage imageNamed:@"头像.png"] forState:UIControlStateNormal];
    [left addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:left];
    [item setLeftBarButtonItem:leftButton];
    //中间图标
    UIButton *title = [UIButton buttonWithType:UIButtonTypeCustom];
    [title setFrame:CGRectMake(0, 2, 32, 32)];
    [title setImage:[UIImage imageNamed:@"LOGO.png"]forState:UIControlStateNormal];
    
    [item setTitleView:title];
    
    
    [bar pushNavigationItem:item animated:NO];
    
    [self.baseNav.view addSubview:bar];
   

}



- (void)back{
   
        AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        [appDelegate.mmViewCtrl toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
   

   
    
}

- (void)_initializePlat{





}


- (BOOL)application:(UIApplication *)application
      handleOpenURL:(NSURL *)url
{
    return [ShareSDK handleOpenURL:url
                        wxDelegate:self];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return [ShareSDK handleOpenURL:url
                 sourceApplication:sourceApplication
                        annotation:annotation
                        wxDelegate:self];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{

    NSLog(@"regisger success:%@",deviceToken);
    //注册成功，将deviceToken保存到应用服务器数据库中
  
    NSString *str = [NSString stringWithFormat:@"%@",deviceToken];
    NSLog(@"device:%@",str);
    [BPush registerDeviceToken:deviceToken];
    [BPush bindChannel];
  
}
- (void) onMethod:(NSString*)method response:(NSDictionary*)data
{
    if ([BPushRequestMethod_Bind isEqualToString:method])
    {
        NSDictionary* res = [[NSDictionary alloc] initWithDictionary:data];
        
        NSString *appid = [res valueForKey:BPushRequestAppIdKey];
        NSString *userid = [res valueForKey:BPushRequestUserIdKey];
        NSString *channelid = [res valueForKey:BPushRequestChannelIdKey];
        int returnCode = [[res valueForKey:BPushRequestErrorCodeKey] intValue];
        NSString *requestid = [res valueForKey:BPushRequestRequestIdKey];
    }
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    
    NSLog(@"调用了userInfo方法");
    
    NSLog(@"userinfo:%@",userInfo);
    
    NSLog(@"收到推送消息:%@",[[userInfo objectForKey:@"aps"] objectForKey:@"alert"]);
    
    NSLog(@"frontia applciation receive Notify: %@", [userInfo description]);
    
    if (application.applicationState == UIApplicationStateActive) {
        // 转换成一个本地通知，显示到通知栏，你也可以直接显示出一个alertView，只是那样稍显aggressive：）
        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
        localNotification.userInfo = userInfo;
        localNotification.soundName = UILocalNotificationDefaultSoundName;
        localNotification.alertBody = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
        localNotification.fireDate = [NSDate date];
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    } else {

    }
    
    if (userInfo != nil&&[[userInfo objectForKey:@"code"]integerValue]==3) {
        ProjectWebViewController *projectWBVC = [[ProjectWebViewController alloc]init];
        NSString *projectID = [userInfo objectForKey:@"project_id"];
        projectWBVC.projectID = projectID;
        [self.window.rootViewController presentViewController:projectWBVC animated:NO completion:^{
        }];
        
    }else if(userInfo != nil&&[[userInfo objectForKey:@"code"]integerValue]==0){
        NSString *appurl= [userInfo objectForKey:@"url"];
        NSURL *url = [NSURL URLWithString:appurl];
        [[UIApplication sharedApplication]openURL:url];
    
    
    }else{
    
    
    }
    
    
 


}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{

    NSLog(@"@registfail%@",error);

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"quiteTime"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"YY-MM-dd hh:mm:ss"];
    
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    
    NSLog(@"backgroundtime:%@",locationString);
    
    [[NSUserDefaults standardUserDefaults]setObject:locationString forKey:@"quiteTime"];
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"activeTime"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"YY-MM-dd hh:mm:ss"];
    
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    
    NSLog(@"locationString:%@",locationString);
    [[NSUserDefaults standardUserDefaults]setObject:locationString forKey:@"activeTime"];
    NSDate *date1 = [dateformatter dateFromString:[[NSUserDefaults standardUserDefaults]objectForKey:@"quiteTime" ]];
    NSDate *date2 = [dateformatter dateFromString:[[NSUserDefaults standardUserDefaults]objectForKey:@"activeTime" ]];
    
    NSTimeInterval time=[date2 timeIntervalSinceDate:date1];
    
//    int days=((int)time)/(3600*24);
//    int hours=(int)time%(3600*24)/3600;
    NSString *dateContent=[[NSString alloc] initWithFormat:@"%f秒",time];
    NSLog(@"时间间隔:%@",dateContent);
    // 手势解锁相关
    NSString* pswd = [LLLockPassword loadLockPassword];
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"mydefultType"] ) {
        
        if ([dateContent integerValue]>120 &&[[NSUserDefaults standardUserDefaults]boolForKey:@"mydefultType"]==YES) {
            
            if (pswd) {
                [self showLLLockViewController:LLLockViewTypeCheck];
            } else {
                [self showLLLockViewController:LLLockViewTypeCreate];
            }
            
            
        }else {
            NSLog(@"124567");
        }
        
    }
    
    
  
    
   
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}




#pragma mark - 弹出手势解锁密码输入框
- (void)showLLLockViewController:(LLLockViewType)type
{
    if(self.window.rootViewController.presentingViewController == nil){
        
        LLLog(@"root = %@", self.window.rootViewController.class);
        LLLog(@"lockVc isBeingPresented = %d", [self.lockVc isBeingPresented]);
        
        self.lockVc = [[LLLockViewController alloc] init];
        self.lockVc.nLockViewType = type;
        
        self.lockVc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pushAction:) name:@"PUSHVC" object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pushAction:) name:@"mycount" object:nil];
        [self.window.rootViewController presentViewController:self.lockVc animated:NO completion:^{
        }];
        
    
        
        LLLog(@"创建了一个pop=%@", self.lockVc);
    }
}

- (void)pushAction:(NSNotification *)notify{

    [self.lockVc dismissViewControllerAnimated:YES completion:nil];
    
    
    
   

}


@end
