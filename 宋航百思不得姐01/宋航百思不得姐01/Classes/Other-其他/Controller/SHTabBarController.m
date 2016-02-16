//
//  SHTabBarController.m
//  宋航百思不得姐01
//
//  Created by admin on 16/1/25.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SHTabBarController.h"
#import "SHEssenceViewController.h"
#import "SHNewViewController.h"
#import "SHFriendTrendsViewController.h"
#import "SHMeViewController.h"
#import "SHTabBar.h"
#import "SHNavigationController.h"
@interface SHTabBarController ()

@end

@implementation SHTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupChildVc:[[SHEssenceViewController alloc] init] title:@"精华" imageName:@"tabBar_essence_icon" selectedImageName:@"tabBar_essence_click_icon"];
   [self setupChildVc:[[SHNewViewController alloc] init] title:@"新帖" imageName:@"tabBar_new_icon" selectedImageName:@"tabBar_new_click_icon"];
    [self setupChildVc:[[SHFriendTrendsViewController alloc] init] title:@"关注" imageName:@"tabBar_friendTrends_icon" selectedImageName:@"tabBar_friendTrends_click_icon"];
    [self setupChildVc:[[SHMeViewController alloc]initWithStyle:UITableViewStyleGrouped] title:@"我的" imageName:@"tabBar_me_icon" selectedImageName:@"tabBar_me_click_icon"];
    //kvc  赋值
    [self setValue:[[SHTabBar alloc]init] forKey:@"tabBar"];
    
}

- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    //设置文字和图片
    NSMutableDictionary *attri = [NSMutableDictionary dictionary];
    attri[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attri[NSForegroundColorAttributeName] = [UIColor grayColor];
    NSMutableDictionary *selectedAttri = [NSMutableDictionary dictionary];
    selectedAttri[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    selectedAttri[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    vc.tabBarItem.title = title;
    [vc.tabBarItem setTitleTextAttributes:attri
                                  forState:UIControlStateNormal];
    [vc.tabBarItem setTitleTextAttributes:selectedAttri
                                  forState:UIControlStateSelected];
    vc.tabBarItem.image = [UIImage imageNamed:imageName];
    UIImage *image = [UIImage imageNamed:selectedImageName];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = image;
     
    //添加导航控制器
    SHNavigationController *navi = [[SHNavigationController alloc]initWithRootViewController:vc];
    
        
    [self addChildViewController:navi];

}

@end
