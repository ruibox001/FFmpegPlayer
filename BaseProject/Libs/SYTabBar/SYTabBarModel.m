//
//  SYTabBarModel.m
//  SYFrameWork
//
//  Created by 王声远 on 17/3/10.
//  Copyright © 2017年 王声远. All rights reserved.
//

#import "SYTabBarModel.h"

@implementation SYTabBarModel

- (instancetype)initWithType:(TabBarImageType)type norImg:(NSString *)norImg preImg:(NSString *)preImg name:(NSString *)name norColor:(UIColor *)norColor seleColor:(UIColor *)seleColor unReadType:(int)unReadType offsetY:(CGFloat)offsetY{
    self = [super init];
    if (self) {
        self.type = type;
        self.tarBarImageNormal = norImg;
        self.tarBarImagePress = preImg;
        self.tarBarName = name;
        self.tarBarUnReadCount = 0;
        self.tarBarUnSelectColor = norColor;
        self.tarBarSelectColor = seleColor;
        self.unReadType = unReadType;
        self.tarBarOffsetY = offsetY;
    }
    return self;
}

/**
 getter方法判断默认颜色
 @return 默认颜色
 */
- (UIColor *)tarBarUnSelectColor {
    if (!_tarBarUnSelectColor) {
        _tarBarUnSelectColor = [UIColor grayColor];
    }
    return _tarBarUnSelectColor;
}

/**
 getter方法判断默认颜色
 @return 默认颜色
 */
- (UIColor *)tarBarSelectColor {
    if (!_tarBarSelectColor) {
        _tarBarSelectColor = [UIColor blueColor];
    }
    return _tarBarSelectColor;
}

@end
