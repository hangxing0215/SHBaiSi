//
//  SHTopic.h
//  宋航百思不得姐01
//
//  Created by admin on 16/1/28.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHTopic : NSObject

/**id*/
@property (nonatomic,strong)NSString *id;


/**名称*/
@property (nonatomic,strong)NSString *name;
/**图像*/
@property (nonatomic,strong)NSString *profile_image;
/**发帖时间*/
@property (nonatomic,strong)NSString *create_time;
/**文字内容*/
@property (nonatomic,strong)NSString *text;
/**顶的数量*/
@property (nonatomic,assign)NSInteger ding;
/**踩得数量*/
@property (nonatomic,assign)NSInteger cai;
/**转发的数量*/
@property (nonatomic,assign)NSInteger repost;
/**评论的数量*/
@property (nonatomic,assign)NSInteger comment;

/**是不是新浪会员*/
@property (nonatomic,assign,getter=isSinaV)BOOL sina_v;


/**t图片的宽度*/
@property (nonatomic,assign)NSInteger width;
/**图片的高度*/
@property (nonatomic,assign)NSInteger height;
/**图片的小图路径*/
@property (nonatomic,strong)NSString *image0;
/**图片的大图路径*/
@property (nonatomic,strong)NSString *image2;
/**图片的中图路径*/
@property (nonatomic,strong)NSString *image1;

/**类型*/
@property (nonatomic,assign)SHTopicType type;


/**图片视图的frame*/
@property (nonatomic,assign,readonly)CGRect pictureFrame;

/**
 *  额外属性
 */
/**cell 的高度*/
@property (nonatomic,assign,readonly)CGFloat cellHeight;

/**是不是大图*/
@property (nonatomic,assign,getter=isBigPicture)BOOL bigPicture;

/**音频视图的frame*/
@property (nonatomic,assign,readonly)CGRect audioFrame;
/**音频播放时长*/
@property (nonatomic,assign)NSInteger voicetime;
/**播放次数*/
@property (nonatomic,assign)NSInteger playcount;
/**音频播放地址*/
@property (nonatomic,strong)NSString *voiceuri;

/**视频视图的frame*/
@property (nonatomic,assign,readonly)CGRect videoFrame;
/**视频播放时长*/
@property (nonatomic,assign)NSInteger videotime;


/**最热评论(其中是SHComment模型)*/
@property (nonatomic,strong)NSArray *top_cmt;



@end
