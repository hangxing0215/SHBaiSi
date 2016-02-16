//
//  SHTopicPictureView.m
//  宋航百思不得姐01
//
//  Created by admin on 16/1/29.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SHTopicPictureView.h"
#import <UIImageView+WebCache.h>
#import "SHShowPictureViewController.h"
//包装过的进度条
#import "SHProgressView.h"
#import "SHTopic.h"

@class SHTopicPictureView;
@interface SHTopicPictureView()
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
@property (weak, nonatomic) IBOutlet UIImageView *gifImageView;

@property (weak, nonatomic) IBOutlet UIButton *seeBigPictureBtn;
@property (weak, nonatomic) IBOutlet SHProgressView *progressView;


@end

@implementation SHTopicPictureView
- (IBAction)seeBigPictureBtnClick:(id)sender {
}

+ (instancetype)topicPictureView
{
    return  [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
}

- (void)setTopic:(SHTopic *)topic
{
    _topic = topic;
    
   //设置进度条
    [self.pictureView sd_setImageWithURL:[NSURL URLWithString:topic.image1] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden = NO;
        CGFloat progress = receivedSize / expectedSize * 1.0;
        [self.progressView setProgress:progress animated:YES];

        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
        
        if (topic.isBigPicture)
        {
        
            //解决长大图的缩略图
            //开启图形上下文
            UIGraphicsBeginImageContextWithOptions(topic.pictureFrame.size, YES, 0.0);
            
            //讲下载好的图片画上去
            CGFloat pictureW = self.pictureView.width;
            CGFloat pictureH = pictureW * topic.height / topic.width;
            [image drawInRect:CGRectMake(0, 0, pictureW, pictureH)];
            
            //把画好的图片赋值给图片
            self.pictureView.image = UIGraphicsGetImageFromCurrentImageContext();
            //结束上下文
            UIGraphicsEndPDFContext();
        }
        
        
        
    }];
    
    //根据是不是gif 判断是否显示GIF标签
    NSString *extension = topic.image1.pathExtension;
    self.gifImageView.hidden = ![extension.lowercaseString isEqualToString:@"gif"];
    
    //根据是不是大图来调节高度
    if (topic.isBigPicture) {
        self.seeBigPictureBtn.hidden = NO;
    }
    else
    {
        self.seeBigPictureBtn.hidden = YES;
    }
    
    
}
- (void)awakeFromNib
{
    //设置图片不进行自动伸缩
    self.autoresizingMask = UIViewAutoresizingNone;
    

    
    //给图片添加监听器
    self.pictureView.userInteractionEnabled = YES;
    [self.pictureView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showPicture)]];
}
- (void)showPicture
{
    MyLogFunc;
    
    SHShowPictureViewController *vc = [[SHShowPictureViewController alloc]init];
    //把模型传过去
    vc.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:YES completion:nil];
}
@end
