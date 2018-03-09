//
//  SFUtils.h
//  SFFrameWork
//
//  Created by 王声远 on 17/3/14.
//  Copyright © 2017年 王声远. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define FILEString [NSString stringWithFormat:@"%s", __FILE__].lastPathComponent
#ifdef DEBUG
#define DLog(...) printf("%s 第%d行: %s\n", [FILEString UTF8String] ,__LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String]);
#else
#define DLog(...)
#endif

@interface SFUtils : NSObject

+ (UIColor *)colorWithColorObject:(id)object;

+ (UIViewController *)getVisibleViewController;

+ (NSString *) md5HexDigestWithData:(NSData *)data;

+ (NSNumber *)numberWithString:(NSString *)string ;

+ (CGPoint)calcuCircleCoordinateWithCenter:(CGPoint)center angle:(CGFloat)angle radius:(CGFloat)radius;

+ (NSString *) formatDateToView:(NSDate *)date;

+ (UIImage *)createImageWithColor:(UIColor*)color;

//date是毫秒，format格式化样式
+ (NSString *)formatToStringWithObject:(NSString *)objc withFormat:(NSString *)format;

//取图片某一像素点的颜色
+ (UIColor *)image:(UIImage *)image colorAtPixel:(CGPoint)point;

//图片上加上文字(字体)默认是居中
+ (UIImage *)image:(UIImage *)image withTitle:(NSString *)title fontSize:(CGFloat)fontSize;

/**
 *  小数点格式化  四舍五入
 *  @param format 保留几位小数,格式 如三位小数 则传入 0.000
 *  @param floatV 要格式化的数字
 *  @return 格式化字符串
 */
+ (NSString *) decimalwithFormat:(NSString *)format  floatV:(float)floatV;

+ (NSString *)getIOSVersion;

+ (NSString *)getCurrentDeviceModel;

/**
 *  不四舍五入，直接截掉
 *  @param price    原始的小数
 *  @param position 保留几位小数
 */
+ (NSString *)notRoundFloat:(float)price afterPoint:(int)position;

- (UIWindow *)getNewWindowWithLevel:(UIWindowLevel)level;

@end
