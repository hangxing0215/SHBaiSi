//
//  SHMeViewController.m
//  宋航百思不得姐01
//
//  Created by admin on 16/1/25.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SHMeViewController.h"
#import "SHMeCell.h"
#import "SHMeFooterView.h"
@interface SHMeViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation SHMeViewController
static  NSString *SHMeCellId = @"me";
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBasic];
    [self setupNav];
    [self setupTableView];
}



#pragma  mark <UITableViewDelegate>



#pragma mark <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SHMeCell *cell = [tableView dequeueReusableCellWithIdentifier:SHMeCellId];
    if (cell == nil) {
        cell = [[SHMeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SHMeCellId];
    }
    if (indexPath.section == 0) {
        cell.textLabel.text = @"登录/注册";
        cell.imageView.image = [UIImage imageNamed:@"defaultUserIcon"];
    }else if (indexPath.section == 1)
    {
        cell.textLabel.text = @"离线下载";
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    return cell;
}






- (void)setupTableView
{
    [self.tableView registerClass:[SHMeCell class] forCellReuseIdentifier:SHMeCellId];
    self.tableView.contentInset = UIEdgeInsetsMake(-30, 0, 0, 0);
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
    
    
    self.tableView.tableFooterView = [[SHMeFooterView alloc]init];
    
}

- (void)setupBasic
{
    self.view.backgroundColor = SHGlobalColor;
}
- (void)setupNav
{
    self.navigationItem.title = @"我的";
    // 设置导航栏左边的按钮
    UIButton *settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [settingButton setBackgroundImage:[UIImage imageNamed:@"mine-setting-icon"] forState:UIControlStateNormal];
    [settingButton setBackgroundImage:[UIImage imageNamed:@"mine-setting-icon-click"] forState:UIControlStateHighlighted];
    settingButton.size = settingButton.currentBackgroundImage.size;
    [settingButton addTarget:self action:@selector(settingClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *moonButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [moonButton setBackgroundImage:[UIImage imageNamed:@"mine-moon-icon"] forState:UIControlStateNormal];
    [moonButton setBackgroundImage:[UIImage imageNamed:@"mine-moon-icon-click"] forState:UIControlStateHighlighted];
    moonButton.size = moonButton.currentBackgroundImage.size;
    [moonButton addTarget:self action:@selector(moonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItems =
    @[
      [[UIBarButtonItem alloc]initWithCustomView:settingButton],
      [[UIBarButtonItem alloc]initWithCustomView:moonButton]
      ]
    ;
}

- (void)settingClick:(UIButton *)button
{
    MyLogFunc;
}
- (void)moonClick:(UIButton *)button
{
    MyLogFunc;
}


@end
