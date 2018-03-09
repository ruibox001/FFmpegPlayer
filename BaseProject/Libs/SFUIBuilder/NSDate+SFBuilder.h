//
//  NSDate+SF.h
//  DDG
//
//  Created by 王声远 on 17/3/21.
//  Copyright © 2017年 王声远. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFUIBuilderDef.h"

#define dateFormatyyyyMMddHHmmss @"yyyy-MM-dd HH:mm:ss"
#define dateFormatyyyyMMdd @"yyyy-MM-dd"
#define dateFormatyyMMdd @"yy年MM月dd日"

#define currentDataWithFormat(x) [NSDate new].dateFormat(x)
#define instanceDate [NSDate new]

//date是毫秒，format格式化样式
#define formatToString(date,format) [SFUtils formatToStringWithObject:commonProp(date) withFormat:format]

@interface NSDate (SFBuilder)

- (BOOL (^)(NSDate *))dateBiggerThanDate ;

- (NSString *(^)(NSString *))dateFormat ;

#pragma mark - 格式化时间（刚刚、几分钟前,几小时前，几天前)
- (NSString *(^)())dateToView ;

- (NSString *(^)(NSString *,NSTimeInterval))dateFormatSecond ;

SF_NSDate_PROP(Int)dateAddDays;
SF_NSDate_PROP(Int)dateAddHours;
SF_NSDate_PROP(Int)dateAddMinutes;
SF_NSDate_PROP(Int)dateAddSeconds;

- (NSTimeInterval (^)())dateSeconds;

- (NSDateComponents *(^)()) getComponent;

@end
