//
//  SHTopicVideoView.m
//  宋航百思不得姐01
//
//  Created by admin on 16/2/1.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SHTopicVideoView.h"
#import "SHTopic.h"
#import <UIImageView+WebCache.h>
@class SHTopicVideoView;
@interface SHTopicVideoView()
@property (weak, nonatomic) IBOutlet UIImageView *videoImageView;
@property (weak, nonatomic) IBOutlet UILabel *playTimesLabel;
@property (weak, nonatomic) IBOutlet UILabel *videoTimeLabel;


@end
@implementation SHTopicVideoView
- (IBAction)videoBtnClick:(id)sender {
}


+ (instancetype)topicVideoView
{
    return  [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
}

- (void)setTopic:(SHTopic *)topic
{
    _topic = topic;
    
    [self.videoImageView sd_setImageWithURL:[NSURL URLWithString:topic.image1 ] placeholderImage:[UIImage imageNamed:@"post_placeholderImage"] options:SDWebImageLowPriority | SDWebImageRetryFailed];
    
    self.playTimesLabel.text = [NSString stringWithFormat:@"%zd次播放",topic.playcount];
    //处理播放时长
    NSInteger minites = topic.videotime / 60;
    NSInteger seconds = topic.videotime % 60;
    
    
    self.videoTimeLabel.text = [NSString stringWithFormat:@"%.2lu:%.2lu",minites,seconds];
    
    
}

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
}



@end
