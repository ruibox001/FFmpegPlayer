//
//  UIColor+SFBuilder.h
//  SFFrameWork
//
//  Created by 王声远 on 17/3/14.
//  Copyright © 2017年 王声远. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFUtils.h"
#import "SFUIBuilderDef.h"

//#define color(x)    [SFUtils colorWithColorObject:commonProp(x)]
#define color(...)    [SFUtils colorWithColorObject:commonProps(__VA_ARGS__)]

@interface UIColor (SFBuilder)

- (UIImage * (^)(CGSize size))colorToImageWithSize;

- (UIImage * (^)())colorToImage;

SF_UIColor_PROP(Float) colorAlpha;

- (BOOL)colorEqualToColor:(UIColor *)color withDistance:(CGFloat)tolerance;

@end
