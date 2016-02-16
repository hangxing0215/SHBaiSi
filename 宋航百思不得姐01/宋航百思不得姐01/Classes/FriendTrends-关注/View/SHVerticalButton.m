//
//  SHVerticalButton.m
//  宋航百思不得姐01
//
//  Created by admin on 16/1/27.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SHVerticalButton.h"

@implementation SHVerticalButton

- (void)setup
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat width = self.width;
    CGFloat height = self.width;
    
    self.imageView.frame = CGRectMake(x, y, width, height);
    
    self.titleLabel.frame = CGRectMake(0, self.imageView.height, width, self.height - height);
    
}

@end
