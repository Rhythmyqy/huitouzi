//
//  LLLockViewController.m
//  LockSample
//
//  Created by Lugede on 14/11/11.
//  Copyright (c) 2014年 lugede.cn. All rights reserved.
//

#import "LLLockViewController.h"
#import "LLLockIndicator.h"
#import "UIColor+FlatUI.h"
#import "LoginViewController.h"
#import "SafeViewController.h"
#import "AppDelegate.h"
#import <ShareSDK/ShareSDK.h>

#define kTipColorNormal [UIColor blackColor]
#define kTipColorError [UIColor redColor]


@interface LLLockViewController ()
{
    int nRetryTimesRemain; // 剩余几次输入机会
}

@property (weak, nonatomic) IBOutlet UIImageView *preSnapImageView; // 上一界面截图
@property (weak, nonatomic) IBOutlet UIImageView *currentSnapImageView; // 当前界面截图
@property (nonatomic, strong) IBOutlet LLLockIndicator* indecator; // 九点指示图
@property (nonatomic, strong) IBOutlet LLLockView* lockview; // 触摸田字控件
@property (strong, nonatomic) IBOutlet UILabel *tipLable;
@property (strong, nonatomic) IBOutlet UIButton *tipButton; // 重设/(取消)的提示按钮


@property (nonatomic, strong) NSString* savedPassword; // 本地存储的密码
@property (nonatomic, strong) NSString* passwordOld; // 旧密码
@property (nonatomic, strong) NSString* passwordNew; // 新密码
@property (nonatomic, strong) NSString* passwordconfirm; // 确认密码
@property (nonatomic, strong) NSString* tip1; // 三步提示语
@property (nonatomic, strong) NSString* tip2;
@property (nonatomic, strong) NSString* tip3;


@end


@implementation LLLockViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithType:(LLLockViewType)type
{
    self = [super init];
    if (self) {
        _nLockViewType = type;
    }
    return self;
}

#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(dismissAction) name:@"mycount" object:nil];
    if (_nLockViewType == LLLockViewTypeCreate) {
//        self.nameTitle.text = @"创建手势密码";
    }else if(_nLockViewType == LLLockViewTypeCheck ){
//      self.nameTitle.text = @"解锁";
        self.forgetButton.hidden = NO;
        self.otherUserButton.hidden = NO;
    }else if(_nLockViewType == LLLockViewTypeModify){
//    self.nameTitle.text = @"修改手势密码";
    }else if (_nLockViewType == LLLockViewTypeClean){
    
//    self.nameTitle.text =@"清楚手势密码";
    }
    
 
   
//    self.left.hidden = YES;
   self.view.backgroundColor = [UIColor colorFromHexCode:@"ec6617"];
        self.indecator.backgroundColor = [UIColor clearColor];
    self.lockview.backgroundColor = [UIColor clearColor];
    
    
    
//    self.horiScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 100, 320, 320)];
    
    self.lockview.delegate = self;
    
    LLLog(@"实例化了一个LockVC");
}

- (void)dismissAction{

    [self dismissViewControllerAnimated:YES completion:nil];


}

- (void)viewWillAppear:(BOOL)animated
{
#ifdef LLLockAnimationOn
    [self capturePreSnap];
#endif
    
    [super viewWillAppear:animated];
    
    // 初始化内容
    switch (_nLockViewType) {
        case LLLockViewTypeCheck:
        {
            _tipLable.text = @"请输入解锁密码";
        }
            break;
        case LLLockViewTypeCreate:
        {
            _tipLable.text = @"创建手势密码";
        }
            break;
        case LLLockViewTypeModify:
        {
            _tipLable.text = @"请输入原来的密码";
        }
            break;
        case LLLockViewTypeClean:
        default:
        {
            _tipLable.text = @"请输入密码以清除密码";
        }
    }
    
    // 尝试机会
    nRetryTimesRemain = LLLockRetryTimes;
    
    self.passwordOld = @"";
    self.passwordNew = @"";
    self.passwordconfirm = @"";
    
    // 本地保存的手势密码
    self.savedPassword = [LLLockPassword loadLockPassword];
    LLLog(@"本地保存的密码是%@", self.savedPassword);
    
    [self updateTipButtonStatus];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 检查/更新密码
- (void)checkPassword:(NSString*)string
{
    // 验证密码正确
    if ([string isEqualToString:self.savedPassword]) {
        
        if (_nLockViewType == LLLockViewTypeModify) { // 验证旧密码
            
            self.passwordOld = string; // 设置旧密码，说明是在修改
            
            [self setTip:@"请输入新的密码"]; // 这里和下面的delegate不一致，有空重构
            
        } else if (_nLockViewType == LLLockViewTypeClean) { // 清除密码

            [LLLockPassword saveLockPassword:nil];
            [self hide];
            
            [self showAlert:self.tip2];
            
        } else { // 验证成功
            
            [self hide];
        }
        
    }
    // 验证密码错误
    else if (string.length > 0) {
        
        nRetryTimesRemain--;
        
        if (nRetryTimesRemain > 0) {
            
            if (1 == nRetryTimesRemain) {
                [self setErrorTip:[NSString stringWithFormat:@"最后的机会咯-_-!"]
                           errorPswd:string];
            } else {
                [self setErrorTip:[NSString stringWithFormat:@"密码错误，还可以再输入%d次", nRetryTimesRemain]
                           errorPswd:string];
            }
            
        } else {
            
            // 强制注销该账户，并清除手势密码，以便重设
//            [self dismissViewControllerAnimated:NO completion:nil]; // 由于是强制登录，这里必须以NO ani的方式才可
            [LLLockPassword saveLockPassword:nil];
            
            
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userInfor"];
            
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"Cookie"];
            
            [[NSUserDefaults standardUserDefaults] synchronize];
            [ShareSDK cancelAuthWithType:ShareTypeSinaWeibo];
            [ShareSDK cancelAuthWithType:ShareTypeQQSpace];
            
            
            
            UIAlertView *altview = [[UIAlertView alloc]initWithTitle:@"请重新登录" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [altview show];
            
            
//            [altview dismissWithClickedButtonIndex:0 animated:YES];
//            //安全退出后跳转到登录页面
//            LoginViewController *login = [[LoginViewController alloc]init];
//            
//            
//            //点击单元格跳转到对应的视图
//            AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
//            appDelegate.baseNav = [[BassNavigationViewController alloc] initWithRootViewController:login];
//            appDelegate.mmViewCtrl.centerViewController = appDelegate.baseNav;
//            //实现两个视图之间的切换
//            [appDelegate.mmViewCtrl toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
            
//            [self showAlert:@"超过最大次数，这里该做一些如强制退出重设密码等操作"];
            LoginViewController *loginVC = [[LoginViewController alloc]init];
           
            loginVC.isGust = 1;
            loginVC.isback =1;
            [self presentViewController:loginVC animated:YES completion:nil];
        }
        
    } else {
        NSAssert(YES, @"意外情况");
    }
}

- (void)createPassword:(NSString*)string
{
    // 输入密码
    if ([self.passwordNew isEqualToString:@""] && [self.passwordconfirm isEqualToString:@""]) {
        
        self.passwordNew = string;
        [self setTip:self.tip2];
    }
    // 确认输入密码
    else if (![self.passwordNew isEqualToString:@""] && [self.passwordconfirm isEqualToString:@""]) {

        self.passwordconfirm = string;
        
        if ([self.passwordNew isEqualToString:self.passwordconfirm]) {
            // 成功
            LLLog(@"两次密码一致");
            
            [LLLockPassword saveLockPassword:string];
            
            [self showAlert:self.tip3];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"PUSHVC" object:nil];
             [self hide];
           
           
            
        } else {
            
            self.passwordconfirm = @"";
            [self setTip:self.tip2];
            [self setErrorTip:@"与上一次绘制不一致，请重新绘制" errorPswd:string];
            
        }
    } else {
        NSAssert(1, @"设置密码意外");
    }
}

#pragma mark - 显示提示
- (void)setTip:(NSString*)tip
{
    [_tipLable setText:tip];
    [_tipLable setTextColor:kTipColorNormal];
    
    _tipLable.alpha = 0;
    [UIView animateWithDuration:0.8
                     animations:^{
                          _tipLable.alpha = 1;
                     }completion:^(BOOL finished){
                     }
     ];
}

// 错误
- (void)setErrorTip:(NSString*)tip errorPswd:(NSString*)string
{
    // 显示错误点点
    [self.lockview showErrorCircles:string];
    
    // 直接_变量的坏处是
    [_tipLable setText:tip];
    [_tipLable setTextColor:kTipColorError];
    
    [self shakeAnimationForView:_tipLable];
}

#pragma mark 新建/修改后保存
- (void)updateTipButtonStatus
{
    LLLog(@"重设TipButton");
    if ((_nLockViewType == LLLockViewTypeCreate || _nLockViewType == LLLockViewTypeModify) &&
        ![self.passwordNew isEqualToString:@""]) // 新建或修改 & 确认时 才显示按钮
    {
        [self.tipButton setTitle:@"点击此处以重新开始" forState:UIControlStateNormal];
        [self.tipButton setAlpha:1.0];
        
    } else {
        [self.tipButton setAlpha:0.0];
    }
    
    // 更新指示圆点
    if (![self.passwordNew isEqualToString:@""] && [self.passwordconfirm isEqualToString:@""]){
        self.indecator.hidden = NO;
        [self.indecator setPasswordString:self.passwordNew];
    } else {
        self.indecator.hidden = YES;
    }
}

#pragma mark - 点击了按钮
- (IBAction)tipButtonPressed:(id)sender {
    self.passwordNew = @"";
    self.passwordconfirm = @"";
    [self setTip:self.tip1];
    [self updateTipButtonStatus];
}

#pragma mark - 成功后返回
- (void)hide
{
    switch (_nLockViewType) {
            
        case LLLockViewTypeCheck:
        {
        }
            break;
        case LLLockViewTypeCreate:
        case LLLockViewTypeModify:
        {
            [LLLockPassword saveLockPassword:self.passwordNew];
        }
            break;
        case LLLockViewTypeClean:
        default:
        {
            [LLLockPassword saveLockPassword:nil];
        }
    }
    
    // 在这里可能需要回调上个页面做一些刷新什么的动作

#ifdef LLLockAnimationOn
     [self captureCurrentSnap];
    // 隐藏控件
    for (UIView* v in self.view.subviews) {
        if (v.tag > 10000) continue;
        v.hidden = YES;
    }
    // 动画解锁
    [self animateUnlock];
#else
    [self dismissViewControllerAnimated:NO completion:nil];
#endif
    
}

#pragma mark - delegate 每次划完手势后
- (void)lockString:(NSString *)string
{
    LLLog(@"这次的密码=--->%@<---", string) ;
    
    switch (_nLockViewType) {
            
        case LLLockViewTypeCheck:
        {
            self.tip1 = @"请输入解锁密码";
            [self checkPassword:string];
        }
            break;
        case LLLockViewTypeCreate:
        {
            self.tip1 = @"设置手势密码";
            self.tip2 = @"请再次绘制手势密码";
            self.tip3 = @"手势密码创建成功";
            [self createPassword:string];
        }
            break;
        case LLLockViewTypeModify:
        {
            if ([self.passwordOld isEqualToString:@""]) {
                self.tip1 = @"请输入原来的密码";
                [self checkPassword:string];
            } else {
                self.tip1 = @"请输入新的密码";
                self.tip2 = @"请再次输入密码";
                self.tip3 = @"密码修改成功";
                [self createPassword:string];
            }
        }
            break;
        case LLLockViewTypeClean:
        default:
        {
            self.tip1 = @"请输入密码以清除密码";
            self.tip2 = @"清除密码成功";
            [self checkPassword:string];
        }
    }
    
    [self updateTipButtonStatus];
}

#pragma mark - 解锁动画
// 截屏，用于动画
#ifdef LLLockAnimationOn
- (UIImage *)imageFromView:(UIView *)theView
{
    UIGraphicsBeginImageContext(theView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [theView.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

// 上一界面截图
- (void)capturePreSnap
{
    self.preSnapImageView.hidden = YES; // 默认是隐藏的
    self.preSnapImageView.image = [self imageFromView:self.presentingViewController.view];
}

// 当前界面截图
- (void)captureCurrentSnap
{
    self.currentSnapImageView.hidden = YES; // 默认是隐藏的
    self.currentSnapImageView.image = [self imageFromView:self.view];
}

- (void)animateUnlock{
    
    self.currentSnapImageView.hidden = NO;
    self.preSnapImageView.hidden = NO;
    
    static NSTimeInterval duration = 0.5;
    
    // currentSnap
    CABasicAnimation* scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    scaleAnimation.toValue = [NSNumber numberWithFloat:2.0];
    
    CABasicAnimation *opacityAnimation;
    opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue=[NSNumber numberWithFloat:1];
    opacityAnimation.toValue=[NSNumber numberWithFloat:0];
    
    CAAnimationGroup* animationGroup =[CAAnimationGroup animation];
    animationGroup.animations = @[scaleAnimation, opacityAnimation];
    animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animationGroup.duration = duration;
    animationGroup.delegate = self;
    animationGroup.autoreverses = NO; // 防止最后显现
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.removedOnCompletion = NO;
    [self.currentSnapImageView.layer addAnimation:animationGroup forKey:nil];
    
    // preSnap
    scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:1.5];
    scaleAnimation.toValue = [NSNumber numberWithFloat:1.0];
    
    opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = [NSNumber numberWithFloat:0];
    opacityAnimation.toValue = [NSNumber numberWithFloat:1];
    
    animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[scaleAnimation, opacityAnimation];
    animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animationGroup.duration = duration;

    [self.preSnapImageView.layer addAnimation:animationGroup forKey:nil];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    self.currentSnapImageView.hidden = YES;
    [self dismissViewControllerAnimated:NO completion:nil];
}
#endif

#pragma mark 抖动动画
- (void)shakeAnimationForView:(UIView *)view
{
    CALayer *viewLayer = view.layer;
    CGPoint position = viewLayer.position;
    CGPoint left = CGPointMake(position.x - 10, position.y);
    CGPoint right = CGPointMake(position.x + 10, position.y);
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [animation setFromValue:[NSValue valueWithCGPoint:left]];
    [animation setToValue:[NSValue valueWithCGPoint:right]];
    [animation setAutoreverses:YES]; // 平滑结束
    [animation setDuration:0.08];
    [animation setRepeatCount:3];
    
    [viewLayer addAnimation:animation forKey:nil];
}

#pragma mark - 提示信息
- (void)showAlert:(NSString*)string
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:string
                                                   delegate:nil
                                          cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
}

- (IBAction)forgetButton:(id)sender {
  
    //点击单元格跳转到对应的视图
    
    LoginViewController *loginVC = [[LoginViewController alloc]init];
    loginVC.isGust = 1;
    
    [self presentViewController:loginVC animated:YES completion:nil];
  
    
    
    
}
- (IBAction)otherUserAction:(id)sender {
    LoginViewController *loginvc = [[LoginViewController alloc]init];
    loginvc.ismyCount = 1;
    [self presentViewController:loginvc animated:YES completion:nil];
    
    
    
}
@end
