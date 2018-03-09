//
//  SYTabBarMaker.h
//  SYFrameWork
//
//  Created by 王声远 on 17/3/11.
//  Copyright © 2017年 王声远. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIViewController+TabBar.h"
#import "SYTabBarController.h"

#define tabBar_normal_icon      @"tabBar_normal_icon"
#define tabBar_select_icon      @"tabBar_select_icon"
#define tabBar_title            @"tabBar_title"
#define tabBar_controller       @"tabBar_controller"
#define tabBar_ImageType       @"tabBar_ImageType"
#define tabBar_ImageOffsetY       @"tabBar_ImageOffsetY"

@interface SYTabBarMaker : NSObject

/**
 设置tabBar构建显示
 itemDictArray 配置字典数组
 nv UINavigationController名称
 norColor 未选中的颜色
 seleColor 选中颜色
 bgColor 背景颜色
 type 显示样式  > TabBarImageTypeOnlyImage只有一张图片  TabBarImageTypeImageTitle图片和标题
 unReadType 未读数样式 > UnReadCountStyleRedPoint未读红点  UnReadCountStyleUnReadCount未读具体数量
 */
+ (SYTabBarController *(^)(NSArray *itemDictArray,NSString *nv,NSString *norColor,NSString *seleColor,NSString *bgColor,UnReadCountStyle unReadType))showWithInfo;

//tarBar构建例子
/*
 NSArray *itemDictArray = @[
 @{tabBar_normal_icon  : @"icon_screening_unselect",
 tabBar_select_icon  : @"icon_screening_select",
 tabBar_title  : @"筛选",
 tabBar_controller    : @"FirstViewController"},
 
 @{tabBar_normal_icon  : @"icon_interview_unselect",
 tabBar_select_icon  : @"icon_interview_select",
 tabBar_title  : @"面试",
 tabBar_controller    : @"SecondViewController"},
 
 @{tabBar_normal_icon  : @"icon_mine_unselect",
 tabBar_select_icon  : @"icon_mine_select",
 tabBar_title  : @"我的",
 tabBar_controller    : @"ThirdViewController"}];
 SYTabBarController *tabbar = SYTabBarMaker.showWithInfo(itemDictArray,@"BaseNavigationController",@"#666666",@"red",@"white",TabBarImageTypeImageTitle,UnReadCountStyleUnReadCount);
 tabbar.selectTabBarItemBlock = ^(NSInteger selectIndex) {
 NSLog(@"SELECT: %ld",(long)selectIndex);
 };
*/

@end
