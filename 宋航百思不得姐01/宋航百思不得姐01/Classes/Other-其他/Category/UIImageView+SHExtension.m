//
//  UIImageView+SHExtension.m
//  宋航百思不得姐01
//
//  Created by admin on 16/2/2.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "UIImageView+SHExtension.h"
#import <UIImageView+WebCache.h>
@implementation UIImageView (SHExtension)

- (void)circleImageViewWithUrl:(NSString *)url
{
    UIImage *placehoderImage = [[UIImage imageNamed:@"defaultUserIcon"] circleImage];
    //因为image有可能没有值，用占位图片  
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placehoderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.image = image ? [image circleImage] : placehoderImage;
    }];
}

@end
