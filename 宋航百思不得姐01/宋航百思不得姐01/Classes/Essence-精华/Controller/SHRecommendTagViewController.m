//
//  SHRecommendTagViewController.m
//  宋航百思不得姐01
//
//  Created by admin on 16/1/27.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SHRecommendTagViewController.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <SVProgressHUD.h>
#import "SHRecommendTag.h"
#import "SHRecommendTagCell.h"
@interface SHRecommendTagViewController ()

//存储请求回来的数据
@property (nonatomic,strong)NSArray *tagsArray;

@end

@implementation SHRecommendTagViewController
static NSString * const SHTag = @"tag";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化设置tableview
    [self setupTableView];
    
   //加载数据
    [self loadTags];
    
    
}

- (void)loadTags
{
    NSString *url = @"http://api.budejie.com/api/api_open.php";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    
    //发送请求前让界面忙碌状态
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    
    [[AFHTTPSessionManager manager] GET:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.tagsArray = [SHRecommendTag mj_objectArrayWithKeyValuesArray:responseObject];
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"请求数据错误"];
    }];
}

- (void)setupTableView
{
    self.tableView.rowHeight = 70;
    self.navigationItem.title = @"推荐标签";
    //不要分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //设置tableview的背景颜色
    self.tableView.backgroundColor  = SHGlobalColor;
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SHRecommendTagCell class]) bundle:nil] forCellReuseIdentifier:SHTag];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tagsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SHRecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:SHTag];

    
    if (cell == nil) {
        cell = [[SHRecommendTagCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SHTag];
    }
    SHRecommendTag *tag = self.tagsArray[indexPath.row];
    
    cell.recommendTag = tag;
    
    
    
    return cell;
}

@end
