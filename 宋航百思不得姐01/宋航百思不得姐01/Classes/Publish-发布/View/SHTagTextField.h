//
//  SHTagTextField.h
//  宋航百思不得姐01
//
//  Created by admin on 16/2/4.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHTagTextField : UITextField
/**block 按删除键后*/
@property (nonatomic,copy)void (^deleteBlock)() ;

@end
