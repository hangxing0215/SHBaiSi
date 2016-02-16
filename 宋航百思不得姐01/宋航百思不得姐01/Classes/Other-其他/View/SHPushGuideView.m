//
//  SHPushGuideView.m
//  宋航百思不得姐01
//
//  Created by admin on 16/1/28.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SHPushGuideView.h"

@implementation SHPushGuideView

- (IBAction)removePushGuideView:(id)sender
{
    [self removeFromSuperview];
}


+  (instancetype)guideView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil]firstObject];
}

+ (void)show
{
    UIWindow *window = [UIApplication sharedApplication ].keyWindow;
    //获取当前版本号
    NSString *key = @"CFBundleShortVersionString";
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    NSString *sandBoxVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    if (![currentVersion isEqualToString:sandBoxVersion] ) {
        //指导用户的界面
        SHPushGuideView *pushGuideView = [SHPushGuideView guideView ];
        pushGuideView.frame = window.bounds;
        [window addSubview:pushGuideView];
        //同时把这个存入沙盒
        [[NSUserDefaults standardUserDefaults] setValue:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }

}

@end
