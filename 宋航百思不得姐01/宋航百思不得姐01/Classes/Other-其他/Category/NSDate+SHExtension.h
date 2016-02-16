//
//  NSDate+SHExtension.h
//  宋航百思不得姐01
//
//  Created by admin on 16/1/29.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (SHExtension)
/**
 *  某个时间到当期那时间相差的 年月日 时分秒
 * */
- (NSDateComponents *)daltaFrom:(NSDate *)fromDate;

/**
 *  是不是今年
 */
- (BOOL)isThisYear;
/**
 *  是不是今天
 */
- (BOOL)isToday;
/**
 *  是不是昨天
 */
- (BOOL)isYesterday;
@end
