//
//  SystemUtils.m
//  Tronker
//
//  Created by 王声远 on 17/3/22.
//  Copyright © 2017年 Shenzhen Soffice Software. All rights reserved.
//

#import "SystemUtils.h"
#import <sys/utsname.h>
#import <UIKit/UIKit.h>

@implementation SystemUtils

//获取随机数
+ (int)getRandomNumber:(int)from t:(int)to
{
    return (int)(from + (arc4random() % (to - from + 1)));
}

#pragma mark - 测量手机空间使用
+ (void)checkPhoneDiskSpace {
    NSString* path =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0];
    NSFileManager*fileManager= [[NSFileManager alloc]init];
    NSDictionary *fileSysAttributes = [fileManager attributesOfFileSystemForPath:path error:nil];
    NSNumber *freeSpace=[fileSysAttributes objectForKey:NSFileSystemFreeSize];
    NSNumber *totalSpace=[fileSysAttributes objectForKey:NSFileSystemSize];
    NSString *text=[NSString stringWithFormat:@"总大小:%0.2fBM/已占用%0.2fBM/剩余%0.2fBM",[totalSpace longLongValue]/1024.0/1024.0,([totalSpace longLongValue]-[freeSpace longLongValue])/1024.0/1024.0,[freeSpace longLongValue]/1024.0/1024.0];
    NSLog(@"空间信息：%@",text);
}

+ (NSString*)deviceMode
{
    // 需要#import "sys/utsname.h"
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    //CLog(@"%@",deviceString);
    
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    
    //CLog(@"NOTE: Unknown device type: %@", deviceString);
    
    return deviceString;
}

+ (NSDictionary *)getTodayDate
{
    
    //获取今天的日期
    NSDate *today = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = kCFCalendarUnitYear|kCFCalendarUnitMonth|kCFCalendarUnitDay;
    
    NSDateComponents *components = [calendar components:unit fromDate:today];
    NSString *year = [NSString stringWithFormat:@"%d", (int)[components year]];
    NSString *month = [NSString stringWithFormat:@"%02d", (int)[components month]];
    NSString *day = [NSString stringWithFormat:@"%02d", (int)[components day]];
    NSString * hour =[NSString stringWithFormat:@"%02d",(int)[components hour]];
    NSString * minute =[NSString stringWithFormat:@"%02d",(int)[components minute]];
    NSString * second =[NSString stringWithFormat:@"%02d",(int)[components second]];
    
    
    NSMutableDictionary *todayDic = [[NSMutableDictionary alloc] init];
    [todayDic setObject:year forKey:@"year"];
    [todayDic setObject:month forKey:@"month"];
    [todayDic setObject:day forKey:@"day"];
    [todayDic setObject:hour forKey:@"hour"];
    [todayDic setObject:minute forKey:@"minute"];
    [todayDic setObject:second forKey:@"second"];
    
    return todayDic;
    
}

+ (NSDateComponents *)getCurrentDateDateComponents {
    NSDate *today = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = kCFCalendarUnitYear|kCFCalendarUnitMonth|kCFCalendarUnitDay;
    NSDateComponents *components = [calendar components:unit fromDate:today];
    return components;
}

+ (NSInteger (^)(NSInteger, NSInteger))firstWeekOfYearAndMonth {
    return ^(NSInteger year, NSInteger month) {
        NSInteger sum = 0;
        for(NSInteger i = 1;i<month;i++){
            sum += self.daysOfYearAndMonth(year,i);
        }
        NSInteger nedDay = sum+1;
        return ((year-1)+(year-1)/4 -(year/100)+(year/400)+nedDay)%7;
    };
}

+ (NSInteger (^)(NSInteger, NSInteger))daysOfYearAndMonth {
    return ^(NSInteger year, NSInteger month){
        NSInteger times [] = {31,28,31,30,31,30,31,31,30,31,30,31};
        if ((year%4==0&&year%100!=0)||year%400==0) {
            times[1] = 29;
        }
        return (times[month-1]);
    };
}

+ (int)getWeekOfYear:(int)year month:(int)month day:(int)day {
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:day];
    [comps setMonth:month];
    [comps setYear:year];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *date = [gregorian dateFromComponents:comps];
    NSDateComponents *weekdayComponents =
    [gregorian components:NSCalendarUnitWeekday fromDate:date];
    int weekday = (int)[weekdayComponents weekday];
    return weekday;
}

+ (BOOL)enabelRemoteAlert {
    BOOL isNotifyAlert = NO;
    UIUserNotificationType types = [[UIApplication sharedApplication] currentUserNotificationSettings].types;
    isNotifyAlert = (types & UIUserNotificationTypeAlert) == UIUserNotificationTypeAlert;
    return isNotifyAlert;
}

+ (void)pushToAppStoreForTalk:(NSString *)appId {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@",appId]]];
}

+ (NSString *)getIOSVersion
{
    return [[UIDevice currentDevice] systemVersion];
}

@end
