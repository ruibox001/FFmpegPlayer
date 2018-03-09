//
//  UIViewController+TabBar.m
//  SYFrameWork
//
//  Created by 王声远 on 17/3/11.
//  Copyright © 2017年 王声远. All rights reserved.
//

#import "UIViewController+TabBar.h"
#import "SYTabBarMaker.h"
#import "AppDelegate.h"

@implementation UIViewController (TabBar)

- (void)tabBarHidden:(BOOL)hidden {
    
    AppDelegate *d = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UINavigationController * navigaCtrl = (UINavigationController *)d.window.rootViewController;
    SYTabBarController *c = navigaCtrl.viewControllers[0];
    NSInteger index = c.selectedIndex;
    
    NSInteger temp = index;
    if (index > 1) {
        index -= 1;
    }
    else {
        index += 1;
    }
    self.hidesBottomBarWhenPushed = hidden;
    [self.navigationController.tabBarController setSelectedIndex:index];
    [self.navigationController.tabBarController setSelectedIndex:temp];
}

- (void) tabBarSetUnReadCount:(int)count {
    SYTabBarController *tabbar = (SYTabBarController *)self.tabBarController;
    [tabbar setTabBarItemUnReadCount:count];
}

- (void) tabBarSetUnReadCount:(int)count withSelectIndex:(NSInteger)selectIndex {
    SYTabBarController *tabbar = (SYTabBarController *)self.tabBarController;
    [tabbar setTabBarItemUnReadCount:count selectedIndex:selectIndex];
}

- (void) tabBarSelectIndexWithIndex:(NSInteger)index {
    SYTabBarController *tabbar = (SYTabBarController *)self.tabBarController;
    [tabbar selectTabBarWithIndex:index];
}

@end
