//
//  GuideViewController.m
//  汇投资
//
//  Created by 杨青源 on 14/12/1.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#import "GuideViewController.h"
#import "UIViewExt.h"
#import "AppDelegate.h"
@implementation GuideViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.userInteractionEnabled = YES;
    
    //加载数据
    [self _loadData];
    
    //初始化视图
     [self _initView];
}

- (void)_loadData{
    
    //存放引导图片
//
    
    if (kScreenHeight == 480.00) {
       _guideImages = @[@"引导页1-3.5尺寸.png",@"引导页2-3.5尺寸.png",@"引导页3-3.5尺寸.png"];
    }else if(kScreenHeight == 568.00){
       _guideImages = @[@"引导页1-4尺寸.png",@"引导页2-4尺寸.png",@"引导页3-4尺寸.png"];
    }else if(kScreenHeight == 667.00){
     _guideImages = @[@"引导页1-4.7尺寸.png",@"引导页2-4.7尺寸.png",@"引导页3-4.7尺寸.png"];
    
    }else if(kScreenHeight == 736.00){
    
    _guideImages = @[@"引导页1-5.5尺寸.png",@"引导页2-5.5尺寸.png",@"引导页3-5.5尺寸.png"];
    }
    
    
    
    
}
- (void)_initView{

    //创建滑动视图
    _scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.contentSize = CGSizeMake(kScreenWidth*_guideImages.count, kScreenHeight);
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    
    [self.view addSubview:_scrollView];
    
    for (int i=0; i<_guideImages.count; i++)
    {
        //创建引导图片视图
        UIImageView *mainImage = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth*i, 0, kScreenWidth, kScreenHeight)];
        mainImage.userInteractionEnabled = YES;
        mainImage.image = [UIImage imageNamed:_guideImages[i]];
        [_scrollView addSubview:mainImage];
     
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
       
        button.frame = CGRectMake((kScreenWidth-150)/2, kScreenHeight-150, 150, 100);
        [button addTarget:self action:@selector(getRootViewControl) forControlEvents:UIControlEventTouchUpInside];
        [mainImage addSubview:button];
        if (i<_guideImages.count-1) {
            button.hidden = YES;
        }else{
            button.hidden = NO;
        }
        

    }



    
}

#pragma mark - UIScrollView delegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    CGFloat length = scrollView.contentOffset.x-(scrollView.contentSize.width-scrollView.size.width);

    
    if (length > 30)
    {

        [self getRootViewControl];
        
       
        
        
        
    }
}

- (void)getRootViewControl{

    //显示状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    self.view.window.rootViewController = appDelegate.mmViewCtrl;
    
    //设置动画
    appDelegate.mmViewCtrl.view.transform = CGAffineTransformMakeScale(0.5, 0.5);
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    
    
    //将视图恢复到原来的大小
    appDelegate.mmViewCtrl.view.transform = CGAffineTransformIdentity;
    
    [UIView commitAnimations];


}

@end
