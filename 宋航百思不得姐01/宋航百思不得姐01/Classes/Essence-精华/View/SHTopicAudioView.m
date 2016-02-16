//
//  SHTopicAudioView.m
//  宋航百思不得姐01
//
//  Created by admin on 16/1/31.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SHTopicAudioView.h"
#import "SHTopic.h"
#import <UIImageView+WebCache.h>
@class SHTopicAudioView;
@interface SHTopicAudioView()
@property (weak, nonatomic) IBOutlet UIImageView *audioImageView;

@property (weak, nonatomic) IBOutlet UILabel *playTimesLabel;
@property (weak, nonatomic) IBOutlet UILabel *audioTimeLabel;


@end


@implementation SHTopicAudioView

- (IBAction)playAudioButtonClick:(id)sender
{
    MyLogFunc;
}

+ (instancetype)topicAudioView
{
    return  [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
}

- (void)setTopic:(SHTopic *)topic
{
    _topic = topic;
    
    [self.audioImageView sd_setImageWithURL:[NSURL URLWithString:topic.image1 ] placeholderImage:[UIImage imageNamed:@"post_placeholderImage"] options:SDWebImageLowPriority | SDWebImageRetryFailed];
    
    self.playTimesLabel.text = [NSString stringWithFormat:@"%zd次播放",topic.playcount];
    //处理播放时长
    NSInteger minites = topic.voicetime / 60;
    NSInteger seconds = topic.voicetime % 60;
    
    
    self.audioTimeLabel.text = [NSString stringWithFormat:@"%.2lu:%.2lu",minites,seconds];
    
    
}

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
}

@end
