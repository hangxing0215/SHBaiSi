//
//  SHText.m
//  宋航百思不得姐01
//
//  Created by admin on 16/1/27.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SHText.h"
#define SHPlaceholderLabelColor @"_placeholderLabel.textColor"
@implementation SHText

//重写  用kvc 改变文本颜色
- (void)awakeFromNib
{
    [self setValue:[UIColor grayColor] forKeyPath:SHPlaceholderLabelColor];
    self.tintColor = self.textColor;
}

- (BOOL)becomeFirstResponder
{
    
    [self setValue:self.textColor forKeyPath:SHPlaceholderLabelColor];
    return [super becomeFirstResponder];
    
    
}
- (BOOL)resignFirstResponder
{
    [self setValue:[UIColor grayColor] forKeyPath:SHPlaceholderLabelColor];
   return  [super resignFirstResponder];
    
    
}

@end
