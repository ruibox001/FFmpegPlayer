//
//  SystemUtils.h
//  Tronker
//
//  Created by 王声远 on 17/3/22.
//  Copyright © 2017年 Shenzhen Soffice Software. All rights reserved.
//

#import <Foundation/Foundation.h>

//随机数
#define IntArc4randomToIndex(x)         [SystemUtils getRandomNumber:0 t:x]
#define IntArc4randomFromToIndex(x,y)   [SystemUtils getRandomNumber:x t:y]

//手机屏幕
#define phoneWidth  [[UIScreen mainScreen] bounds].size.width
#define phoneHeight [[UIScreen mainScreen] bounds].size.height

//当前时间操作
#define sfDateComponent  [SystemUtils getCurrentDateDateComponents]
#define sfCurrentYear     [dateComponents year]
#define sfCurrentMonth    [dateComponents month]
#define sfCurrentDay      [dateComponents day]
#define sfCurrentHour     [dateComponents hour]
#define sfCurrentMinute   [dateComponents minute]
#define sfCurrentSecond   [dateComponents second]

@interface SystemUtils : NSObject

+ (int)getRandomNumber:(int)from t:(int)to;

+ (NSDateComponents *)getCurrentDateDateComponents;

//是否已经同意推送消息
+ (BOOL)enabelRemoteAlert;

//iOS跳转到App Store下载应用评分
+ (void)pushToAppStoreForTalk:(NSString *)appId;

//获取这个年月的第一天是星期几
+ (NSInteger (^)(NSInteger, NSInteger))firstWeekOfYearAndMonth;

//获取这个年的月有几天
+ (NSInteger (^)(NSInteger, NSInteger))daysOfYearAndMonth;

//查找这个year/month/day是星期几
+ (int)getWeekOfYear:(int)year month:(int)month day:(int)day;

+ (NSString *)getIOSVersion;

@end
