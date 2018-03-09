//
//  UINavigationController+SFBuilder.m
//  Tronker
//
//  Created by 王声远 on 2017/4/28.
//  Copyright © 2017年 Shenzhen Soffice Software. All rights reserved.
//

#import "UINavigationController+SFBuilder.h"
#import "SFUIBuilderHeader.h"

@implementation UINavigationController (SFBuilder)

//默认创建类别时自动调用
+ (void)load {
    [self objExchangeInstanceMethodWithOriginSel:@selector(pushViewController:animated:) newSel:@selector(cus_pushViewController:animated:)];
}

- (SFPropertyUINavigationControllerObjectBlock)naviBgColor {
    return ^(id color){
        if ([color isKindOfClass:[UIImage class]]) {
            [self.navigationBar setBackgroundImage:color forBarMetrics:UIBarMetricsDefault];
        }
        return self;
    };
}

- (void)cus_pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [self cus_pushViewController:viewController animated:animated];
    //判断是iPhoneX,修复push时上移的效果
    pushAdjustTabBarFrameWhenPush();
}

@end
