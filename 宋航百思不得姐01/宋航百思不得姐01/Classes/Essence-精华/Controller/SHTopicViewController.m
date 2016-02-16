

#import "SHTopicViewController.h"
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import "SHTopic.h"
#import <MJExtension.h>
#import <MJRefresh.h>
#import "SHTopicCell.h"
#import "SHCommentViewController.h"
#import "SHNewViewController.h"
@interface SHTopicViewController ()
/** 帖子数据 */
@property (nonatomic, strong) NSMutableArray *topics;
/** 当前页码 */
@property (nonatomic, assign) NSInteger page;
/** 当加载下一页数据时需要这个参数 */
@property (nonatomic, copy) NSString *maxtime;
/** 上一次的请求参数 */
@property (nonatomic, strong) NSDictionary *params;

/**记录点击的是tabbar的那个按钮*/
@property (nonatomic,assign)NSInteger lastSelectedIndex;
@end

@implementation SHTopicViewController

- (NSMutableArray *)topics
{
    if (!_topics) {
        _topics = [NSMutableArray array];
    }
    return _topics;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    
    // 添加刷新控件
    [self setupRefresh];
}
static NSString *SHTopicCellID = @"topic";
- (void)setupTableView
{
    CGFloat top = SHTitilesViewY + SHTitilesViewH;
    CGFloat bottom = self.tabBarController.tabBar.height;
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(top , 0, bottom, 0);
    //设置内边距
    self.tableView.contentInset = UIEdgeInsetsMake(top , 0, bottom, 0);
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SHTopicCell class]) bundle:nil] forCellReuseIdentifier:SHTopicCellID];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    //接收通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tabbarSelect) name:SHTabbarDidSelectNotifation object:nil];

}
- (void)tabbarSelect
{
    
    if (self.lastSelectedIndex == self.tabBarController.selectedIndex  && self.view.isShowingOnWindow)
    {
        [self.tableView.header beginRefreshing];
    }
    self.lastSelectedIndex = self.tabBarController.selectedIndex;
   
}

- (void)setupRefresh
{
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    // 自动改变透明度
    self.tableView.header.autoChangeAlpha = YES;
    [self.tableView.header beginRefreshing];
    
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
}




- (NSString *)a
{
    return [self.parentViewController isKindOfClass:[SHNewViewController class]] ? @"newlist" : @"list";
}

#pragma mark - 数据处理
/**
 * 加载新的帖子数据
 */
- (void)loadNewTopics
{
    // 结束上啦
    [self.tableView.footer endRefreshing];
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = self.a;
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    self.params = params;
    
    // 发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        
        if (self.params != params) return;
        
        // 存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        // 字典 -> 模型
        self.topics = [SHTopic objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新
        [self.tableView.header endRefreshing];
        
        // 清空页码
        self.page = 0;
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (self.params != params) return;
        
        // 结束刷新
        [self.tableView.header endRefreshing];
    }];
}

// 先下拉刷新, 再上拉刷新第5页数据

// 下拉刷新成功回来: 只有一页数据, page == 0
// 上啦刷新成功回来: 最前面那页 + 第5页数据

/**
 * 加载更多的帖子数据
 */
- (void)loadMoreTopics
{
    
    // 结束下拉
    [self.tableView.header endRefreshing];
    
    self.page++;
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = self.a;
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    params[@"page"] = @(self.page);
    params[@"maxtime"] = self.maxtime;
    self.params = params;
    
    // 发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        if (self.params != params) return;
        
        // 存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        // 字典 -> 模型
        NSArray *newTopics = [SHTopic objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:newTopics];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新
        [self.tableView.footer endRefreshing];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (self.params != params) return;
        
        // 结束刷新
        [self.tableView.footer endRefreshing];
        
        // 恢复页码
        self.page--;
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    SHTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:SHTopicCellID];
    
    if (cell == nil) {
        cell = [[SHTopicCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:SHTopicCellID];
    }
    
    cell.topic = self.topics[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //取出帖子模型
    SHTopic *topic = self.topics[indexPath.row];

    
    return topic.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SHCommentViewController *commentVC = [[SHCommentViewController alloc]init];
    commentVC.topic = self.topics[indexPath.row];
    [self.navigationController pushViewController:commentVC animated:YES]; 
}



@end

