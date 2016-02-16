//
//  SHNavigationController.m
//  宋航百思不得姐01
//
//  Created by admin on 16/1/26.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SHNavigationController.h"

@interface SHNavigationController ()

@end

@implementation SHNavigationController
//第一次使用时调用
+ (void)initialize
{
    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[self.class]];
    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    [bar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
    [bar setTitleTextAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:17]}];
    
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    NSMutableDictionary *attrNomal = [NSMutableDictionary dictionary];
    attrNomal[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    attrNomal[NSForegroundColorAttributeName] = [UIColor blackColor];
    [item setTitleTextAttributes:attrNomal forState:UIControlStateNormal];
    
    NSMutableDictionary *attrDisable = [NSMutableDictionary dictionary];
    attrDisable[NSForegroundColorAttributeName] = [UIColor grayColor];
    [item setTitleTextAttributes:attrDisable forState:UIControlStateDisabled];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    

    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    
    if (self.childViewControllers.count > 0)
    {
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [backButton setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        [backButton setTitle:@"返回" forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        backButton.size = CGSizeMake(100, 20);
        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        //[backButton sizeToFit];
        backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
        
        //隐藏底部的tabBar
        viewController.hidesBottomBarWhenPushed = YES;
        
    }
   
    
    //放在后面  让控制器可以覆盖上面设置的leftBarButtonItem
    [super pushViewController:viewController animated:animated];

    
}
- (void)back
{
    [self popViewControllerAnimated:YES];
}


@end
