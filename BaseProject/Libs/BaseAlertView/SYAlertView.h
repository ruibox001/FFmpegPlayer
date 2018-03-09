//
//  WSYAlertView.h
//  Sinllia_iPhone2.0
//
//  Created by 王声远 on 15/6/4.
//  Copyright (c) 2015年 Daisy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, AlertInDirection) {
    AlertInDirectionDefault,
    AlertInDirectionFromTop,
    AlertInDirectionFromRight,
    AlertInDirectionFromLeft,
    AlertInDirectionFromBotton
};

typedef NS_ENUM(NSInteger, AlertOutDirection) {
    AlertOutDirectionDefault,
    AlertOutDirectionFromTop,
    AlertOutDirectionFromRight,
    AlertOutDirectionFromLeft,
    AlertOutDirectionFromBotton
};

@interface SYAlertView : UIView

+ (instancetype) shareViewWithView:(UIView *)alertView AndInDirection:(AlertInDirection)iDirection andOutDirection:(AlertOutDirection)oDirection;
- (void)dismiss;

@end
