//
//  SHLoginRegisterViewController.m
//  宋航百思不得姐01
//
//  Created by admin on 16/1/27.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SHLoginRegisterViewController.h"
#import "SHTopWindow.h"
@interface SHLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberText;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *registerViewConstraint;



@property (weak, nonatomic) IBOutlet UIImageView *bgView;


@end

@implementation SHLoginRegisterViewController
- (IBAction)backToFriendsView:(id)sender
{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self dismissViewControllerAnimated:YES completion:nil];
}
static int loginOrRegisterNum = 0;
- (IBAction)clickLoginOrRegisterBtn:(UIButton *)sender
{
    //处理切换注册登录的键盘不下去bug
    [self.view endEditing:YES];
    if (loginOrRegisterNum % 2 == 0)
    {
        self.loginViewConstraint.constant -= self.view.bounds.size.width;
        [UIView animateWithDuration:0.5 animations:^{
            [self.view layoutIfNeeded];
        }];
        [sender setTitle:@"已有账号？" forState:UIControlStateNormal];
    }
    else
    {
        self.loginViewConstraint.constant += self.view.bounds.size.width;
        [UIView animateWithDuration:0.5 animations:^{
            [self.view layoutIfNeeded];
        }];
        [sender setTitle:@"注册账号" forState:UIControlStateNormal];
    }
    loginOrRegisterNum++;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [SHTopWindow hide];
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    
    
    [self.view insertSubview:self.bgView atIndex:0];
    NSLog(@"%f",self.view.bounds.size.width);
    self.registerViewConstraint.constant = self.view.bounds.size.width;
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
