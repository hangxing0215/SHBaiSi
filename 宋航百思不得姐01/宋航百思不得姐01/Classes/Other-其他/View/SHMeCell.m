//
//  SHMeCell.m
//  宋航百思不得姐01
//
//  Created by admin on 16/2/3.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SHMeCell.h"

@implementation SHMeCell

- (void)awakeFromNib {

}

- (void)drawRect:(CGRect)rect
{
    [[UIImage imageNamed:@"navigationbarBackgroundWhite"] drawInRect:rect];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.width = 35;
    self.imageView.height = 35;
    self.imageView.center = CGPointMake(40, self.height * 0.5);
}

@end
