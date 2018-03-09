//
//  UIViewController+NavigationTool.m
//  SYFrameWork
//
//  Created by 王声远 on 17/3/9.
//  Copyright © 2017年 王声远. All rights reserved.
//

#import "UIViewController+NavigationTool.h"
#import <objc/runtime.h>

@implementation UIViewController (NavigationTool)

- (SYNavigationTool *)navTool
{
    static char navigationToolKey;
    SYNavigationTool *tool = objc_getAssociatedObject(self, &navigationToolKey);
    if (!tool) {
        tool = [[SYNavigationTool alloc] init];
        NSString *key = [NSString stringWithFormat:@"%pkey",&navigationToolKey];
        [self willChangeValueForKey:key];
        objc_setAssociatedObject(self,
                                 &navigationToolKey,
                                 tool,
                                 OBJC_ASSOCIATION_RETAIN);
        [self didChangeValueForKey:key];
    }
    return tool;
}

//添加标题
- (void)addNavigationTitle:(NSString *)title {
    if (!title || title.length == 0) {
        return;
    }
    [[self navTool] addTitle:title ctl:self tintColor:nil];
}

//添加标题
- (void)addNavigationTitle:(NSString *)title tintColor:(UIColor *)titleColor{
    if (!title || title.length == 0) {
        title = @"";
    }
    [[self navTool] addTitle:title ctl:self tintColor:titleColor];
}

//添加左边
- (void)addNavigationLeft:(id)left clickBlock:(NavButtonClickBlock)block {
    [self addNavigationLeft:left tintColor:nil clickBlock:block];
}

//添加左边
- (void)addNavigationLeft:(id)left tintColor:(UIColor *)tintColor clickBlock:(NavButtonClickBlock)block {
    if (!block) {
        __weak typeof(self) weakSelf = self;
        block = ^(NSInteger index) {
            [weakSelf goBack];
        };
    }
    [[self navTool] addLeft:left ctl:self tintColor:tintColor clickBlock:block];
}

/**
 返回
 */
- (void)goBack{
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

//添加右边
- (void)addNavigationRight:(id)right clickBlock:(NavButtonClickBlock)block {
    [[self navTool] addRight:right ctl:self tintColor:nil clickBlock:block];
}

//添加右边
- (void)addNavigationRight:(id)right tintColor:(UIColor *)tintColor clickBlock:(NavButtonClickBlock)block {
    [[self navTool] addRight:right ctl:self tintColor:tintColor clickBlock:block];
}

- (void)setNavigationBarHidden:(BOOL)hidden animated:(BOOL)animated {
    if (hidden) {
        [self setNavigationShadowImage:[UIImage new]];
    }
    [self.navigationController setNavigationBarHidden:hidden animated:animated];
}

- (void)setNavigationShadowImage:(UIImage *)image {
    [self.navigationController.navigationBar setShadowImage:image];
}

- (void)setNavigationStyle:(UIStatusBarStyle)style animated:(BOOL)animated {
    [[UIApplication sharedApplication] setStatusBarStyle:style animated:animated];
}

- (void)setNavigationBgColor:(UIColor *)bgColor {
    [self.navigationController.navigationBar setBackgroundImage:bgColor.colorToImage() forBarMetrics:UIBarMetricsDefault];
}

@end
