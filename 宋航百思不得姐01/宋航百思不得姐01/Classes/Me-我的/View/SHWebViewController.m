//
//  SHWebViewController.m
//  宋航百思不得姐01
//
//  Created by admin on 16/2/3.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SHWebViewController.h"

@interface SHWebViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goBackBtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goFowardBtn;




@end

@implementation SHWebViewController
- (IBAction)goBackBtnClick:(id)sender
{
    [self.webView goBack];
}
- (IBAction)goFowardBtnClick:(id)sender
{
    [self.webView goForward];
}
- (IBAction)freshBtnClick:(id)sender
{
    [self.webView reload];
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    
    self.webView.delegate = self;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.goBackBtn.enabled = webView.canGoBack;
    self.goFowardBtn.enabled = webView.canGoForward;
}
@end
