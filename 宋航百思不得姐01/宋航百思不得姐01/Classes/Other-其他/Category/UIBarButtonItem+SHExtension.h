//
//  UIBarButtonItem+SHExtension.h
//  宋航百思不得姐01
//
//  Created by admin on 16/2/1.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (SHExtension)
+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;
@end
