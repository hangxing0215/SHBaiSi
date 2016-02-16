//
//  SHTopicAudioView.h
//  宋航百思不得姐01
//
//  Created by admin on 16/1/31.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SHTopic;
@interface SHTopicAudioView : UIView

/**topic*/
@property (nonatomic,strong)SHTopic *topic;

+ (instancetype)topicAudioView;

@end
