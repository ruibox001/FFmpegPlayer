//
//  AppDelegate.m
//  BaseProject
//
//  Created by 王声远 on 2017/8/29.
//  Copyright © 2017年 王声远. All rights reserved.
//

#import "AppDelegate.h"
#import "SYTabBarMaker.h"
#import "SYGuiViewBuilder.h"
#import "SFAppStatusManager.h"
#import "STKGestureFingerLoginViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [UIWindow new];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.frame = [[UIScreen mainScreen] bounds];
    [self.window makeKeyAndVisible];
    
    [self buildTabBar];
    
//    [self enterGuiderView];
//    [self enterFingerLogin];
    
    DLog(@"platform: %@",[SFUtils getCurrentDeviceModel]);
    
    return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    DLog(@"AppDelegate进入后台");
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    DLog(@"AppDelegate回到前台");
}

- (void)buildTabBar
{
    NSArray *itemDictArray = @[
                                 @{tabBar_normal_icon  : @"icon_screening_unselect",
                                   tabBar_select_icon  : @"icon_screening_select",
                                   tabBar_title  : @"筛选",
                                   tabBar_ImageType : @(TabBarImageTypeImageTitle),
                                   tabBar_ImageOffsetY : @(0),
                                   tabBar_controller    : @"FirstViewController"},
                                 
                                 @{tabBar_normal_icon  : @"icon_interview_unselect",
                                   tabBar_select_icon  : @"icon_interview_select",
                                   tabBar_title  : @"面试",
                                   tabBar_ImageType : @(TabBarImageTypeImageTitle),
                                   tabBar_ImageOffsetY : @(0),
                                   tabBar_controller    : @"SecondViewController"},
                                 
                                 @{tabBar_normal_icon  : @"icon_mine_unselect",
                                   tabBar_select_icon  : @"icon_mine_select",
                                   tabBar_title  : @"我的",
                                   tabBar_ImageType : @(TabBarImageTypeImageTitle),
                                   tabBar_ImageOffsetY : @(0),
                                   tabBar_controller    : @"ThirdViewController"}];
    SYTabBarController *tabbar = SYTabBarMaker.showWithInfo(itemDictArray,@"BaseNavigationController",@"#666666",@"red",@"white",UnReadCountStyleUnReadCount);
//    weakObject(tabbar)
    tabbar.shouldSelectTabBarItemBlock = ^BOOL(NSInteger selectIndex) {
        NSLog(@"SELECT: %ld",(long)selectIndex);
        if (selectIndex == 1) {
//            NSLog(@"SELECT: %ld 不允许跳转",(long)selectIndex);
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [weaktabbar selectTabBarWithIndex:1];
//            });
            return YES;
        }
        return YES;
    };
}

- (void)enterGuiderView {
    NSArray *imgs = @[@"640x1136page1",@"640x1136page2",@"640x1136page3"];
    guiViewBuilder().images(imgs).btnBottonOffset(50).createBtn(@"立即体验",[UIColor redColor],[UIColor blackColor],8,CGSizeMake(100, 40),12,^(){
        NSLog(@"click");
        [self buildTabBar];
    }).addImageName(@"640x1136page2").show(YES);
}

- (void)enterFingerLogin {
    STKGestureFingerLoginViewController *vc = [[STKGestureFingerLoginViewController alloc]init];
    vc.account = @"dfsds";
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self.window setRootViewController:nav];
}

@end
