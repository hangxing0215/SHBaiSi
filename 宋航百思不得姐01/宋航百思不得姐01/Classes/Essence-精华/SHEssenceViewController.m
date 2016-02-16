//
//  SHEssenceViewController.m
//  宋航百思不得姐01
//
//  Created by admin on 16/1/25.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SHEssenceViewController.h"
#import "SHRecommendTagViewController.h"

#import "SHTopicViewController.h"


@interface SHEssenceViewController ()<UIScrollViewDelegate>
@property (nonatomic ,strong) UIView *indicatorView;
@property (nonatomic ,strong) UIButton *selectedButton;

@property (nonatomic ,strong) UIView *contentView;

@property (nonatomic ,strong) UIScrollView *scrollView;
@end

@implementation SHEssenceViewController
- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    //初始化设置
    [self setupNav];
    //设置上面navView
    [self setupTitlesView];
    
    //添加表格视图子控制器
    [self setupTableView];
    //添加scrollView
    [self setupScrollView];
    

}

//添加表格视图子控制器
- (void)setupTableView
{
    SHTopicViewController *all = [[SHTopicViewController alloc]init];
    all.type = SHTopicTypeAll;
    [self addChildViewController:all];
    
    SHTopicViewController *video = [[SHTopicViewController alloc]init];
    video.type = SHTopicTypeVideo;
    [self addChildViewController:video];
    
    SHTopicViewController *audio = [[SHTopicViewController alloc]init];
    audio.type = SHTopicTypeAudio;
    [self addChildViewController:audio];
    
    SHTopicViewController *picture = [[SHTopicViewController alloc]init];
    picture.type = SHTopicTypePicture;
    [self addChildViewController:picture];
    
    SHTopicViewController *word = [[SHTopicViewController alloc]init];
    word.type = SHTopicTypeWord;
    [self addChildViewController:word];
    
}


#pragma  mark 设置滚动视图
- (void)setupScrollView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.frame = self.view.bounds;
    [self.view insertSubview:scrollView atIndex:0];
    
    scrollView.contentSize = CGSizeMake(self.childViewControllers.count * scrollView.bounds.size.width, 0);
    self.scrollView = scrollView;
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    [self scrollViewDidEndScrollingAnimation:self.scrollView];
    
    
}

#pragma marm 设置titleView
- (void)setupTitlesView
{
    UIView *contentView = [[UIView alloc]init];
    contentView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5];
    contentView.x = 0;
    contentView.y = SHTitilesViewY;
    contentView.width = self.view.width;
    contentView.height = SHTitilesViewH;
    [self.view addSubview:contentView];
    
    //添加底部的导航条  红色的
    UIView *indecatorView = [[UIView alloc]init];
    
    indecatorView.height = 2;
    indecatorView.y = contentView.height - indecatorView.height;
    indecatorView.backgroundColor = [UIColor redColor];
    self.indicatorView = indecatorView;
    
    
    //添加五个button
    NSArray *titlesArray = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    int count = (int)titlesArray.count;
    
    int width = contentView.width / 5;
    int height = contentView.height;
    for (int i = 0; i < count; i++)
    {
        UIButton *button = [[UIButton alloc]init];
        button.tag = i;
        button.x = width * i;
        button.y = 0;
        button.width = width;
        button.height = height;
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:titlesArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        [button.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [contentView addSubview:button];
        
        if (i == 0)
        {
            [button.titleLabel sizeToFit];
            button.enabled = NO;
            self.selectedButton = button;
            self.indicatorView.width = button.titleLabel.width;
            self.indicatorView.centerX = button.centerX;
        }
    }
    
    [contentView addSubview:indecatorView];
    
    self.contentView = contentView;
}

- (void)titleClick:(UIButton *)button
{
  
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.centerX = button.centerX;
        
    }];
    
    
    //滚动  滚完了以后进行视图的加载  用scrollview 代理
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = button.tag * self.scrollView.width;
    [self.scrollView setContentOffset:offset animated:YES];
}

#pragma  mark scrollView的代理方法
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    //添加视图控制器的view
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    UITableViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
//    vc.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(self.navigationController.navigationBar.height + self.contentView.height , 0, self.navigationController.toolbar.height, 0);
//    //设置内边距
//    vc.tableView.contentInset = UIEdgeInsetsMake(self.navigationController.navigationBar.height + self.contentView.height , 0, self.navigationController.toolbar.height, 0);
    [scrollView addSubview:vc.view];
    
    
   
    
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    //切换上面的按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self titleClick:self.contentView.subviews[index]];
}
- (void)setupNav{
    self.view.backgroundColor = SHGlobalColor;
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    // 设置导航栏左边的按钮
    UIButton *tagButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [tagButton setBackgroundImage:[UIImage imageNamed:@"MainTagSubIcon"] forState:UIControlStateNormal];
    [tagButton setBackgroundImage:[UIImage imageNamed:@"MainTagSubIconClick"] forState:UIControlStateHighlighted];
    tagButton.size = tagButton.currentBackgroundImage.size;
    [tagButton addTarget:self action:@selector(tagClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:tagButton];
}

- (void)tagClick:(UIButton *)button
{
    
    SHRecommendTagViewController *tags = [[SHRecommendTagViewController alloc]init];
    [self.navigationController pushViewController:tags animated:YES];
    
    
}


@end
