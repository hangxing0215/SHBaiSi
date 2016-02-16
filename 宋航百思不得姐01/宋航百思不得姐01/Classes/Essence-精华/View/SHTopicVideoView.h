//
//  SHTopicVideoView.h
//  宋航百思不得姐01
//
//  Created by admin on 16/2/1.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SHTopic;
@interface SHTopicVideoView : UIView

/**topic*/
@property (nonatomic,strong)SHTopic *topic;

+ (instancetype)topicVideoView;

@end
