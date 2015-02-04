//
//  CenterViewController.m
//  汇投资
//
//  Created by 杨青源 on 14-10-31.
//  Copyright (c) 2014年 杨青源. All rights reserved.
//

#import "CenterViewController.h"
#import "AppDelegate.h"
#import "HomeCell.h"
#import "WXDataService.h"
#import "ProjectWebViewController.h"
#import "Reachability.h"
#import "HomeDetailViewCell.h"
#import "MJRefresh.h"
#import "LicaiDetaliWebViewController.h"
#import "HomeModel.h"
#import "LoadBankCarList.h"
#import "UIColor+FlatUI.h"
#define ios6  ([[UIDevice currentDevice].systemVersion floatValue]==6)


#import "LiCaiModel.h"

#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
@interface CenterViewController (){

    NSMutableArray *tompArray;//零时容器
    NSMutableArray *licaiTomArray;
    

}

@end

@implementation CenterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self  = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        self.hidesBottomBarWhenPushed = YES;        
    }
    return self;

}


- (void)_initTableView{
self.view.backgroundColor = [UIColor colorFromHexCode:@"efeff4"];
    if (ios6) {
    
      _detailTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 93, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 93, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];

        self.SBButton.frame = CGRectMake(0, 40, 160, 50);
        self.tzButton.frame = CGRectMake(160, 40, 160, 50);
        self.rightSelectView.frame = CGRectMake(160, 90, 160, 2);
        self.leftSelectView.frame = CGRectMake(0, 90, 160, 2);
        self.centerseletimg.frame = CGRectMake(160, 55, 1, 20);
    }else{
          _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 113, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        _detailTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 113, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    }
    
    
    
    [self.view addSubview:_detailTableView];
    _detailTableView.dataSource = self;
    _detailTableView.delegate = self;
    _detailTableView.hidden = YES;
        [self.view addSubview:_tableView];
    _tableView.dataSource= self;
    _tableView.delegate = self;
    
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.data = [[NSMutableArray alloc]init];
    self.pageIndex = [[NSNumber alloc]initWithInteger:1];
   
    self.detailData = [[NSMutableArray alloc]init];
    tompArray = [[NSMutableArray alloc]init];
    licaiTomArray =[[NSMutableArray alloc]init];
   

    
    
    // 2.集成刷新控件
    
    
    Reachability *r = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:{
            // 没有网络连接
           
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"未连接到网络"
                                                               message:nil
                                                              delegate:self
                                                     cancelButtonTitle:@"确定"
                                                     otherButtonTitles:nil];
            [alertView show];
        }

        break;
        case ReachableViaWWAN:{
            // 使用3G网络
            [self loadDetailData];
        }

        break;
        case ReachableViaWiFi:{
            // 使用WiFi网络
            [self loadDetailData];
        }

            
        break;
    }
    
    [self _initTableView];
    [self setupRefresh];
}

- (void)loadDetailData{

    //NSString *url = @"http://app.huitouzi.com/htzApp/app/free/gunxueqiu/list.json?";
    NSString *url1 = [NSString stringWithFormat:@"http://app.huitouzi.com/htzApp/app/free/gunxueqiu/list.json"];
    [WXDataService requestWithURL:url1 params:nil httpMethod:@"POST" block:^(id result) {
        [self _loadLiCaiData:result];
        
        
       //wap.huitouzi.com
    } requestHeader:nil];


}


- (void)loadData:(id)sender{

   
    
        
        
    
    NSString *baseUrl = @"http://app.huitouzi.com/htzApp/app/free/sanProject/list.json?pageIndex=1&pageSize=10";
    
    

    
        [WXDataService requestWithURL:baseUrl params:nil httpMethod:@"Post" block:^(id result) {
            [self _loadFinsh:result];
            
        } requestHeader:nil];


}
- (void)_loadFinsh:(id)result{

    
    NSString *code = [[result objectForKey:@"data"] objectForKey:@"code"];
    NSString *msg = [[result objectForKey:@"data"] objectForKey:@"msg"];
    //纪录当前页
    self.pageIndex = [[result objectForKey:@"data"] objectForKey:@"pageIndex"];
    //纪录总共页
    self.totalPages = [[result objectForKey:@"data"] objectForKey:@"totalPages"];
   
    if ([code intValue] == 2000) {
        
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:msg
                                                           message:nil
                                                          delegate:self
                                                 cancelButtonTitle:nil
                                                 otherButtonTitles:nil];
        [alertView show];
        
    }else{

  NSArray *arr =  [[result objectForKey:@"data"] objectForKey:@"list"];
    
   
    for (NSDictionary *dic in arr) {
       _homeModel = [[HomeModel alloc]initWithDataDic:dic];
        
        [self.data addObject:_homeModel];
    }

    }
   
    [_tableView reloadData];

}

-(void)_loadLiCaiData:(id)result
{
    NSArray *arr =  [[result objectForKey:@"data"] objectForKey:@"list"];
    
    for (NSDictionary *dic in arr) {
        _licai = [[LiCaiModel alloc] initWithDataDic:dic];
        
        [self.detailData addObject:_licai];
    }
    [_detailTableView reloadData];
}
#pragma mark UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _tableView) {
      return self.data.count;
    }else{
    
        return self.detailData.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    static NSString *iden = @"cell_12356";
    static NSString *iden1 = @"cell_detail123";
    HomeDetailViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:iden1];
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (tableView == _tableView) {
        if (cell == nil) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"HomeCell" owner:nil options:nil].lastObject;
           cell.selectionStyle =UITableViewCellSelectionStyleNone;
        }
        cell.homeModel = _data[indexPath.row];
    }else if (tableView == _detailTableView){
    
        if (cell1 == nil) {
            cell1 = [[[NSBundle mainBundle]loadNibNamed:@"HomeDetailViewCell" owner:nil options:nil]lastObject];
            cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell1.liCaiModel = _detailData[indexPath.row];
        
    }
   
   
    
    if (tableView==_tableView) {
      return cell;
    }else{
    
        return cell1;
    }
   
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (tableView == _tableView) {
         return 94;
    }else{
        return 80;
    }
   
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == _tableView) {
        ProjectWebViewController *proDetailVC = [[ProjectWebViewController alloc]init];
        
        proDetailVC.homeModel = _data[indexPath.row];
        
        [self presentViewController:proDetailVC animated:YES completion:nil];
    }else if (tableView == _detailTableView){
    
        LicaiDetaliWebViewController *licaiDetailWebView = [[LicaiDetaliWebViewController alloc]init];
        licaiDetailWebView.licaiModel = self.detailData[indexPath.row];
        [self presentViewController:licaiDetailWebView animated:YES completion:nil];
    
    }

}

- (IBAction)sbButtonAction:(id)sender {
    _leftSelectView.backgroundColor = [UIColor orangeColor];
    _rightSelectView.backgroundColor = [UIColor lightGrayColor];
    [_tableView setContentOffset:CGPointMake(0, 0) animated:YES];
    
    _detailTableView.hidden = YES;
    _tableView.hidden = NO;
    [self setupRefresh];
    
}

- (IBAction)tzButtonAction:(id)sender {

    _rightSelectView.backgroundColor = [UIColor orangeColor];
    _leftSelectView.backgroundColor = [UIColor lightGrayColor];
    [_tableView setContentOffset:CGPointMake(0, 0) animated:YES];
    _detailTableView.hidden = NO;
    
    _tableView.hidden = YES;
    [self setupRefresh1];
    
  
    
}
#pragma mark _tableview上下拉刷新
/**
 为了保证内部不泄露，在dealloc中释放占用的内存
 */
- (void)dealloc
{
    NSLog(@"MJTableViewController--dealloc---");
}



/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    //    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    // dateKey用于存储刷新时间，可以保证不同界面拥有不同的刷新时间
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing) dateKey:@"table"];

//#warning 自动刷新(一进入程序就下拉刷新)
    [self.tableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
  
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.tableView.headerPullToRefreshText = @"下拉可以刷新了";
    self.tableView.headerReleaseToRefreshText = @"松开马上刷新了";
    self.tableView.headerRefreshingText = @"正在帮你刷新中,不客气";
   
    
    self.tableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
    self.tableView.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    self.tableView.footerRefreshingText = @"正在帮你加载中,不客气";
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    // 1.添加假数据
   

    [self loadData:_SBButton];
    
    
    // 2.模拟2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
       
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView headerEndRefreshing];
        
    });
}

- (void)footerRereshing
{
    // 1.添加假数据
    [self loadData2];
    
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
     
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView footerEndRefreshing];
      
    });
}
#pragma mark self.detailtableview上下拉刷新



- (void)setupRefresh1
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    //    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    // dateKey用于存储刷新时间，可以保证不同界面拥有不同的刷新时间

    [self.detailTableView addHeaderWithTarget:self action:@selector(headerRereshing1) dateKey:@"table"];
//#warning 自动刷新(一进入程序就下拉刷新)
    [self.detailTableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.detailTableView addFooterWithTarget:self action:@selector(footerRereshing1)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.detailTableView.headerPullToRefreshText = @"下拉可以刷新了";
    self.detailTableView.headerReleaseToRefreshText = @"松开马上刷新了";
    self.detailTableView.headerRefreshingText = @"正在帮你刷新中,不客气";
    
    self.detailTableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
    self.detailTableView.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    self.detailTableView.footerRefreshingText = @"正在帮你加载中,不客气";
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing1
{
   
    //[self loadDetailData];
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.detailTableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.detailTableView headerEndRefreshing];
    });
}

- (void)footerRereshing1
{
    
//    [self loadDetailDataup];
    // 2.模拟2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.detailTableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.detailTableView footerEndRefreshing];
    });
}

#pragma mark -散标下拉刷新数据

//- (void)loadData1{
//    NSInteger index1= [self.pageIndex integerValue]-1;
//    if ([self.pageIndex integerValue] == 1) {
//        index1 = 1;
//    }
//    
//    
//    NSString *baseURL = [NSString stringWithFormat:@"http://app.huitouzi.com/htzApp/app/free/sanProject/list.json?pageIndex=%ld&pageSize=10",index1];
//    
//
//    [WXDataService requestWithURL:baseURL params:nil httpMethod:@"POST" block:^(id result) {
//        [self _loadFinshdonw:result];
//        
//        
//        
//        
//    } requestHeader:nil];
//    
//    
//    
//    
////}
//- (void)_loadFinshdonw:(id)result{
//    
//    
//    NSString *code = [[result objectForKey:@"data"] objectForKey:@"code"];
//    NSString *msg = [[result objectForKey:@"data"] objectForKey:@"msg"];
//    //纪录当前页
//    self.pageIndex = [[result objectForKey:@"data"] objectForKey:@"pageIndex"];
//    self.totalPages = [[result objectForKey:@"data"] objectForKey:@"totalPages"];
//    NSLog(@"%@",self.totalPages);
//    if ([code intValue] == 2000) {
//        
//        
//        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:msg
//                                                           message:nil
//                                                          delegate:self
//                                                 cancelButtonTitle:nil
//                                                 otherButtonTitles:nil];
//        [alertView show];
//        
//    }else{
//        
//        NSArray *arr =  [[result objectForKey:@"data"] objectForKey:@"list"];
//        
//        [self.data removeAllObjects];
//        for (NSDictionary *dic in arr) {
//            _homeModel = [[HomeModel alloc]initWithDataDic:dic];
//            
//            [tompArray addObject:_homeModel];
//        
//        }
//        self.data = tompArray;
//    }
//    
//    [_tableView reloadData];
//    
//}
#pragma mark 散标上拉刷新数据
- (void)loadData2{
    NSInteger index1= [self.pageIndex integerValue]+1;
    if (self.pageIndex == self.totalPages) {
        index1 = [self.totalPages integerValue];
    }
    
    
    NSString *baseURL = [NSString stringWithFormat:@"http://app.huitouzi.com/htzApp/app/free/sanProject/list.json?pageIndex=%ld&pageSize=10",(long)index1];
    
    
    [WXDataService requestWithURL:baseURL params:nil httpMethod:@"POST" block:^(id result) {
        [self _loadFinshdonw1:result];
        
        
        
        
    } requestHeader:nil];
    
    
    
    
}
- (void)_loadFinshdonw1:(id)result{
    
    
    NSString *code = [[result objectForKey:@"data"] objectForKey:@"code"];
    NSString *msg = [[result objectForKey:@"data"] objectForKey:@"msg"];
    //纪录当前页
    self.pageIndex = [[result objectForKey:@"data"] objectForKey:@"pageIndex"];
    self.totalPages = [[result objectForKey:@"data"] objectForKey:@"totalPages"];
   
    
    
    if ([code intValue] == 2000) {
        
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:msg
                                                           message:nil
                                                          delegate:self
                                                 cancelButtonTitle:nil
                                                 otherButtonTitles:nil];
        [alertView show];
        
    }else{
        
        NSArray *arr =  [[result objectForKey:@"data"] objectForKey:@"list"];
        
        [tompArray removeAllObjects];
        for (NSDictionary *dic in arr) {
        HomeModel  *homeModel1 = [[HomeModel alloc]initWithDataDic:dic];
            
            [tompArray addObject:homeModel1];
            
        }
      
        if (self.pageIndex == self.totalPages) {
            [tompArray removeAllObjects];
        }
        
        [self.data addObjectsFromArray:tompArray];
        
        
    }
    

    
}




#pragma mark 理财shang拉刷新数据

- (void)loadDetailDataup{
    NSInteger index1= [self.licaipageIndex integerValue]+1;
    if (self.licaipageIndex == self.licaiTotalPages) {
        index1 = [self.licaiTotalPages integerValue];
    }
    

    
    NSString *url =[ NSString stringWithFormat:@"http://app.huitouzi.com/htzApp/app/free/gunxueqiu/list.json?pageIndex=%ld&pageSize=10",(long)index1 ];
    
    [WXDataService requestWithURL:url params:nil httpMethod:@"POST" block:^(id result) {
        [self _loadLiCaiDataUP:result];
        
        
        
    } requestHeader:nil];
    
    
}
-(void)_loadLiCaiDataUP:(id)result
{
    NSArray *arr =  [[result objectForKey:@"data"] objectForKey:@"list"];
    [licaiTomArray removeAllObjects];
    for (NSDictionary *dic in arr) {
        LiCaiModel *licai = [[LiCaiModel alloc] initWithDataDic:dic];
        

        [licaiTomArray addObject:licai];
    }
    NSInteger index1= [self.licaipageIndex integerValue]+1;
    if (self.licaipageIndex == self.licaiTotalPages) {
        index1 = [self.licaiTotalPages integerValue];
        [licaiTomArray removeAllObjects];
    }
    [self.detailData addObjectsFromArray:licaiTomArray];
    
}



@end
