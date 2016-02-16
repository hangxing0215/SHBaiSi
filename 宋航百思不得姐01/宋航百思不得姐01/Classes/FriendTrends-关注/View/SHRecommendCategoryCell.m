//
//  SHRecommendCategoryCell.m
//  宋航百思不得姐01
//
//  Created by admin on 16/1/26.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SHRecommendCategoryCell.h"
#import "SHRecommendCategory.h"

@class SHRecommendCategoryCell;
@interface SHRecommendCategoryCell()
@property (weak, nonatomic) IBOutlet UIView *indicatorView;

@end


@implementation SHRecommendCategoryCell

- (void)awakeFromNib {
    
    self.backgroundColor = SHColor(244, 244, 244);
    
    //self.textLabel.textColor = SHColor(78, 78, 78);
    
    //self.textLabel.highlightedTextColor = SHColor(255, 0, 0);
    
    
    UIView *bg = [UIView new];
    bg.backgroundColor = SHColor(255, 255, 255);
    self.selectedBackgroundView = bg;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    
}

- (void)setCategory:(SHRecommendCategory *)category
{
    _category = category;
    
    self.textLabel.text = category.name;
    
}
//cell下面的线
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.textLabel.y = 2;
    self.textLabel.height = self.contentView.height - self.textLabel.y * 2;
}


/**
 *  重写选中状态，让左边的indicator显示
 */
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    self.indicatorView.hidden = ! selected;
    
    if (selected)
    {
        self.textLabel.textColor = SHColor(255, 0, 0);
    }
    else
    {
        self.textLabel.textColor = SHColor(78, 78, 78);
    }

}

@end
