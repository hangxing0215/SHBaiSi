//
//  SHAddTagToolbar.m
//  宋航百思不得姐01
//
//  Created by admin on 16/2/3.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SHAddTagToolbar.h"
#import "SHAddTagViewController.h"
@class SHAddTagToolbar;
@interface SHAddTagToolbar()
@property (weak, nonatomic) IBOutlet SHAddTagToolbar *topView;

//存放所有标签
@property (nonatomic,strong)NSMutableArray *tagsLabel;

@property(nonatomic,strong)UIButton *addButton;

@end
@implementation SHAddTagToolbar

//设置添加按钮 因为只是加载一次 所以
- (void)awakeFromNib
{
    UIButton *addButton = [[UIButton alloc]init];
    
    [addButton setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    addButton.size = addButton.currentImage.size;
    addButton.x = SHTopicCellMargin;
    [addButton addTarget:self action:@selector(addTagButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:addButton];
    self.addButton = addButton;
}
- (void)addTagButtonClick:(UIButton *)button
{
    SHAddTagViewController *vc = [[SHAddTagViewController alloc]init];
    __weak typeof(self) weakSelf = self;
    [vc setTagsBlock:^(NSArray *tags) {
        [weakSelf createTagsLabel:tags];
    }];
    //找出控制器
    UINavigationController * navi = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController.presentedViewController;
        
    [navi pushViewController:vc animated:YES];
 
}
//创建标签
- (void)createTagsLabel:(NSArray *)tags
{
    for (int i = 0; i < tags.count; i++) {
        UILabel *tagLabel = [[UILabel alloc]init];
        
        tagLabel.backgroundColor = [UIColor blueColor];
        [tagLabel setText:tags[i]];
        tagLabel.font = [UIFont systemFontOfSize:14];
        //宽高
        [tagLabel sizeToFit];
        tagLabel.width += 2 * SHTopicCellMargin;
        tagLabel.height = 25;
        [self.tagsLabel addObject:tagLabel];
        [self.topView addSubview:tagLabel];
        
        //更新所有标签的位置
        if (i == 0) {
            //最前面的按钮
            tagLabel.x = 0;
            tagLabel.y = 0;
        }
        else
        {
            //其他标签按钮
            UILabel *lastTagLabel = self.tagsLabel[i - 1];
            //计算当前行左边的宽度
            CGFloat leftWidth = CGRectGetMaxX(lastTagLabel.frame) + SHTopicCellMargin;
            //计算当前行右边的宽度
            CGFloat rightWidth = self.topView.width - leftWidth;
            if (rightWidth >= tagLabel.width) {
                //按钮显示在当前行
                tagLabel.y = lastTagLabel.y;
                tagLabel.x = leftWidth;
            }
            else
            {
                //显示在下一行
                tagLabel.x = 0;
                tagLabel.y = CGRectGetMaxY(lastTagLabel.frame) + SHTopicCellMargin;
            }
        }

        
        
    }
    
    //最后一个标签按钮
    UIButton *lastTagLabel = [self.tagsLabel lastObject];
    CGFloat leftWidth = CGRectGetMaxX(lastTagLabel.frame) + SHTopicCellMargin;
    //更新textField的frame
    if (self.topView.width - leftWidth >= self.addButton.width) {
        self.addButton.y = lastTagLabel.y;
        self.addButton.x = leftWidth;
    }
    else
    {
        self.addButton.x = 0;
        self.addButton.y = CGRectGetMaxY(lastTagLabel.frame) + SHTopicCellMargin;
    }
}
///**
// * textField的文字宽度
// */
//- (CGFloat)textFieldTextWidth
//{
//    CGFloat textW = [self.textField.text sizeWithAttributes:@{NSFontAttributeName : self.textField.font}].width;
//    return MAX(100, textW);
//}
@end
