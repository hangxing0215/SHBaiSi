//
//  SHTopicViewController.h
//  宋航百思不得姐01
//
//  Created by admin on 16/1/29.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface SHTopicViewController : UITableViewController
/**请求帖子的类型  需要子类去实现*/
@property (nonatomic,assign)SHTopicType type;


@end
