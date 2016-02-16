//
//  NSDate+SHExtension.m
//  宋航百思不得姐01
//
//  Created by admin on 16/1/29.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "NSDate+SHExtension.h"

@implementation NSDate (SHExtension)

- (NSDateComponents *)daltaFrom:(NSDate *)fromDate
{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit =
    NSCalendarUnitYear |
    NSCalendarUnitMonth|
    NSCalendarUnitDay|
    NSCalendarUnitHour|
    NSCalendarUnitMinute|
    NSCalendarUnitSecond;
    
    return  [calendar components:unit fromDate:fromDate toDate:self options:0];

}
- (BOOL)isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *nowDate = [NSDate date];
    NSCalendarUnit uint = NSCalendarUnitYear;
    NSDateComponents *comps = [calendar components:uint fromDate:self toDate:nowDate options:0];
    return comps.year == 0;
}
- (BOOL)isToday
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    NSString *nowString = [formatter stringFromDate:[NSDate date]];
    NSString *selfString = [formatter stringFromDate:self];
    return [nowString isEqualToString:selfString];
}
- (BOOL)isYesterday
{
    NSDateFormatter *formmater = [[NSDateFormatter alloc]init];
    formmater.dateFormat = @"yyyy-MM-dd";
    NSDate *nowDate = [formmater dateFromString:[formmater stringFromDate:[NSDate date]]];
    NSDate *selfDate = [formmater dateFromString:[formmater stringFromDate:self]];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit uint = NSCalendarUnitYear | NSCalendarUnitMonth  | NSCalendarUnitDay;
    NSDateComponents *comps = [calendar components:uint fromDate:selfDate toDate:nowDate options:0];
    
    return comps.year == 0 && comps.month == 0 && comps.day == 1;
    
}

@end
