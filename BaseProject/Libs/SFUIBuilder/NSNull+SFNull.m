//
//  NSNull+SFNull.m
//  Tronker
//
//  Created by 王声远 on 2017/5/25.
//  Copyright © 2017年 Shenzhen Soffice Software. All rights reserved.
//

#import "NSNull+SFNull.h"
#import <UIKit/UIKit.h>

@implementation NSNull (SFNull)

- (NSInteger) integerValue
{
    return 0;
}

- (CGFloat) floatValue
{
    return 0;
}

- (double) doubleValue {
    return 0.0;
}

@end
