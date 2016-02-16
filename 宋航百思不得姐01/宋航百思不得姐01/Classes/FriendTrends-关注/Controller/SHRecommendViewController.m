//
//  SHRecommendViewController.m
//  宋航百思不得姐01
//
//  Created by admin on 16/1/26.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SHRecommendViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <MJExtension.h>
#import <MJRefresh.h>
#import "SHRecommendCategoryCell.h"
#import "SHRecommendCategory.h"
#import "SHRecommendUserCell.h"
#import "SHRecommendUser.h"

#define SHSelectedCategory self.categoriesArray[self.categoryTableView.indexPathForSelectedRow.row]


@interface SHRecommendViewController ()<UITableViewDelegate,UITableViewDataSource>
/**
 *  左侧类别边栏
 */
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
@property (nonatomic ,strong)NSArray *categoriesArray;
/**
 *  右侧用户边栏
 */
@property (weak, nonatomic) IBOutlet UITableView *userTableView;
@property (nonatomic ,strong)NSArray *usersArray;


/**
 *  存储请求的参数
 */
@property (nonatomic,strong)NSMutableDictionary *params;

/**
 *  网络请求
 */
@property (nonatomic,strong)AFHTTPSessionManager *manager;

@end

@implementation SHRecommendViewController
static  NSString * const SHCategoryId = @"category";
static  NSString * const SHUserId = @"user";
- (AFHTTPSessionManager *)manager
{
    if (_manager == nil)
    {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //设置初始化
    [self setupTableView];
    
    //添加刷新控件
    [self setupRefrush];
    
    //加载左侧tableview
    [self setupLeftTableView];
}

#pragma mark  设置左侧tableview
- (void)setupLeftTableView
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    //请求前 显示等待状态
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        MyLog(@"%@",responseObject);
        
        self.categoriesArray = [SHRecommendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //刷新左侧tableview
        [self.categoryTableView reloadData];
        
        //默认选择第一行
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        //调用上拉刷新加载第一个分类的数据
        [self.userTableView.mj_header beginRefreshing];   
        //成功解除等待状态
        [SVProgressHUD dismiss];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //显示错误信息
        [SVProgressHUD showErrorWithStatus:@"请求失败"];
    }];
}

#pragma  mark 设置初始化
- (void)setupTableView
{
    //注册左边的分类的cell
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([SHRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:SHCategoryId];
    self.categoryTableView.tableFooterView = [UIView new];
    //注册右侧用户的cell
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([SHRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:SHUserId];
    //设置颜色
    self.view.backgroundColor = SHGlobalColor;
    //不让默认设置tableview的y值
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
}
#pragma mark 设置刷新控件
- (void)setupRefrush
{
    
    //下拉刷新
    self.userTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    //上拉刷新
    self.userTableView.mj_footer = [MJRefreshBackNormalFooter  footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
                                 
}


//第一次加载数据
- (void)loadNewData
{
    SHRecommendCategory *category = SHSelectedCategory;
    //设置当前页为1
    category.currentPage = 1;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(category.id);
    params[@"page"] = @(category.currentPage);
    
    self.params = params;
    
    //马上刷新右侧数据，防止上次请求的残留数据
    [self.userTableView reloadData];
    
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
       
        
        //第一次进来清除以前的旧数据
        [category.users removeAllObjects];
        
        NSArray *array = [SHRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [category.users addObjectsFromArray:array];
        
         if (self.params != params) return ;
        
        //刷新左侧tableview
        [self.userTableView reloadData];
        
        //保存总数
        category.total = [responseObject[@"total"] integerValue];
        
        //刷新左侧tableview
        [self.userTableView reloadData];
        
         [self.userTableView.mj_header endRefreshing];
        
        //如果数组中存入的数据和数据一样多  结束刷新
        [self checkFooterRefresh];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (self.params != params) return ;
        
        [self.userTableView.mj_header endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        
    }];

}

//加载更多数据
- (void)loadMoreData
{
    
    SHRecommendCategory *category = SHSelectedCategory;
    MyLog(@"%lu     %lu",category.total,category.users.count);
    category.currentPage++;
    MyLog(@"*****%lu",category.users.count);
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(category.id);
    params[@"page"] = @(category.currentPage);
    
    self.params = params;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //开始放在这个位置浪费用户流量
//        //判断这次的参数是不是和上次的参数一样
//        if (self.params != params) return ;
        
        NSArray *array = [SHRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //
        [category.users addObjectsFromArray:array];
        
        //保存总数
        category.total = [responseObject[@"total"] integerValue];
        
        //判断这次的参数是不是和上次的参数一样  放在这里让数据先传入数组
        if (self.params != params) return ;
        //刷新左侧tableview
        [self.userTableView reloadData];
        
        //如果数组中存入的数据和数据一样多  结束刷新
        [self checkFooterRefresh];
        
       
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (self.params != params) return ;
        
        //结束刷新 等待下一次刷新
        [self.userTableView.mj_footer endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"加载数据失败"];
        
    }];
    
    
}

#pragma mark 检查footerRefresh
- (void)checkFooterRefresh
{
    SHRecommendCategory *category = SHSelectedCategory;
    NSInteger count = category.users.count;
    //每次刷新右边数据时，都控制footer显示或者隐藏
    self.userTableView.mj_footer.hidden = (count == 0);
    //如果数组中存入的数据和数据一样多  结束刷新
    if (count == category.total)
    {
        //结束刷新
        [self.userTableView.mj_footer noticeNoMoreData];
    }
    else
    {
        [self.userTableView.footer endRefreshing];
    }
}

#pragma  mark 行数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.categoryTableView)
    {
        return self.categoriesArray.count;
    }
    else
    {
        [self checkFooterRefresh];

        return [SHSelectedCategory users].count;
    }
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.categoryTableView)
    {
        SHRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:SHCategoryId];
        
        cell.category = self.categoriesArray[indexPath.row];
        
        return cell;
    }
    else
    {
        SHRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:SHUserId];
        
        cell.user = [SHSelectedCategory users][indexPath.row];
        
        return cell;
    }
}
#pragma  mark uitableviewdelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1. 拿到点击的某一条
    SHRecommendCategory *category = self.categoriesArray[indexPath.row];
    if (category.users.count > 0)
    {
        //刷新左侧tableview
        [self.userTableView reloadData];
    }
    else
    {
        [self.userTableView.mj_header beginRefreshing];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.categoryTableView)
    {
        return 44;
    }
    else
    {
        return 70;
    }
}


#pragma mark 销毁
- (void)dealloc
{
    [self.manager.operationQueue cancelAllOperations];
}


@end
