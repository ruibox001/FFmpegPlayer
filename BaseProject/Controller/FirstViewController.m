//
//  FirstViewController.m
//  SYFrameWork
//
//  Created by 王声远 on 17/3/10.
//  Copyright © 2017年 王声远. All rights reserved.
//

#import "FirstViewController.h"
#import "SYNavigationHeader.h"
#import "AppDelegate.h"
#import "BaseWKWebViewController.h"
#import "UIViewController+TabBar.h"
#import "STKGestureFingerLoginViewController.h"
#import "SFAuthenticationTool.h"
#import "CLLockVC.h"

@interface FirstViewController ()

@property (nonatomic, strong) UIWindow *window;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addNavigationTitle:@"标题" tintColor:[UIColor whiteColor]];
    
    WEAKSELF
    [self addNavigationLeft:@[@"设置密码",@"验证密码",@"修改密码"] tintColor:[UIColor whiteColor] clickBlock:^(NSInteger index) {
        if (index == 0) {
            [weakSelf setPwd];
        }
        else if (index == 1){
            [weakSelf verifyPwd];
        }
        else {
            [weakSelf modifyPwd];
        }
    }];
    
    [self addNavigationRight:@"指纹" tintColor:[UIColor whiteColor] clickBlock:^(NSInteger index) {
        [weakSelf shows];
    }];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    tableView.tableFooterView = [UIView new];
    
    [self tabBarSetUnReadCount:5];
    
}

- (void)shows {
    
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
}

- (void)setPwd {
    
    
    BOOL hasPwd = [CLLockVC hasPwd];
    hasPwd = NO;
    if(hasPwd){
        
        DLog(@"已经设置过密码了，你可以验证或者修改密码");
    }else{
        
        [CLLockVC showSettingLockVCInVC:self successBlock:^(CLLockVC *lockVC, NSString *pwd) {
            
            DLog(@"密码设置成功");
            [lockVC dismiss:1.0f];
        }];
    }
}

/*
 *  验证密码
 */
- (void)verifyPwd {
    
    BOOL hasPwd = [CLLockVC hasPwd];
    
    if(!hasPwd){
        
        DLog(@"你还没有设置密码，请先设置密码");
    }else {
        
        [CLLockVC showVerifyLockVCInVC:self forgetPwdBlock:^{
            DLog(@"忘记密码");
        } successBlock:^(CLLockVC *lockVC, NSString *pwd) {
            DLog(@"密码正确");
            [lockVC dismiss:1.0f];
        }];
    }
}


/*
 *  修改密码
 */
- (void)modifyPwd{
    
    BOOL hasPwd = [CLLockVC hasPwd];
    
    if(!hasPwd){
        
        DLog(@"你还没有设置密码，请先设置密码");
        
    }else {
        
        [CLLockVC showModifyLockVCInVC:self successBlock:^(CLLockVC *lockVC, NSString *pwd) {
            
            [lockVC dismiss:.5f];
        }];
    }
    
}

@end
