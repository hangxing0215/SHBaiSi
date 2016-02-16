//
//  SHMeFooterView.m
//  宋航百思不得姐01
//
//  Created by admin on 16/2/3.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SHMeFooterView.h"
#import <AFNetworking.h>
#import "SHMeFooter.h"
#import <MJExtension.h>
#import <SDWebImage/UIButton+WebCache.h>
#import "SHSquareButton.h"
#import "SHWebViewController.h"
@implementation SHMeFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"square";
        params[@"c"] = @"topic";

        // 发送请求
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
            
            NSArray *array = [SHMeFooter mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];

            //设置cell内容
            [self setupSquare:array];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {

        }];

    }
    
    return self;
}

- (void)setupSquare:(NSArray *)array
{
    MyLog(@"%lu",array.count);
    NSInteger maxCols = 4;
    NSInteger buttonW = SHScreenW / maxCols;
    NSInteger buttonH = buttonW;
    for (int i = 0; i < array.count; i++)
    {
        SHMeFooter *square = array[i];
        
        SHSquareButton *button = [SHSquareButton buttonWithType:UIButtonTypeCustom];
        
        button.square = array[i];
        [button addTarget: self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        int col = i / maxCols;
        int row = i % maxCols;
        button.width = buttonW;
        button.height = buttonH;
        button.x = col * buttonW;
        button.y = row * buttonH;
        
        [self addSubview:button];
    }
    NSInteger rows = (array.count + maxCols - 1) / maxCols;
    self.height  = rows * buttonH;
    [self setNeedsDisplay];
}


- (void)buttonClick:(SHSquareButton *)button
{
    
    MyLog(@"%@",button.square.name);
    
    //如果URL的前缀不是http:  直接return
    if(![button.square.url hasPrefix:@"http:"]) return;
    
    //获取navigation
    UITabBarController *tabBarVc =  (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    SHWebViewController *vc = [[SHWebViewController alloc]init];
    vc.url = button.square.url;
    vc.title = button.square.name;
    UINavigationController *navi = tabBarVc.selectedViewController;
    [navi pushViewController:vc animated:YES];
    
    
    
}
//设置背景
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    [[UIImage imageNamed:@"comment-bar-bg"] drawInRect:rect];
    
}

@end
