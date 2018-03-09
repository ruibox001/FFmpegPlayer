//
//  UIFont+SFBuilder.m
//  SFFrameWork
//
//  Created by 王声远 on 17/3/14.
//  Copyright © 2017年 王声远. All rights reserved.
//



#import "UIFont+SFBuilder.h"

@implementation UIFont (SFBuilder)

+ (UIFont *)fontWithObject:(id)object {
    if ([object isKindOfClass:[NSNumber class]]) {
        if (defaultFontName.length == 0) {
            return [UIFont fontWithName:defaultFontName size:[object floatValue]];
        }
        return [UIFont systemFontOfSize:[object floatValue]];
    }
    return [UIFont systemFontOfSize:14];
}

+ (UIFont *)fontWithBoldObject:(id)object {
    if ([object isKindOfClass:[NSNumber class]]) {
        if (defaultFontName.length == 0) {
            return [UIFont fontWithName:defaultFontName size:[object floatValue]];
        }
        return [UIFont boldSystemFontOfSize:[object floatValue]];
    }
    return [UIFont boldSystemFontOfSize:14];
}

@end
