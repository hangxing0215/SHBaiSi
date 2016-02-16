//
//  UIView+SHExtension.m
//  宋航百思不得姐01
//
//  Created by admin on 16/1/26.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "UIView+SHExtension.h"

@implementation UIView (SHExtension)

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}
- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}
- (CGFloat)centerX
{
    return self.center.x;
}
- (CGFloat)centerY
{
    return  self.center.y;
}





- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

-(CGSize)size
{
    return self.frame.size;
}

//判断控件是不是在主窗口
- (BOOL)isShowingOnWindow22
{
    UIWindow  *keyWindow = [UIApplication sharedApplication].keyWindow;
    //这一句的toView 些错误应该是他的superView
    CGRect newFrame = [keyWindow convertRect:self.frame toView:nil];
    CGRect winFrame = keyWindow.bounds;
    //主窗口和新窗口是不是有重叠
    BOOL intersects = CGRectIntersectsRect(newFrame, winFrame);
    
    MyLog(@"...........%d",(!self.isHidden && self.alpha > 0.01 && intersects && self.window == keyWindow));
    
   return !self.isHidden && self.alpha > 0.01 && intersects && self.window == keyWindow ;
    
}
/**
 小马哥
 */
- (BOOL)isShowingOnWindow
{
    // 主窗口
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    // 以主窗口左上角为坐标原点, 计算self的矩形框
    CGRect newFrame = [keyWindow convertRect:self.frame fromView:self.superview];
    CGRect winBounds = keyWindow.bounds;
    
    // 主窗口的bounds 和 self的矩形框 是否有重叠
    BOOL intersects = CGRectIntersectsRect(newFrame, winBounds);
    
    return !self.isHidden && self.alpha > 0.01 && self.window == keyWindow && intersects;
}

+ (instancetype)viewFromNib
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

@end
