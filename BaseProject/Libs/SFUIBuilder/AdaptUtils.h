//
//  AdaptUtils.h
//  Tronker
//
//  Created by Devin on 17-9-29.
//  Copyright (c) 2017年 ___SOFFICE___. All rights reserved.
//

#ifndef _AdaptUtils_h
#define _AdaptUtils_h

/* iOS 11适配信息记录
 一、iphoneX屏幕大小：375x812 启动图片：1125×2436
 iOS11适配时必须导入启动图片，因为[[UIScreen mainScreen] bounds]是根据启动图片大小得到的，否则默认都是[320x568]
 */

//tableView/scorllView的适配代码
#define  adjustsScrollViewInsets_NO(scrollView,vc)\
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
if ([UIScrollView instancesRespondToSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:")]) {\
[scrollView   performSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:") withObject:@(2)];\
} else {\
vc.automaticallyAdjustsScrollViewInsets = NO;\
}\
_Pragma("clang diagnostic pop") \
} while (0)

//tabBar在push时适配代码
#define pushAdjustTabBarFrameWhenPush() \
do { \
if([UIScreen mainScreen].bounds.size.width == 375.0f && [UIScreen mainScreen].bounds.size.height == 812.0f){ \
CGRect frame = self.tabBarController.tabBar.frame; \
frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height; \
self.tabBarController.tabBar.frame = frame; \
} \
} while (0)

//判断是iPhoneX 的宏
#define iSPhoneX ([UIScreen mainScreen].bounds.size.width == 375.0f && [UIScreen mainScreen].bounds.size.height == 812.0f)

//导航栏告诉
#define naviHeight         (iSPhoneX ? 88.0 : 64.0)

//tabbar高度
#define tabbaHeight      (iSPhoneX ? (34+49) : 49)

//phoneX时会有值
#define tabbaExtenHeight (iSPhoneX ? 34.0 : 0.0)
#define titleLargeHeight     52

#endif
