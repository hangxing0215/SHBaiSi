//
//  SHRecommendUserCell.m
//  宋航百思不得姐01
//
//  Created by admin on 16/1/26.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SHRecommendUserCell.h"
#import "SHRecommendUser.h"
#import <UIImageView+WebCache.h>
@interface SHRecommendUserCell()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *guanzhuBtn;

@end
@implementation SHRecommendUserCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setUser:(SHRecommendUser *)user
{
    _user = user;
    
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:user.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"] options:SDWebImageRetryFailed | SDWebImageLowPriority];
    self.screenNameLabel.text = user.screen_name;
    
    
    
    NSString *fansCountStr = nil;
    if (user.fans_count > 10000)
    {
        fansCountStr = [NSString stringWithFormat:@"%.1zd万人关注",user.fans_count / 10000.0];
        
    }
    else
    {
        fansCountStr = [NSString stringWithFormat:@"%lu人关注",user.fans_count];
    }
    
    self.fansCountLabel.text = fansCountStr;
    
}

@end
