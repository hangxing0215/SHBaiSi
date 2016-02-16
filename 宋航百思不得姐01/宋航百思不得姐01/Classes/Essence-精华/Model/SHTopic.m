//
//  SHTopic.m
//  宋航百思不得姐01
//
//  Created by admin on 16/1/28.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SHTopic.h"
#import "SHComment.h"
#import <MJExtension.h>
#import "SHUser.h"
#import "SHComment.h"

@implementation SHTopic
{
    CGFloat _cellHeight;
    CGRect _pictureFrame;
    CGRect _audioFrame;
}
+ (NSDictionary *)objectClassInArray
{
    return @{@"top_cmt" : @"SHComment"};
}


- (CGFloat)cellHeight
{
    if (!_cellHeight)
    {
        //文字最大尺寸
        CGSize maxSize = CGSizeMake([[UIScreen mainScreen]bounds].size.width  - 4 * SHTopicCellMargin, MAXFLOAT);
        //文字的高度
        CGFloat textH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]} context:nil].size.height;
        //cell 高度
        _cellHeight = SHTopicCellTextY + textH ;
        if ([self.text containsString:@"\n"])
        {
            _cellHeight += 20;
        }
        //根据段子类型  计算图片视图的宽高
        if (self.type == SHTopicTypePicture)
        {
            //图片显示出来的宽度
            CGFloat pictureW = maxSize.width;
            //图片显示出来的高度
            CGFloat pictureH = pictureW * self.height / self.width;
            
            
            //判断   如果是大图就压缩图片的高度  同时设置它是不是大图属性为yes
            if (pictureH > SHTopicPictureViewMaxH) {
                pictureH = SHTopicPictureViewBreakH;
                self.bigPicture = YES;
            }
            
            
            //计算图片控件的 frame
            CGFloat pictureX = SHTopicCellMargin;
            CGFloat pictureY = SHTopicCellTextY + textH + SHTopicCellMargin;
            _pictureFrame = CGRectMake(pictureX, pictureY, pictureW, pictureH);
            
            _cellHeight += pictureH + SHTopicCellMargin;
        }
        else if (self.type == SHTopicTypeAudio)
        {
            //图片显示出来的宽度
            CGFloat audioW = maxSize.width;
            //图片显示出来的高度
            CGFloat audioH = audioW * self.height / self.width;

            //计算图片控件的 frame
            CGFloat audioX = SHTopicCellMargin;
            CGFloat audioY = SHTopicCellTextY + textH + SHTopicCellMargin;
            _audioFrame = CGRectMake(audioX, audioY, audioW, audioH);
            
            _cellHeight += audioH;
        }else if (self.type == SHTopicTypeVideo)
        {
            //图片显示出来的宽度
            CGFloat videoW = maxSize.width;
            //图片显示出来的高度
            CGFloat videoH = videoW * self.height / self.width;
            
            //计算图片控件的 frame
            CGFloat videoX = SHTopicCellMargin;
            CGFloat videoY = SHTopicCellTextY + textH + SHTopicCellMargin;
            _videoFrame = CGRectMake(videoX, videoY, videoW, videoH);
            
            _cellHeight += videoH;
        }
        SHComment *comment = [self.top_cmt firstObject];
        NSString *content = comment.content;
        NSString *username = comment.user.username;
        //如果有最热评论
        if (content)
        {
            CGFloat contentH = [[NSString stringWithFormat:@"%@ : %@ ",username,content] boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]} context:nil].size.height;
            _cellHeight += SHTopicCellMargin + SHTopicTopCntLabelH + contentH + SHTopicCellMargin;
        }
        
        
        _cellHeight += SHTopicCellBottomBarH + SHTopicCellMargin;
        
    }
        return _cellHeight;
}

@end
