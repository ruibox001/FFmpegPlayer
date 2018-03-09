//
//  UIFont+SFBuilder.h
//  SFFrameWork
//
//  Created by 王声远 on 17/3/14.
//  Copyright © 2017年 王声远. All rights reserved.
//

#import <UIKit/UIKit.h>

#define Fnt(x)  [UIFont fontWithObject:x]
#define Fbt(x)  [UIFont fontWithBoldObject:x]

@interface UIFont (SFBuilder)

+ (UIFont *)fontWithObject:(id)object;

+ (UIFont *)fontWithBoldObject:(id)object;

@end
