//
//  UIImage+SHExtension.m
//  宋航百思不得姐01
//
//  Created by admin on 16/2/2.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "UIImage+SHExtension.h"

@implementation UIImage (SHExtension)

- (UIImage *)circleImage
{
//    （1）开启图像上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
//    （2）获得图形上下文
    CGContextRef ref = UIGraphicsGetCurrentContext();
//    （3）添加一个圆
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ref, rect);
//    （4）裁剪
    CGContextClip(ref);
//    （5）讲图形画上去
    [self drawInRect:rect];
    //(6)得到图形
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    （7）关闭图形上下文
    UIGraphicsEndImageContext();
    
    return image;
}

@end
