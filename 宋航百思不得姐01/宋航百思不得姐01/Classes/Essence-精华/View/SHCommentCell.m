//
//  SHCommentCell.m
//  宋航百思不得姐01
//
//  Created by admin on 16/2/2.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SHCommentCell.h"
#import "SHComment.h"
#import "SHUser.h"
#import <UIImageView+WebCache.h>

@class SHCommentCell;
@interface SHCommentCell()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sexImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *commentVoiceBtn;


@end






@implementation SHCommentCell
- (void)awakeFromNib
{
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
    
    self.commentVoiceBtn.hidden = YES;

    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}
- (IBAction)likeBtnClick:(id)sender
{
    MyLog(@"呵呵  你喜欢呀");
}

- (IBAction)commentVoiceBtnClick:(id)sender {
}


- (void)setComment:(SHComment *)comment
{
    _comment = comment;
    //图像
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:self.comment.user.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"] options:SDWebImageLowPriority | SDWebImageRetryFailed];
    //性别
    self.sexImageView.image = [self.comment.user.sex isEqualToString:SHUserSexFemale] ? [UIImage imageNamed:@"Profile_manIcon"] : [UIImage imageNamed:@"Profile_womanIcon"];
    //用户名
    self.userNameLabel.text = self.comment.user.username;
    //评论内容
    self.contentLabel.text = self.comment.content;
    if (self.comment.voiceuri.length) {
        self.commentVoiceBtn.hidden = NO;
    }
    //点赞数
    self.likeCountLabel.text = [NSString stringWithFormat:@"%zd",self.comment.like_count];
    
    
    
}
- (void)setFrame:(CGRect)frame
{
    frame.origin.x = SHTopicCellMargin;
    frame.size.width -= 2 * SHTopicCellMargin;
    
    [super setFrame:frame];
}


- (BOOL)canBecomeFirstResponder
{
    return YES;
}
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return NO;
}


@end
