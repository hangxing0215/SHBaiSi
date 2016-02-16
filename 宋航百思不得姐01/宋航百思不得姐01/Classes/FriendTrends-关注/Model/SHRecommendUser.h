//
//  SHRecommendUser.h
//  宋航百思不得姐01
//
//  Created by admin on 16/1/26.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHRecommendUser : NSObject
//introduction : ,
//uid : 16369304,



//header : http://wimg.spriteapp.cn/profile/20151210101901.png,
@property (nonatomic,strong)NSString *header;
//gender : 0,
//is_vip : 0,
//fans_count : 5564,
@property (nonatomic,assign)NSInteger fans_count;
//tiezi_count : 73,
//is_follow : 0,
//screen_name : 百思哥哥
@property (nonatomic,strong)NSString *screen_name;



@end
