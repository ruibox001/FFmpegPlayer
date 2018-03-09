//
//  SYTabBarController.h
//  SYFrameWork
//
//  Created by 王声远 on 17/3/10.
//  Copyright © 2017年 王声远. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYTabBarButtonItem.h"
#import "SYTabBarModel.h"

@interface SYTabBarController : UITabBarController

@property (copy, nonatomic) BOOL (^shouldSelectTabBarItemBlock)(NSInteger selectIndex);
@property (strong, nonatomic) NSMutableArray *rootControllers;
@property (strong, nonatomic) NSMutableArray *itemModels;

/** 添加自定义Tabbar */
- (void) customTabBarItemView:(UIColor *)bgColor;

/**
 选中当前tarBar
 @param selectIndex tarBar位置
 */
- (void) selectTabBarWithIndex:(NSInteger)selectIndex;

/**
 设置未读数
 @param count 未读数
 @param selectedIndex 第几个tarBar
 */
- (void) setTabBarItemUnReadCount:(int)count selectedIndex:(NSInteger)selectedIndex;
- (void) setTabBarItemUnReadCount:(int)count;

/**
 通过那个index的tabBar跳转到controller
 @param index tarBar位置
 @param controller 跳转到controller
 */
- (void)pushToControllerWithController:(UIViewController *)controller withIndex:(NSInteger)index;

@end
