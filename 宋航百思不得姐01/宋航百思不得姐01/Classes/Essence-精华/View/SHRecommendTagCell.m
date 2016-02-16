//
//  SHRecommendTagCell.m
//  宋航百思不得姐01
//
//  Created by admin on 16/1/27.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SHRecommendTagCell.h"
#import "SHRecommendTag.h"
#import <UIImageView+WebCache.h>
@interface SHRecommendTagCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageListImageView;
@property (weak, nonatomic) IBOutlet UILabel *themeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subNumberLabel;

@end
@implementation SHRecommendTagCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setRecommendTag:(SHRecommendTag *)recommendTag
{
    _recommendTag = recommendTag;
    
    
    [self.imageListImageView sd_setImageWithURL:[NSURL URLWithString:recommendTag.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"] options:SDWebImageLowPriority | SDWebImageRetryFailed];
    self.themeNameLabel.text = recommendTag.theme_name;
    
    NSString *subNumberStr = nil;
    if (recommendTag.sub_number > 10000)
    {
        subNumberStr = [NSString stringWithFormat:@"%.1zd万人关注",recommendTag.sub_number / 10000.0];
    }
    else
    {
        subNumberStr = [NSString stringWithFormat:@"%lu人关注",recommendTag.sub_number];
    }
    self.subNumberLabel.text = subNumberStr;
    
}

- (void)setFrame:(CGRect)frame
{
    
    frame.origin.x -= 10;
    frame.size.height -= 1;
    [super setFrame:frame];
}

@end
