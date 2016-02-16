//
//  SHTopicPictureView.h
//  宋航百思不得姐01
//
//  Created by admin on 16/1/29.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SHTopic;
@interface SHTopicPictureView : UIView

/**topic*/
@property (nonatomic,strong)SHTopic *topic;

+ (instancetype)topicPictureView;



@end
