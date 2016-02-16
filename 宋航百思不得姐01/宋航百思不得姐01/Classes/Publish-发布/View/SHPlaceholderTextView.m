//
//  SHPlaceholderTextView.m
//  宋航百思不得姐01
//
//  Created by admin on 16/2/3.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SHPlaceholderTextView.h"

@implementation SHPlaceholderTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.alwaysBounceVertical = YES;
        self.font = [UIFont systemFontOfSize:14];
        self.placeholderColor = [UIColor grayColor];
        //添加通知
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

- (void)textDidChange
{
    

    
    //刷新
    [self setNeedsDisplay];
}

//把占位文字画到textView中
- (void)drawRect:(CGRect)rect {
    
    if (self.hasText) return;
    
    
    //调整rect
    rect.origin.x = 4;
    rect.origin.y = 7;
    rect.size.width -= 2 * rect.origin.x;
    
    
    
    
    NSMutableDictionary *attri = [NSMutableDictionary dictionary];
    attri[NSFontAttributeName] = self.font;
    attri[NSForegroundColorAttributeName] = self.placeholderColor;
    [self.placeholder drawInRect:rect withAttributes:attri];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    [self setNeedsDisplay];
}
- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    [self setNeedsDisplay];
}
- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    [self setNeedsDisplay];
}

- (void)deleteBackward
{
    [super deleteBackward];
    MyLogFunc;
}



@end
