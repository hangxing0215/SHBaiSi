//
//  SHFriendTrendsViewController.m
//  宋航百思不得姐01
//
//  Created by admin on 16/1/25.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SHFriendTrendsViewController.h"
#import "SHRecommendViewController.h"
#import "SHLoginRegisterViewController.h"
@interface SHFriendTrendsViewController ()

@end

@implementation SHFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MyLog(@".....%@",NSStringFromCGRect(self.view.bounds));
    
    self.view.backgroundColor = SHGlobalColor;
    
    self.navigationItem.title = @"关注";
    // 设置导航栏左边的按钮
    UIButton *tagButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [tagButton setBackgroundImage:[UIImage imageNamed:@"friendsRecommentIcon"] forState:UIControlStateNormal];
    [tagButton setBackgroundImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] forState:UIControlStateHighlighted];
    tagButton.size = tagButton.currentBackgroundImage.size;
    [tagButton addTarget:self action:@selector(tagClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:tagButton];
    
    
    
}

- (void)tagClick:(UIButton *)button
{
    SHRecommendViewController *vc = [[SHRecommendViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)clickLoginOrRegisterButton:(id)sender
{
    SHLoginRegisterViewController *loginResgiter = [[SHLoginRegisterViewController alloc]init];
    [self presentViewController:loginResgiter animated:YES completion:nil];
}


@end
