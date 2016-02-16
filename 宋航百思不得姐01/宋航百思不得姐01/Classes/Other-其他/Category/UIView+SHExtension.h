//
//  UIView+SHExtension.h
//  宋航百思不得姐01
//
//  Created by admin on 16/1/26.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SHExtension)
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;

@property (nonatomic, assign) CGSize size;

@property (nonatomic ,assign) CGFloat centerX;
@property (nonatomic,assign) CGFloat centerY;

- (BOOL)isShowingOnWindow;

+ (instancetype)viewFromNib;

@end
