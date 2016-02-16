//
//  SHRecommendTag.h
//  宋航百思不得姐01
//
//  Created by admin on 16/1/27.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHRecommendTag : NSObject
//
//"theme_id": "148",
//"theme_name": "婚礼",
@property (nonatomic,strong)NSString *theme_name;

//"image_list": "http:%/%/img.spriteapp.cn%/ugc%/2014%/12%/08%/192523_53386.png",
@property (nonatomic,strong)NSString *image_list;


//"sub_number": "19814",
@property (nonatomic,assign)NSInteger sub_number;
//"is_sub": 0,
//"is_default": 0


@end
