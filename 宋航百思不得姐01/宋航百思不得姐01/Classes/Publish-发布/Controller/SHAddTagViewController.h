//
//  SHAddTagViewController.h
//  宋航百思不得姐01
//
//  Created by admin on 16/2/3.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHAddTagViewController : UIViewController
/** block传回按钮字符串数组 */
@property (nonatomic,copy) void(^tagsBlock)(NSArray *array);
@end
