//
//  SHTagButton.m
//  宋航百思不得姐01
//
//  Created by admin on 16/2/4.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SHTagButton.h"

@implementation SHTagButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:UIControlStateNormal];
        self.backgroundColor = [UIColor blueColor];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return self;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    
    [self sizeToFit];
    
    self.width += 3 * SHTopicCellMargin;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.x = SHTopicCellMargin;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + SHTopicCellMargin;
}

@end
