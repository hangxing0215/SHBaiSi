//
//  SHShowPictureViewController.m
//  宋航百思不得姐01
//
//  Created by admin on 16/1/30.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SHShowPictureViewController.h"
#import "SHTopic.h"
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>
@interface SHShowPictureViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic,strong)UIImageView *imageView;
@end

@implementation SHShowPictureViewController
- (IBAction)backBtnClick:(id)sender
{
    [self back];
}
- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)saveBtnClick:(id)sender
{
    if (self.imageView.image == nil) {
        [SVProgressHUD showErrorWithStatus:@"图片还未下载完毕"];
        
        return;
    }
    
    
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error)
    {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    }
    else
    {
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }
}

- (IBAction)shareBtnClick:(id)sender
{
    MyLogFunc;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    //造一个imageView放入到控制器中
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(back)]];
    [self.scrollView addSubview:imageView];
    self.imageView = imageView;
    //获取屏幕宽高
    CGFloat screenW = [[UIScreen mainScreen]bounds].size.width;
    CGFloat screenH = [[UIScreen mainScreen]bounds].size.height;
    //计算图片应该显示的宽高
    CGFloat pictureW = screenW;
    CGFloat pictureH = screenW * self.topic.height / self.topic.width;
    
    //根据图片的大小判断是怎么显示
    if (pictureH > screenH)
    {
        imageView.frame = CGRectMake(0, 0, pictureW, pictureH);
        self.scrollView.contentSize = CGSizeMake(0, pictureH);
    }
    else
    {
        imageView.size = CGSizeMake(pictureW, pictureH);
        imageView.centerY = screenH / 2;
    }
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.image1]];
    
    
    
}



@end
