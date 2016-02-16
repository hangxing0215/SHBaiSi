//
//  SHPostWordViewController.m
//  宋航百思不得姐01
//
//  Created by admin on 16/2/3.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SHPostWordViewController.h"
#import "SHPlaceholderTextView.h"
#import "SHAddTagToolbar.h"
@interface SHPostWordViewController ()<UITextViewDelegate>
/**textView*/
@property (nonatomic,strong)SHPlaceholderTextView *placeholderTV;
/**toolBar*/
@property (nonatomic,strong)SHAddTagToolbar *bar;
@end

@implementation SHPostWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupNav];
    
    [self setupTextView];
    
    [self setupToolBar];
    
    
}
- (void)setupToolBar
{
    self.bar = [SHAddTagToolbar viewFromNib];
    self.bar.width = self.view.bounds.size.width;
    self.bar.y = self.view.bounds.size.height - self.bar.height;
    [self.view addSubview:self.bar];
    
    //给键盘添加通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}
- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.bar.transform = CGAffineTransformMakeTranslation(0,keyboardF.origin.y - SHScreenH);
}


- (void)setupNav
{
    self.title = @"发表段子";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发表" style:UIBarButtonItemStyleDone target:self action:@selector(post)];
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
    //强制刷新，获得颜色改变
    [self.navigationController.navigationBar layoutIfNeeded];

}

- (void)setupTextView
{
    SHPlaceholderTextView *placeholderTV = [[SHPlaceholderTextView alloc]init];
    placeholderTV.frame = self.view.bounds;
    placeholderTV.placeholder = @"这是一段占位文字";
    [self.view addSubview:placeholderTV];
    self.placeholderTV = placeholderTV;
    //self.placeholderTV.inputAccessoryView = [SHAddTagToolbar viewFromNib];
    self.placeholderTV.delegate = self;
}


#pragma mark <uitextviewdelegate>
- (void)textViewDidChange:(UITextView *)textView
{
    self.navigationItem.rightBarButtonItem.enabled = self.placeholderTV.hasText;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.view endEditing:YES];
}


- (void)cancel
{
     
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)post
{
    MyLogFunc;
}
- (void)viewWillAppear:(BOOL)animated
{
    [self.placeholderTV becomeFirstResponder];
}

@end
