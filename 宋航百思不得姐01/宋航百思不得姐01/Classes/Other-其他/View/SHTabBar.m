//
//  SHTabBar.m
//  宋航百思不得姐01
//
//  Created by admin on 16/1/25.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SHTabBar.h"
#import "SHPublishViewController.h"
@interface SHTabBar ()

@property (nonatomic,weak)UIButton *publishButton;

@end

@implementation SHTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
        //添加自定义的按钮
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton addTarget:self action:@selector(showPublishViewController) forControlEvents:UIControlEventTouchUpInside];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [self addSubview:publishButton];
        self.publishButton = publishButton;
        
        
        
        
        
    }
    return self;
}
UIWindow *window;
//点击加好按钮弹出上面的视图
- (void)showPublishViewController
{
//    window = [[UIWindow alloc]init];
//    window.backgroundColor = [[UIColor redColor]colorWithAlphaComponent:0.5];
//    window.frame = self.window.bounds;
//    window.hidden = NO;
    
    SHPublishViewController *publishVC = [[SHPublishViewController alloc]init];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:publishVC animated:NO completion:nil];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //设置frame
    self.publishButton.bounds = CGRectMake(0, 0, self.publishButton.currentBackgroundImage.size.width, self.publishButton.currentBackgroundImage.size.height);
    self.publishButton.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
    
    CGFloat buttonY = 0;
    CGFloat buttonW = self.bounds.size.width / 5.0;
    CGFloat buttonH = self.bounds.size.height;
    NSInteger index = 0;
    //按钮是不是被点击
    static BOOL added = NO;
    
    for (UIControl *button in self.subviews)
    {
        if ([button isKindOfClass: NSClassFromString(@"UITabBarButton")])
        {
            CGFloat buttonX = buttonW * ((index > 1) ? (index + 1) : index);
            button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
            index++;
            
            if (added == NO)
            {
                [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
                
            }
        }
        
        
    }
    added = YES;
}
- (void)buttonClick
{
    [[NSNotificationCenter defaultCenter]postNotificationName:SHTabbarDidSelectNotifation object:nil userInfo:nil];
}

@end
