//
//  WSYTBAlertView.h
//  IEasyHome
//
//  Created by 王声远 on 15/8/20.
//  Copyright (c) 2015年 anody. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,TBAlertViewType) {
    TBAlertViewTypeTop,
    TBAlertViewTypeBotton,
};

@interface SYTBAlertView : UIView

+ (instancetype) shareTBAlertViewWithView:(UIView *)alertView style:(TBAlertViewType)style;
- (void)dismiss;

@end
