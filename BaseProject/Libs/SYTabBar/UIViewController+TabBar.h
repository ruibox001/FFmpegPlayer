//
//  UIViewController+TabBar.h
//  SYFrameWork
//
//  Created by 王声远 on 17/3/11.
//  Copyright © 2017年 王声远. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (TabBar)


/**
 是否隐藏
 @param hidden YES隐藏NO不隐藏
 */
- (void)tabBarHidden:(BOOL)hidden;

- (void) tabBarSetUnReadCount:(int)count;

- (void) tabBarSetUnReadCount:(int)count withSelectIndex:(NSInteger)selectIndex;

- (void) tabBarSelectIndexWithIndex:(NSInteger)index;

@end
