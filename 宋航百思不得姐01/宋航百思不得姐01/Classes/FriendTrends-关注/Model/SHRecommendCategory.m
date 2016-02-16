//
//  SHRecommendCategory.m
//  宋航百思不得姐01
//
//  Created by admin on 16/1/26.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SHRecommendCategory.h"

@implementation SHRecommendCategory


- (NSMutableArray *)users
{
    if (_users == nil)
    {
        _users = [NSMutableArray array];
        
    }
    return _users;
}
@end
