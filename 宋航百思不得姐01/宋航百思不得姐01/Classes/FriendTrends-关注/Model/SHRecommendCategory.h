//
//  SHRecommendCategory.h
//  宋航百思不得姐01
//
//  Created by admin on 16/1/26.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHRecommendCategory : NSObject

/**id*/
@property (nonatomic,assign)NSInteger id;
/**count*/
@property (nonatomic,assign)NSInteger count;
/**name*/
@property (nonatomic,copy)NSString *name;



//用户存储点击左边加载的数据
@property (nonatomic,strong)NSMutableArray *users;


//"total": 18,
@property (nonatomic,assign)NSInteger total;
//"next_page": 2,
@property (nonatomic,assign)NSInteger next_page;
//"total_page": 1
@property (nonatomic,assign)NSInteger total_page;

/**
 *  当前页码
 */
@property (nonatomic,assign)NSInteger currentPage;



@end
