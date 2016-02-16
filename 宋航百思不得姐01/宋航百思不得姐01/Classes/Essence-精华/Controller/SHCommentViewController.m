//
//  SHCommentViewController.m
//  宋航百思不得姐01
//
//  Created by admin on 16/2/1.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SHCommentViewController.h"
#import "SHTopicCell.h"
#import "SHTopic.h"
#import "SHComment.h"
#import <MJRefresh.h>
#import <AFNetworking.h>
#import <MJExtension.h>
#import "SHCommentCell.h"
@interface SHCommentViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewConstraint;
@property (weak, nonatomic) IBOutlet UITextField *commentTextField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/** 最热评论 */
@property (nonatomic, strong) NSArray *hotComments;
/** 最新评论 */
@property (nonatomic, strong) NSMutableArray *latestComments;
/**用一个数组保存住最热评论数组*/
@property (nonatomic,strong)NSArray *saved_top_cmt;


/** 保存当前的页码 */
@property (nonatomic, assign) NSInteger page;

/** 管理者 */
@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation SHCommentViewController
- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
static NSString * const SHCommentCellID = @"comment";
- (IBAction)voiceButtonClick:(id)sender {
}
- (IBAction)monkeyButtonClick:(id)sender {
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //基本设置
    [self setupBasic];
    
    //设置tableview 的头
    [self setupHeader];
    
    [self setupRefresh];
    
}
- (void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    [self.tableView.mj_header beginRefreshing];
    
    
   
    
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
    self.tableView.footer.hidden = YES;
    
    //不要分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, SHTopicCellMargin, 0);
    
    
}
- (void)setupBasic
{
    self.title = @"评论";

    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" highImage:@"comment_nav_item_share_icon_click" target:self action:@selector(barbuttonitemClick:)];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SHCommentCell class]) bundle:nil] forCellReuseIdentifier:SHCommentCellID];

}
/**设置tableview*/
- (void)setupHeader
{
    /**
     *  header会出现问题  用view包装
     */
    UIView *header = [[UIView alloc]init];
    if (self.topic.top_cmt) {
        self.saved_top_cmt = self.topic.top_cmt;
        self.topic.top_cmt = nil;
        [self.topic setValue:@0 forKeyPath:@"cellHeight"];
    }
    
    header.backgroundColor = [UIColor redColor];
    SHTopicCell *cell = [SHTopicCell cell];
    cell.topic = self.topic;
    cell.size = CGSizeMake(SHScreenW, self.topic.cellHeight);
    
    [header addSubview:cell];
    //设置header 高度
    header.height = self.topic.cellHeight + SHTopicCellMargin;
    
    self.tableView.tableHeaderView = header;
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    if (self.saved_top_cmt) {
        self.topic.top_cmt = self.saved_top_cmt;
        [self.topic setValue:@0 forKeyPath:@"cellHeight"];
        
    }
    
    // 取消所有任务
    //    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    [self.manager invalidateSessionCancelingTasks:YES];
}

- (void)loadNewComments
{
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.id;
    params[@"hot"] = @"1";
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        //处理没有评论的情况
        if (![responseObject isKindOfClass:[NSDictionary class]])
        {
            self.tableView.header.hidden = YES;
            return;
        }
        // 最热评论
        self.hotComments = [SHComment objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        
        // 最新评论
        self.latestComments = [SHComment objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        [self.tableView reloadData];
        [self.tableView.header endRefreshing];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.header endRefreshing];
    }];
}
- (void)loadMoreComments
{
    self.tableView.footer.hidden = NO;
    // 结束之前的所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 页码
    NSInteger page = self.page + 1;
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.id;
    params[@"page"] = @(page);
    SHComment *cmt = [self.latestComments lastObject];
    params[@"lastcid"] = cmt.id;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        //如果没有评论
        if (![responseObject isKindOfClass:[NSDictionary class]])
        {
            self.tableView.footer.hidden = YES;
            return;
        }
        
        // 最新评论
        NSArray *newComments = [SHComment objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.latestComments addObjectsFromArray:newComments];

        // 页码
        self.page = page;
        
        // 刷新数据
        [self.tableView reloadData];
        
        // 控制footer的状态
        NSInteger total = [responseObject[@"total"] integerValue];
        MyLog(@"...total......%lu",total);
        if (self.latestComments.count >= total) { // 全部加载完毕
            self.tableView.footer.hidden = YES;
        } else {
            // 结束刷新状态
            [self.tableView.footer endRefreshing];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.footer endRefreshing];
    }];
}



/**键盘frame改变的的事件*/
- (void)keyboardWillChangeFrame:(NSNotification *)noti
{
    //键盘显示、隐藏完毕的frame
    CGRect frame = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //修改底部的约束
    self.bottomViewConstraint.constant = SHScreenH - frame.origin.y;
    //动画时间
    CGFloat duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)barbuttonitemClick:(UIBarButtonItem *)item
{
    MyLogFunc;
}



/**
 * 返回第section组的所有评论数组
 */
- (NSArray *)commentsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.hotComments.count ? self.hotComments : self.latestComments;
    }
    return self.latestComments;
}

- (SHComment *)commentInIndexPath:(NSIndexPath *)indexPath
{
    return [self commentsInSection:indexPath.section][indexPath.row];
}


#pragma mark - <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    self.tableView.footer.hidden = NO;
    NSInteger hotCount = self.hotComments.count;
    NSInteger latestCount = self.latestComments.count;
    
    if (hotCount) return 2; // 有"最热评论" + "最新评论" 2组
    if (latestCount) return 1; // 有"最新评论" 1 组
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger hotCount = self.hotComments.count;
    NSInteger latestCount = self.latestComments.count;
    if (section == 0) {
        return hotCount ? hotCount : latestCount;
    }
    
    // 非第0组
    return latestCount;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    MyLog(@"......%lu",section);
    NSInteger hotCount = self.hotComments.count;
    if (section == 0) {
        return hotCount ? @"最热评论" : @"最新评论";
    }
    return @"最新评论";
}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    
//    UIView *header = [[UIView alloc]init];
//    //header.backgroundColor = SHGlobalColor;
//    header.backgroundColor = [UIColor greenColor];
//    UILabel *label = [[UILabel alloc]init];
//    [label setTextColor:[UIColor greenColor]];
//    label.width = 200;
//    label.x = SHTopicCellMargin;
//    label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
//    [header addSubview:label];
//    NSInteger hotCount = self.hotComments.count;
//    if (section == 0)
//    {
//        label.text = hotCount ? @"最热评论" : @"最新评论";
//        
//    }
//    else
//    {
//        label.text = @"最新评论";
//        
//    }
//    return header;
//
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SHCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"comment"];

    
    SHComment *comment = [self commentInIndexPath:indexPath];
    cell.comment = comment;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}
/**
 *  开始拉动tableview
 *
 *  scrollView
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
    
    //让顶的那些东西消失
    [[UIMenuController sharedMenuController]setMenuVisible:NO animated:YES];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SHCommentCell *cell = (SHCommentCell *)[tableView cellForRowAtIndexPath:indexPath];
    //出现第一响应者
    [cell becomeFirstResponder];
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    //显示menuController
    UIMenuItem *ding = [[UIMenuItem alloc]initWithTitle:@"顶" action:@selector(ding:)];
    UIMenuItem *replay = [[UIMenuItem alloc]initWithTitle:@"回复" action:@selector(replay:)];
    UIMenuItem *report = [[UIMenuItem alloc]initWithTitle:@"举报" action:@selector(report:)];
    menuController.menuItems = @[ding,replay,report];
    CGRect rect = CGRectMake(0, cell.height * 0.5, cell.width, cell.height * 0.5);
    [menuController setTargetRect:rect inView:cell];
    [menuController setMenuVisible:YES animated:YES];
}
- (void)ding:(UIMenuController *)menu
{
    MyLog(@"%s",__func__);
}
- (void)replay:(UIMenuController *)menu
{
    MyLog(@"%s",__func__);
}
- (void)report:(UIMenuController *)menu
{
    MyLog(@"%s",__func__);
}

@end
