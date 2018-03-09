//
//  SYTabBarMaker.m
//  SYFrameWork
//
//  Created by 王声远 on 17/3/11.
//  Copyright © 2017年 王声远. All rights reserved.
//

#import "SYTabBarMaker.h"
#import "SYTabBarController.h"

#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

// 取色值相关的方法
#define RGB(r,g,b)          [UIColor colorWithRed:(r)/255.f \
green:(g)/255.f \
blue:(b)/255.f \
alpha:1.f]

@interface SYTabBarMaker()

@property (nonatomic,strong) SYTabBarController *tabBarController;
@property (nonatomic,strong) NSMutableArray *navigations;

@end

@implementation SYTabBarMaker


/**
 初始化构建器
 @return 构建器
 */
SYTabBarMaker *tabBarBuilder(){
    static  SYTabBarMaker *m = nil;
    if (!m) {
        m = SYTabBarMaker.new;
        m.tabBarController = SYTabBarController.new;
    }
    return m;
}

+ (SYTabBarController *(^)(NSArray *itemDictArray,NSString *nv,NSString *norColor,NSString *seleColor,NSString *bgColor,UnReadCountStyle unReadType))showWithInfo {
    return ^(NSArray *array,NSString *nv,NSString *norColor,NSString *seleColor,NSString *bgColor,UnReadCountStyle unReadType){
        SYTabBarMaker *slf = tabBarBuilder();
        for (NSDictionary *dict in array) {
            int type = [[dict objectForKey:tabBar_ImageType] intValue];
            CGFloat offsetY = 0;
            if ([dict objectForKey:tabBar_ImageOffsetY]) {
                offsetY = [[dict objectForKey:tabBar_ImageOffsetY] floatValue];
            }
            slf.controllerAndNavigationControllerWithInfo(dict[tabBar_controller],nv,
                                                          dict[tabBar_normal_icon],dict[tabBar_select_icon],
                                                          dict[tabBar_title],[SYTabBarMaker colorWithColorObject:norColor],
                                                          [SYTabBarMaker colorWithColorObject:seleColor],type,unReadType,
                                                          offsetY);
        }
        slf.tabBarController.viewControllers = slf.navigations;
        [slf.tabBarController customTabBarItemView:[SYTabBarMaker colorWithColorObject:bgColor]];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:slf.tabBarController ];
        [[[UIApplication sharedApplication].delegate window] setRootViewController:nav];
        return slf.tabBarController;
    };
}

/**
 构建tabBar元素(UIViewControler,UINavigationController,normalImage,selectImage,itemName,itemNameNormalColor,itemNameSelectColor)
 @return 构建器
 */
- (SYTabBarMaker *(^)(NSString *,NSString *,NSString *,NSString *,NSString *,UIColor *,UIColor *,TabBarImageType,UnReadCountStyle,CGFloat))controllerAndNavigationControllerWithInfo {
    return ^id(NSString *controller,NSString *navigationController,NSString *normalImage,NSString *selectImage,NSString *itemName,UIColor *itemNameNormalColor,UIColor *itemNameSelectColor, TabBarImageType type,UnReadCountStyle unReadType, CGFloat offsetY){
        
        NSAssert(controller,@"controller不能为空");
        
        Class ctrClass = NSClassFromString(controller);
        if (!navigationController) {
            navigationController = @"UINavigationController";
        }
        Class naviClass = NSClassFromString(navigationController);
        
        NSAssert([ctrClass isSubclassOfClass:[UIViewController class]],@"controller必须为UIController的class");
        NSAssert([naviClass isSubclassOfClass:[UINavigationController class]],@"navigationController必须为UINavigationController的class");

        UIViewController *ctr = [[ctrClass alloc] init];
        ctr.hidesBottomBarWhenPushed = NO;
        [self.tabBarController.rootControllers addObject:ctr];
        UINavigationController *navi = [[naviClass alloc] initWithRootViewController:ctr];
        [self.navigations addObject:navi];
        
        SYTabBarModel *m = [[SYTabBarModel alloc] initWithType:type norImg:normalImage preImg:selectImage name:itemName norColor:itemNameNormalColor seleColor:itemNameSelectColor  unReadType:unReadType offsetY:offsetY];
        [self.tabBarController.itemModels addObject:m];
        
        return self;
    };
}

- (NSMutableArray *)navigations {
    if (!_navigations) {
        _navigations = [NSMutableArray array];
    }
    return _navigations;
}

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

@end
