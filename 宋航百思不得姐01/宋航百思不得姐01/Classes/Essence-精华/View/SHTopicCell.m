//
//  SHTopicCell.m
//  宋航百思不得姐01
//
//  Created by admin on 16/1/29.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SHTopicCell.h"
#import <UIImageView+WebCache.h>
#import "SHTopic.h"
#import "SHTopicPictureView.h"
#import "SHTopicAudioView.h"
#import "SHTopicVideoView.h"

#import "SHUser.h"
#import "SHComment.h"


@class SHTopicCell;
@interface SHTopicCell()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIImageView *sinaVImageView;
@property (weak, nonatomic) IBOutlet UILabel *text_Label;
//中间的图片视图属性
@property (nonatomic ,weak)SHTopicPictureView *topicPictureView;
//中间的音频视图属性
@property (nonatomic ,weak)SHTopicAudioView *topicAudioView;
//中间的视频视图属性
@property (nonatomic ,weak)SHTopicVideoView *topicVideoView;
/**热门评论的占位父视图*/
@property (weak, nonatomic) IBOutlet UIView *topCmtPlaceHolderView;
/**最热评论的内容*/
@property (weak, nonatomic) IBOutlet UILabel *topCntContentLabel;





@end
@implementation SHTopicCell

+ (instancetype)cell
{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}

- (SHTopicPictureView *)topicPictureView
{
    if (_topicPictureView == nil) {
        SHTopicPictureView *pictureView = [SHTopicPictureView topicPictureView];
        [self.contentView addSubview:pictureView];
        _topicPictureView = pictureView;
    }
    return _topicPictureView;
}
- (SHTopicAudioView *)topicAudioView
{
    if (_topicAudioView == nil) {
        SHTopicAudioView *topicAudioView = [SHTopicAudioView topicAudioView];
        [self.contentView addSubview:topicAudioView];
        _topicAudioView = topicAudioView;
    }
    return _topicAudioView;
}
- (SHTopicVideoView *)topicVideoView
{
    if (_topicVideoView == nil) {
        SHTopicVideoView *topicVideoView = [SHTopicVideoView topicVideoView];
        [self.contentView addSubview:topicVideoView];
        _topicVideoView = topicVideoView;
    }
    return _topicVideoView;
}


- (IBAction)dingButtonClick:(id)sender {
}
- (IBAction)caiButtonClick:(id)sender {
}
- (IBAction)shareButtonClick:(id)sender {
}
- (IBAction)commentButtonClick:(id)sender {
}
- (IBAction)followButtonClick:(id)sender {
}

- (void)awakeFromNib {
    
    UIImageView *bgView = [[UIImageView alloc]init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
    
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x = SHTopicCellMargin;
    frame.size.width -= 2 * SHTopicCellMargin;
//    frame.size.height -= SHTopicCellMargin;
    frame.size.height = self.topic.cellHeight - SHTopicCellMargin;
    frame.origin.y += SHTopicCellMargin;
    [super setFrame:frame];
}

- (void)setTopic:(SHTopic *)topic
{
    _topic = topic;

    //是否新浪会员
    self.sinaVImageView.hidden = !topic.isSinaV;
    //段子内容
    self.text_Label.text = topic.text;
    
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.headImageView.image = [image circleImage];
    }];

    self.screenNameLabel.text = topic.name;

    //创建的时间
    //调用相关方法 判断当前时间显示格式
    self.timeLabel.text = [NSString stringWithFormat:@"%@",topic.create_time];
    

    [self.dingButton setTitle:[NSString stringWithFormat:@"%lu",topic.ding] forState:UIControlStateNormal];

    [self setButtonTitle:self.dingButton count:topic.ding placeholder:@"顶"];
    [self setButtonTitle:self.caiButton count:topic.cai placeholder:@"踩"];
    [self setButtonTitle:self.shareButton count:topic.repost placeholder:@"分享"];
    [self setButtonTitle:self.commentButton count:topic.comment placeholder:@"评论"];
    
    //加入中间的视图
    if (topic.type == SHTopicTypePicture)
    {
        self.topicPictureView.hidden = NO;
        //把值传进去
        self.topicPictureView.topic = topic;
        //设置frame
        self.topicPictureView.frame = topic.pictureFrame;
        //其他两个隐藏
        self.topicAudioView.hidden = YES;
        self.topicVideoView.hidden = YES;
    }else if (topic.type == SHTopicTypeAudio)
    {

        self.topicAudioView.hidden = NO;
        
        self.topicAudioView.topic = topic;
        //设置frame
        self.topicAudioView.frame = topic.audioFrame;
        
        //其他两个隐藏
        self.topicPictureView.hidden = YES;
        self.topicVideoView.hidden = YES;
    }else if (topic.type == SHTopicTypeVideo)
    {
        self.topicVideoView.hidden = NO;
        self.topicVideoView.topic = topic;
        self.topicVideoView.frame = topic.videoFrame;
        
        //其他两个隐藏
        self.topicPictureView.hidden = YES;
        self.topicAudioView.hidden = YES;
    }else if (topic.type == SHTopicTypeWord)
    {
        self.topicPictureView.hidden = YES;
        self.topicAudioView.hidden = YES;
        self.topicAudioView.hidden = YES;
    }
    
    SHComment *comment = [self.topic.top_cmt firstObject];
    NSString *content = comment.content;
    NSString *username = comment.user.username;
    if (content)
    {
        self.topCmtPlaceHolderView.hidden = NO;
        self.topCntContentLabel.text = [NSString stringWithFormat:@"%@ : %@ ",username,content];
    }
    else
    {
        self.topCmtPlaceHolderView.hidden = YES;
    }
    
}
/**
 *  判断当前时间显示格式
 *
 */
- (NSString *)showTime:(SHTopic *)topic
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd HH-mm-ss";
    NSDate *fromDate = [formatter dateFromString:topic.create_time];
    NSDate *now = [NSDate date];
    //创建时间--》当前时间的差值
    //  NSDateComponents *compoments = [now daltaFrom:fromDate];
    
    
    /*
     
     今年
        今天
            一分钟内
                刚刚
            一小时内
                xx分钟前
        昨天
            昨天 22:45:15
        其他
            01-23 12:12:12
     非今年
     2014-02-18 00:00:00
     */
    

    if ([fromDate isThisYear])
    {
        if ([fromDate isToday])
        {

//            if (一分钟内) {
//                //            一分钟内
//                //            刚刚
//            }
//            else if (一小时内)
//            {
//                //            一小时内
//                //            xx分钟前
//            }
//            else
//            {
//                
//            }

        }
        else if ([fromDate isYesterday])
        {
//            昨天
//            昨天 22:45:15
        }
        else
        {
//            其他
//            01-23 12:12:12

        }
        
    }
    else
    {
        //     非今年
        //     2014-02-18 00:00:00
        
    }
    return @"";
}

- (void)setButtonTitle:(UIButton *)button count:(NSInteger )count placeholder:(NSString *)placeholder
{
    
    if (count > 10000) {
        placeholder = [NSString stringWithFormat:@"%.1f万",count / 10000.0];
    }
    else if (count > 1)
    {
        placeholder = [NSString stringWithFormat:@"%lu",count];
    }
    [button setTitle:placeholder forState:UIControlStateNormal];
}


@end
