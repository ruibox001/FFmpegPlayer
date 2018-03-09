//
//  SFUtils.m
//  SFFrameWork
//
//  Created by 王声远 on 17/3/14.
//  Copyright © 2017年 王声远. All rights reserved.
//

#import "SFUtils.h"
#import <CommonCrypto/CommonDigest.h>
#import "NSString+SFBuilder.h"
#include <sys/sysctl.h>
#import "NSDateFormatter+SFBuilder.h"

#define  ONE_MINUTE     60
#define  ONE_HOUR       (60*ONE_MINUTE)
#define  ONE_DAY        (24*ONE_HOUR)
#define  ONE_MONTH      (30*ONE_DAY)
#define  ONE_YEAR       (365*ONE_DAY)


#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

// 取色值相关的方法
#define RGB(r,g,b)          [UIColor colorWithRed:(r)/255.f \
green:(g)/255.f \
blue:(b)/255.f \
alpha:1.f]

@implementation SFUtils

+ (UIColor *)colorWithColorObject:(id)object {
    
    if ([object isKindOfClass:[NSString class]]) {
        
        if ([object hasPrefix:@"@\""]) {
            object = [object stringByReplacingOccurrencesOfString:@"@\"" withString:@""];
        }
        if ([object hasSuffix:@"\""]) {
            object = [object stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        }
        
        CGFloat alpha = 1;
        NSArray *componnets = [object componentsSeparatedByString:@","];
        
        if (componnets.count == 2) {
            NSRange range = [object rangeOfString:@"," options:NSBackwardsSearch];
            alpha = [[object substringFromIndex:range.location + range.length] floatValue];
            alpha = MIN(alpha, 1);
            object = [object substringToIndex:range.location];
        }
        if (componnets.count == 3) {
            if ([componnets[0] floatValue] > 1 || [componnets[1] floatValue] > 1 || [componnets[2] floatValue] > 1) {
                return RGB([componnets[0] floatValue], [componnets[1] floatValue], [componnets[2] floatValue]);
            }
            else {
                return RGB([componnets[0] floatValue]*255, [componnets[1] floatValue]*255, [componnets[2] floatValue]*255);
            }
        }
        if (componnets.count == 4) {
            if ([componnets[0] floatValue] > 1 || [componnets[1] floatValue] > 1 || [componnets[2] floatValue] > 1) {
                return RGBA([componnets[0] floatValue], [componnets[1] floatValue], [componnets[2] floatValue], [componnets[3] floatValue]);
            }
            else {
                return RGBA([componnets[0] floatValue]*255, [componnets[1] floatValue]*255, [componnets[2] floatValue]*255,[componnets[3] floatValue]);
            }
        }
        
        SEL sel = NSSelectorFromString([NSString stringWithFormat:@"%@Color", object]);
        if ([UIColor respondsToSelector:sel]) {
            UIColor *color = [UIColor performSelector:sel withObject:nil];
            if (alpha != 1) color = [color colorWithAlphaComponent:alpha];
            return color;
        }
        return [self colorWithHex:object alpha:alpha];
    }
    return [UIColor clearColor];
}

#pragma mark - 字符串转UIColor
+(UIColor *)colorWithHex:(NSString *)color alpha:(CGFloat)alpha
{
    
    if ([color isEqualToString:@"random"]) {
        int r = 0, g = 0, b = 0;
        r = arc4random_uniform(256);
        g = arc4random_uniform(256);
        b = arc4random_uniform(256);
        return [UIColor colorWithRed:r/255. green:g/255. blue:b/255. alpha:alpha];
    }
    
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:alpha];
}

#pragma mark - 获取当前手机可视化界面ViewController
+ (UIViewController *)getVisibleViewController {
    UIWindow *window = [UIApplication sharedApplication ].delegate.window;
    UIViewController *rootViewController = window.rootViewController;
    return [self getVisibleViewController:rootViewController];
}

+ (UIViewController *)getVisibleViewController:(UIViewController *)rootViewController {
    if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)rootViewController;
        UIViewController *lastViewController = [[navigationController viewControllers] lastObject];
        return [self getVisibleViewController:lastViewController];
    }
    
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        UIViewController *selectedViewController = tabBarController.selectedViewController;
        return [self getVisibleViewController:selectedViewController];
    }
    
    if (rootViewController.presentedViewController != nil) {
        UIViewController *presentedViewController = (UIViewController *)rootViewController.presentedViewController;
        return [self getVisibleViewController:presentedViewController];
    }
    return rootViewController;
}



#pragma mark - 根据NSData转成md5字符串
+ (NSString *) md5HexDigestWithData:(NSData *)data
{
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(data.bytes, (CC_LONG)data.length, result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

+ (NSString *)stringByTrim:(NSString *)str {
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    return [str stringByTrimmingCharactersInSet:set];
}

#pragma mark - 根据字符串转成NSNumber
+ (NSNumber *)numberWithString:(NSString *)string {
    NSString *str = [[self stringByTrim:string] lowercaseString];
    if (!str || !str.length) {
        return nil;
    }
    
    static NSDictionary *dic;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dic = @{@"true" :   @(YES),
                @"yes" :    @(YES),
                @"false" :  @(NO),
                @"no" :     @(NO),
                @"nil" :    [NSNull null],
                @"null" :   [NSNull null],
                @"<null>" : [NSNull null]};
    });
    id num = dic[str];
    if (num) {
        if (num == [NSNull null]) return nil;
        return num;
    }
    
    // hex number
    int sign = 0;
    if ([str hasPrefix:@"0x"]) sign = 1;
    else if ([str hasPrefix:@"-0x"]) sign = -1;
    if (sign != 0) {
        NSScanner *scan = [NSScanner scannerWithString:str];
        unsigned num = -1;
        BOOL suc = [scan scanHexInt:&num];
        if (suc)
            return [NSNumber numberWithLong:((long)num * sign)];
        else
            return nil;
    }
    // normal number
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    return [formatter numberFromString:string];
}

#pragma mark - 根据圆心、半径、角度计算出圆弧上各个点的坐标
+ (CGPoint)calcuCircleCoordinateWithCenter:(CGPoint)center angle:(CGFloat)angle radius:(CGFloat)radius {
    
    if (angle >= 360) {
        angle =  360;
    }
    
    if (angle <= 0) {
        angle = 0;
    }
    
    angle = 360 - angle;
    CGFloat x = radius * cosf(angle*M_PI/180);
    CGFloat y = radius*sinf(angle*M_PI/180);
    return CGPointMake(center.x+x, center.y-y);
}

#pragma mark - 格式化时间（刚刚、1分钟前)
+ (NSString *) formatDateToView:(NSDate *)date{
    if (!date) {
        return @"";
    }
    
    NSTimeInterval millis = [[NSDate dateWithTimeIntervalSinceNow:0] timeIntervalSince1970] - [date timeIntervalSince1970];
    
    if (millis < ONE_MINUTE) {
        return @"刚刚";
    } else if (millis < ONE_HOUR) {
        return [NSString stringWithFormat:@"%.0f分钟前",millis/ONE_MINUTE];
    } else if (millis<ONE_DAY) {
        return [NSString stringWithFormat:@"%.0f小时前",millis/ONE_HOUR];
    } else if (millis<ONE_MONTH) {
        return [NSString stringWithFormat:@"%.0f天前",millis/ONE_DAY];
    } else if (millis<ONE_YEAR) {
        return [NSString stringWithFormat:@"%.0f月前",millis/ONE_MONTH];
    } else {
        return [NSString stringWithFormat:@"%.0f年前",millis/ONE_YEAR];
    }
}

+ (UIImage *)createImageWithColor:(UIColor*)color {
    
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (NSString *)formatToStringWithObject:(NSString *)objc withFormat:(NSString *)format {
    if (objc.strIsInteger()) {
        NSDate* date = [NSDate dateWithTimeIntervalSince1970:[objc doubleValue]/ 1000.0];
        return [dateFormator.dateFormaterWithFormat(format) stringFromDate:date];
    }
    NSAssert(NO, @"date必须是毫秒");
    return nil;
}

+ (UIColor *)image:(UIImage *)image colorAtPixel:(CGPoint)point
{
    if (!CGRectContainsPoint(CGRectMake(0.0f, 0.0f, image.size.width, image.size.height), point))
    {
        return nil;
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    int bytesPerPixel = 4;
    int bytesPerRow = bytesPerPixel * 1;
    NSUInteger bitsPerComponent = 8;
    unsigned char pixelData[4] = {0, 0, 0, 0};
    
    CGContextRef context = CGBitmapContextCreate(pixelData,
                                                 1,
                                                 1,
                                                 bitsPerComponent,
                                                 bytesPerRow,
                                                 colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    
    CGContextTranslateCTM(context, -point.x, point.y - image.size.height);
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, image.size.width, image.size.height), image.CGImage);
    CGContextRelease(context);
    
    CGFloat red   = (CGFloat)pixelData[0] / 255.0f;
    CGFloat green = (CGFloat)pixelData[1] / 255.0f;
    CGFloat blue  = (CGFloat)pixelData[2] / 255.0f;
    CGFloat alpha = (CGFloat)pixelData[3] / 255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (UIImage *)image:(UIImage *)image withTitle:(NSString *)title fontSize:(CGFloat)fontSize
{
    //画布大小
    CGSize size=CGSizeMake(image.size.width,image.size.height);
    //创建一个基于位图的上下文
    UIGraphicsBeginImageContextWithOptions(size,NO,0.0);//opaque:NO  scale:0.0
    
    [image drawAtPoint:CGPointMake(0.0,0.0)];
    
    //文字居中显示在画布上
    NSMutableParagraphStyle* paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paragraphStyle.alignment=NSTextAlignmentCenter;//文字居中
    
    //计算文字所占的size,文字居中显示在画布上
    CGSize sizeText=[title boundingRectWithSize:image.size options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]}context:nil].size;
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    
    CGRect rect = CGRectMake((width-sizeText.width)/2, (height-sizeText.height)/2, sizeText.width, sizeText.height);
    //绘制文字
    [title drawInRect:rect withAttributes:@{ NSFontAttributeName:[UIFont systemFontOfSize:fontSize],NSForegroundColorAttributeName:[ UIColor whiteColor],NSParagraphStyleAttributeName:paragraphStyle}];
    
    //返回绘制的新图形
    UIImage *newImage= UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

/**
 *  小数点格式化  四舍五入
 *  @param format 保留几位小数,格式 如三位小数 则传入 0.000
 *  @param floatV 要格式化的数字
 *  @return 格式化字符串
 */
+ (NSString *) decimalwithFormat:(NSString *)format  floatV:(float)floatV  {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:format];
    return  [numberFormatter stringFromNumber:[NSNumber numberWithFloat:floatV]];
}

+ (NSString *)getIOSVersion
{
    return [[UIDevice currentDevice] systemVersion];
}

+ (NSString *)getCurrentDeviceModel
{
    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    
    DLog(@"platform: %@",platform);
    
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone 7"; // 已验证
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus"; // 已验证
    
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6S"; // 已验证
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6S Plus"; // 已验证
    
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus"; // 已验证
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    
    if ([platform isEqualToString:@"iPad5,4"])   return @"iPad Air 2"; // 已验证
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2"; // 已验证
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G";
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G";
    
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    
    return platform;
}

/**
 *  小数点格式化,不四舍五入
 *  @param price    原始的小数
 *  @param position 保留几位小数
 */
+ (NSString *)notRoundFloat:(float)price afterPoint:(int)position {
    NSString *f = [NSString stringWithFormat:@"%f",price];
    if (![f containsString:@"."]) {
        return f;
    }
    if (f.strEndWith(@".")) {
        return [f substringToIndex:f.length-1];
    }
    
    NSRange range = [f rangeOfString:@"."];
    NSInteger dotIndex = range.location+range.length;
    NSInteger dotEnd = f.length - dotIndex - position;
    if (dotEnd > 0) {
        return [f substringToIndex:dotIndex+position];
    }
    return f;
}

- (UIWindow *)getNewWindowWithLevel:(UIWindowLevel)level {
    UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    window.windowLevel = level;
    [window makeKeyAndVisible];
    return window;
}

@end
