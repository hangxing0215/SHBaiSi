//
//  SHAddTagViewController.m
//  宋航百思不得姐01
//
//  Created by admin on 16/2/3.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SHAddTagViewController.h"
#import "SHTagButton.h"
#import "SHTagTextField.h"
#import <SVProgressHUD.h>
@interface SHAddTagViewController ()<UITextFieldDelegate>
/**在界面中间放一个view*/
@property (nonatomic,strong)UIView *contentView;
/**在其中加入一个textField*/
@property (nonatomic,strong)SHTagTextField *textField;
/**
 *  添加标签的按钮
 */
@property (nonatomic,strong)UIButton *addMarkButton;
/**所有的标签按钮*/
@property (nonatomic,strong)NSMutableArray *tagButtons;
@end

@implementation SHAddTagViewController

- (UIButton *)addMarkButton
{
 
    
    if (_addMarkButton == nil) {
        _addMarkButton = [[UIButton alloc]init];
        _addMarkButton.backgroundColor = [UIColor blueColor];
        _addMarkButton.x = SHTopicCellMargin;
        //_addMarkButton.y = CGRectGetMaxY(self.textField.frame);
        _addMarkButton.width = self.contentView.width - 2 * SHTopicCellMargin;
        _addMarkButton.height = 30;
        _addMarkButton.titleLabel.font = [UIFont systemFontOfSize:14];
        //文字左对齐
        _addMarkButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_addMarkButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_addMarkButton];
    }
    return _addMarkButton;
}
- (NSMutableArray *)tagButtons
{
    if (_tagButtons == nil) {
        _tagButtons = [NSMutableArray array];
    }
    return _tagButtons;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupContentView];
    
    [self setupTextField];
}

- (void)setupContentView
{
    self.contentView = [[UIView alloc]init];
    self.contentView.backgroundColor = [UIColor lightGrayColor];
    self.contentView.x = SHTopicCellMargin;
    self.contentView.y = 64 + SHTopicCellMargin;
    self.contentView.width = SHScreenW - 2 * self.contentView.x;
    self.contentView.height = SHScreenH;
    [self.view addSubview:self.contentView];
}
- (void)setupTextField
{
    self.textField = [[SHTagTextField alloc]init];
    __weak typeof(self) weakSelf = self;
    self.textField.deleteBlock = ^{
        if (weakSelf.textField.hasText) return ;
        [weakSelf tagButtonClick:[weakSelf.tagButtons lastObject]];
    };
    
    self.textField.delegate = self;
    self.textField.width = SHScreenW;
    self.textField.height = 25;
    self.textField.placeholder = @"多个标签用逗号或者换行隔开";
    [self.textField addTarget:self action:@selector(textDidChange) forControlEvents:UIControlEventEditingChanged];
    
    [self.contentView addSubview:self.textField];
}
//文字改变调用的方法
- (void)textDidChange
{
    if (self.textField.hasText)
    {
        self.addMarkButton.hidden = NO;
        self.addMarkButton.y = CGRectGetMaxY(self.textField.frame) + SHTopicCellMargin;
        [_addMarkButton setTitle:[NSString stringWithFormat:@"添加标签：%@",self.textField.text] forState:UIControlStateNormal];
    }
    else
    {
        self.addMarkButton.hidden = YES;
    }
    
    //更新标签和文本的frame
    [self updateTagButtonFrame];
}

- (void)setupNav
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"添加标签";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
}
//点击完成按钮返回，并且拿到按钮数组中的文字

- (void)done
{
   
    NSArray *tags = [self.tagButtons valueForKeyPath:@"currentTitle"];
    //block 传值
    !self.tagsBlock ? : self.tagsBlock(tags);
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.textField becomeFirstResponder];
}
/**
 *  添加标签按钮点击
 */
- (void)addButtonClick
{
    
    //如果标签按钮的个数等于五就不能再添加了
    if (self.tagButtons.count == 5) {
        
        [SVProgressHUD showImage:[UIImage imageNamed:@"commentLikeButton"] status:@"最大的输入个数是五"];
        return;
    }
    
    
    //添加一个标签按钮
    SHTagButton *tagButton = [[SHTagButton alloc]init];
    [tagButton addTarget:self action:@selector(tagButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [tagButton setTitle:self.textField.text forState:UIControlStateNormal];
    tagButton.height = self.textField.height;
    tagButton.backgroundColor = [UIColor blueColor];
    [self.contentView addSubview:tagButton];
    [self.tagButtons addObject:tagButton];
    
    //更新标签的frame
    [self updateTagButtonFrame];
    //清空textField的文字
    self.textField.text = nil;
    //隐藏按钮
    self.addMarkButton.hidden = YES;
    
    
    
}
/**
 *  专门用来更新标签按钮的frame
 */
- (void)updateTagButtonFrame
{
    //更新标签按钮的frame
    for (int i = 0; i < self.tagButtons.count; i++) {
        SHTagButton *tagButton = self.tagButtons[i];
        if (i == 0) {
            //最前面的按钮
            tagButton.x = 0;
            tagButton.y = 0;
        }
        else
        {
            //其他标签按钮
            SHTagButton *lastTagButton = self.tagButtons[i - 1];
            //计算当前行左边的宽度
            CGFloat leftWidth = CGRectGetMaxX(lastTagButton.frame) + SHTopicCellMargin;
            //计算当前行右边的宽度
            CGFloat rightWidth = self.contentView.width - leftWidth;
            if (rightWidth >= tagButton.width) {
                //按钮显示在当前行
                tagButton.y = lastTagButton.y;
                tagButton.x = leftWidth;
            }
            else
            {
                //显示在下一行
                tagButton.x = 0;
                tagButton.y = CGRectGetMaxY(lastTagButton.frame) + SHTopicCellMargin;
            }
        }
    }
    
    //最后一个标签按钮
    UIButton *lastTagButton = [self.tagButtons lastObject];
    CGFloat leftWidth = CGRectGetMaxX(lastTagButton.frame) + SHTopicCellMargin;
    //更新textField的frame
    if (self.contentView.width - leftWidth >= [self textFieldTextWidth]) {
        self.textField.y = lastTagButton.y;
        self.textField.x = leftWidth;
    }
    else
    {
        self.textField.x = 0;
        self.textField.y = CGRectGetMaxY(lastTagButton.frame) + SHTopicCellMargin;
    }
    
}
/**
 * textField的文字宽度
 */
- (CGFloat)textFieldTextWidth
{
    CGFloat textW = [self.textField.text sizeWithAttributes:@{NSFontAttributeName : self.textField.font}].width;
    return MAX(100, textW);
}
/**
 *  标签按钮的点击
 */
- (void)tagButtonClick:(SHTagButton *)tagButton
{
    [tagButton removeFromSuperview];
    [self.tagButtons removeObject:tagButton];
    
    //重新更新所有标签
    [UIView animateWithDuration:0.4 animations:^{
        
        [self updateTagButtonFrame];
    }];
}





























@end
