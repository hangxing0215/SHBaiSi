//
//  SHComment.h
//  宋航百思不得姐01
//
//  Created by admin on 16/2/1.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SHUser;
@interface SHComment : NSObject
/**id*/
@property (nonatomic,strong)NSString *id;

/**音频文件的时长*/
@property (nonatomic,strong)NSString *voicetime;
/**音频地址*/
@property (nonatomic,strong)NSString *voiceuri;

/**评论文件的内容*/
@property (nonatomic,strong)NSString *content;
/**点赞的数量*/
@property (nonatomic,assign)NSInteger like_count;
/**用户*/
@property (nonatomic,strong)SHUser *user;



@end
