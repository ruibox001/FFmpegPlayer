//
//  STKGestureFingerLoginViewController.h
//  Tronker
//
//  Created by soffice-Jimmy on 2017/3/4.
//  Copyright © 2017年 Shenzhen Soffice Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STKGestureFingerLoginViewController : UIViewController

@property (assign, nonatomic) NSString *account;

@property (copy, nonatomic) void (^toLoginBlock)(void);
@property (copy, nonatomic) void (^toHomeBlock)(void);
@property (copy, nonatomic) void (^showTooatBlock)(NSString *msg);

@end

/*
 使用方式
 WEAKSELF
 self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
 self.window.windowLevel = UIWindowLevelStatusBar;
 STKGestureFingerLoginViewController *vc = [[STKGestureFingerLoginViewController alloc]init];
 __weak typeof(vc) wvc = vc;
 vc.toHomeBlock = ^{
 DLog(@"回调里的首页");
 [wvc.view removeFromSuperview];
 weakSelf.window = nil;
 };
 vc.toLoginBlock = ^{
 DLog(@"回调里的登录");
 [wvc.view removeFromSuperview];
 weakSelf.window = nil;
 };
 vc.showTooatBlock = ^(NSString *msg) {
 DLog(@"回调里的Toast: %@",msg);
 };
 vc.account = @"dfsds";
 [self.window setRootViewController:vc];
 [self.window makeKeyAndVisible];
*/
