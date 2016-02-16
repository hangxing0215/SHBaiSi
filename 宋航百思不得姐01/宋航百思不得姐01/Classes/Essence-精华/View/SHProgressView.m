//
//  SHProgressView.m
//  宋航百思不得姐01
//
//  Created by admin on 16/1/30.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SHProgressView.h"

@implementation SHProgressView

- (void)awakeFromNib
{
    //设置进度条的文字颜色
    self.progressLabel.textColor = [UIColor redColor];
    //设置进图条的圆角
    self.roundedCorners = 5;
}
- (void)setProgress:(CGFloat)progress animated:(BOOL)animated{
    [super setProgress:progress animated:animated];
    self.progressLabel.text = [NSString stringWithFormat:@"%.0f%%",progress * 100];
    
    
}

@end
