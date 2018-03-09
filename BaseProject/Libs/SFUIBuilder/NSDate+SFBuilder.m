//
//  NSDate+SF.m
//  DDG
//
//  Created by 王声远 on 17/3/21.
//  Copyright © 2017年 王声远. All rights reserved.
//

#import "NSDate+SFBuilder.h"
#import "NSDateFormatter+SFBuilder.h"
#import "SFUtils.h"

@implementation NSDate (SFBuilder)

//是否比某个时间大
- (BOOL (^)(NSDate *))dateBiggerThanDate {
    return ^(NSDate *date){
        if (!date) {
            return NO;
        }
        NSTimeInterval ms = [self timeIntervalSinceDate:date] >= 0;
        if (ms >= 0) {
            return YES;
        }
        return NO;
    };
}

- (NSString *(^)(NSString *))dateFormat {
    return ^(NSString *format){
        dateFormator.dateFormat = format;
        return [dateFormator stringFromDate:self];
    };
}

- (NSString *(^)())dateToView {
    return ^(){
        return [SFUtils formatDateToView:self];
    };
}

- (NSString *(^)(NSString *,NSTimeInterval))dateFormatSecond {
    return ^(NSString *f, NSTimeInterval second){
        NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:second];
        return detaildate.dateFormat(f);
    };
}

- (SFPropertyNSDateIntBlock)dateAddDays {
    return ^(NSInteger day) {
        return [self dateByAddingTimeInterval:60 * 60 * 24 * day];
    };
}

- (SFPropertyNSDateIntBlock)dateAddHours {
    return ^(NSInteger hour) {
        return [self dateByAddingTimeInterval:60 * 60 * hour];
    };
}

- (SFPropertyNSDateIntBlock)dateAddMinutes {
    return ^(NSInteger minute) {
        return [self dateByAddingTimeInterval:60 * minute];
    };
}

- (SFPropertyNSDateIntBlock)dateAddSeconds {
    return ^(NSInteger seconds) {
        return [self dateByAddingTimeInterval:seconds];
    };
}

- (NSTimeInterval (^)())dateSeconds{
    return ^(){
        return [self timeIntervalSince1970];
    };
}

- (NSDateComponents *(^)())getComponent {
    return ^(){
        NSCalendar* calendar = [NSCalendar currentCalendar];
        NSDateComponents* components = [calendar components:(NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitMinute | NSCalendarUnitHour | NSCalendarUnitWeekOfMonth | NSCalendarUnitEra) fromDate:self];
        return components;
    };
}

@end
