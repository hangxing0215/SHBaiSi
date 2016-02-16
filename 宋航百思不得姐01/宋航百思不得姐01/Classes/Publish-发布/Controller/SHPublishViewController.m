//
//  SHPublishViewController.m
//  宋航百思不得姐01
//
//  Created by admin on 16/1/30.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SHPublishViewController.h"
#import "SHVerticalButton.h"
#import <POP.h>
#import "SHPostWordViewController.h"
#import "SHNavigationController.h"
static CGFloat const SHAnimationDelay = 0.1;
static CGFloat const SHSpringFactor = 10;
@interface SHPublishViewController ()

@end

@implementation SHPublishViewController

- (void)cancle
{
    [self cancelWithCompletionBlock:nil];
}
- (void)cancelWithCompletionBlock2:(void (^)())completionBlock
{
    // 让控制器的view不能被点击
    self.view.userInteractionEnabled = NO;
    
    int beginIndex = 2;
    
    for (int i = beginIndex; i<self.view.subviews.count; i++) {
        UIView *subview = self.view.subviews[i];
        
        // 基本动画
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        CGFloat centerY = subview.centerY + SHScreenH;
        // 动画的执行节奏(一开始很慢, 后面很快)
        //        anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(subview.centerX, centerY)];
        anim.beginTime = CACurrentMediaTime() + (i - beginIndex) * SHAnimationDelay;
        [subview pop_addAnimation:anim forKey:nil];
        
        // 监听最后一个动画
        if (i == self.view.subviews.count - 1) {
            [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
                [self dismissViewControllerAnimated:NO completion:nil];
                
                // 执行传进来的completionBlock参数
                //                if (completionBlock) {
                //                    completionBlock();
                //                }
                !completionBlock ? : completionBlock();
            }];
        }
    }
}

- (void)cancelWithCompletionBlock:(void(^)())completionBlock
{
    self.view.userInteractionEnabled = NO;
    CGFloat count = self.view.subviews.count;
    for (int i = 1; i < count; i++)
    {
        UIView *subView = self.view.subviews[i];
        
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        CGFloat centerY = subView.centerY + SHScreenH;
        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(subView.centerX, centerY)];
        anim.beginTime = CACurrentMediaTime() + (i - 1) * SHAnimationDelay;
        [subView pop_addAnimation:anim forKey:nil];

            if (i == self.view.subviews.count - 1) {
                [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
                    [self dismissViewControllerAnimated:NO completion:nil];
                    !completionBlock ? : completionBlock();

                }];
            }

    }
}


- (void)buttonClick:(UIButton *)button
{
    [self cancelWithCompletionBlock:^{
        if (button.tag == 0) {
            MyLog(@"发视频");
        } else if (button.tag == 1) {
            MyLog(@"发图片");
        }else if (button.tag == 2)
        {
            SHPostWordViewController *postWordVC = [[SHPostWordViewController alloc]init];
            SHNavigationController *navi = [[SHNavigationController alloc]initWithRootViewController:postWordVC];
            
           UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
            [rootViewController presentViewController:navi animated:YES completion:nil];
            MyLog(@"发段子");
        }
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self cancle];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //刚开始进来不让用户点击界面
    self.view.userInteractionEnabled = NO;
    NSArray *images = @[@"publish-video",@"publish-picture",@"publish-text",@"publish-audio",@"publish-review",@"publish-offline"];
    NSArray *titles = @[@"发视频",@"发图片",@"发段子",@"发声音",@"审帖",@"离线下载"];
    
    //中间的六个按钮
    int maxCols = 3;
    CGFloat buttonW = 72;

    CGFloat buttonH = buttonW + 30;
    CGFloat buttonStartY = (SHScreenH - 2 * buttonH) / 2;
    CGFloat buttonStartX = (SHScreenW - maxCols * buttonW) / (maxCols + 1);
    CGFloat xMargin = (SHScreenW - 2 * buttonStartX - maxCols * buttonW) / (maxCols - 1);
    for (int i = 0; i < images.count; i++) {
        SHVerticalButton *button = [[SHVerticalButton alloc]init];
        button.tag = i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        int row = i / maxCols;
        int col = i % maxCols;
        CGFloat buttonX = buttonStartX + col * (xMargin + buttonW);
        CGFloat buttonEndY = buttonStartY + row * buttonH;
        CGFloat buttonBeginY = buttonEndY - SHScreenH;
        
        //给按钮添加动画
        /**
         *  1.Core Animation的动画只能添加到layer上
         2.pop的动画能添加到任何对象
         3.pop的底层并非基于Core Animation,是基于CADisplayLink
         4.Core Animation的动画仅仅是表象 并不会真正修改对象的frame size等值
         5.pop的动画实际是修改对象的属性，真正的修改了对象的属性
         */
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.beginTime = CACurrentMediaTime() + 0.1 * (i + 1);
        anim.springBounciness = 20;
        anim.springSpeed = 20;
        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonBeginY,buttonW,buttonH)];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonEndY,buttonW,buttonH)];
        [button pop_addAnimation:anim forKey:nil];
        [self.view addSubview:button];
    }
    
    
    UIImageView *sloganView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"app_slogan"]];
    
    //app_slogan
    //给上面的   百思不得姐 标签添加动画
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    CGFloat centerX = SHScreenW * 0.5;
    CGFloat centerEndY = SHScreenH * 0.2;
    CGFloat centerBeginY = centerEndY - SHScreenH;
    anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerBeginY)];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerEndY)];
    anim.beginTime = CACurrentMediaTime() + images.count * SHAnimationDelay;
    anim.springBounciness = SHSpringFactor;
    anim.springSpeed = SHSpringFactor;
    [sloganView pop_addAnimation:anim forKey:nil];
    [self.view addSubview:sloganView];
    
    [anim setCompletionBlock:^(POPAnimation *anim, BOOL completed) {
        self.view.userInteractionEnabled = YES;
    }];
    
    
    
    
    //添加取消button
    UIButton *cancleBtn = [[UIButton alloc]init];
    cancleBtn.width = 295;
    cancleBtn.height = 42;
    cancleBtn.center = CGPointMake(SHScreenW / 2, SHScreenH * 0.9);
    [cancleBtn setBackgroundImage:[UIImage imageNamed:@"shareButtonCancel"] forState:UIControlStateNormal];
    [cancleBtn setBackgroundImage:[UIImage imageNamed:@"shareButtonCancelClick"] forState:UIControlStateHighlighted];
    [cancleBtn addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancleBtn];
    
    
    
}




@end
