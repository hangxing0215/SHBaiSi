//
//  SHTagTextField.m
//  宋航百思不得姐01
//
//  Created by admin on 16/2/4.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SHTagTextField.h"

@implementation SHTagTextField

- (void)insertText:(NSString *)text
{
    [super insertText:text];
    
    
    MyLogFunc;
}

- (void)deleteBackward
{
   
    MyLogFunc   ;
    
    
    !self.deleteBlock ? : self.deleteBlock();
    
     [super deleteBackward];
}

@end
