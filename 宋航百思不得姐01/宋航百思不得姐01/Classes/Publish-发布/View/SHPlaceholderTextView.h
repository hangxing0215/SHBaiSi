//
//  SHPlaceholderTextView.h
//  宋航百思不得姐01
//
//  Created by admin on 16/2/3.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHPlaceholderTextView : UITextView
/** 占位文字 */
@property (nonatomic,copy) NSString *placeholder;
/**占位文字颜色*/
@property (nonatomic,strong)UIColor *placeholderColor;

@end
