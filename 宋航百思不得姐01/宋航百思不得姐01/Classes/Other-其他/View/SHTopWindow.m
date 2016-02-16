//
//  SHTopWindow.m
//  宋航百思不得姐01
//
//  Created by admin on 16/2/2.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SHTopWindow.h"

@implementation SHTopWindow
static UIWindow *window_;
+ (void)show
{
    window_.hidden = NO;
}
+ (void)hide
{
    window_.hidden = YES;
}
+ (void)initialize
{
    window_ = [[UIWindow alloc]init];
    //设置frame
    window_.frame = CGRectMake(0, 0, SHScreenW, 20);
    window_.backgroundColor = [UIColor redColor];
    //设置级别
    window_.windowLevel = UIWindowLevelAlert;
    //设置手势
    [window_ addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(windowClick)]];
}
+ (void)searchScrollViewInView:(UIView *)superview
{
    for (UIScrollView *subview in superview.subviews)
    {
        
        //判断一个控件是不是在窗口的frame中
        if ([subview isKindOfClass:[UIScrollView class]] && [subview isShowingOnWindow])
        {
            CGPoint offset = subview.contentOffset;
            offset.y = - subview.contentInset.top;
            
            [subview setContentOffset:offset animated:YES];
        }
        //继续查找子控件
        [self searchScrollViewInView:subview];
    }
}


+ (void)windowClick
{
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self searchScrollViewInView:window];
    
    
}





@end
