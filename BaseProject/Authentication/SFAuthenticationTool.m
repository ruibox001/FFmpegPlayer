//
//  STKLocalAuthenticationManager.m
//  Tronker
//
//  Created by soffice-Jimmy on 2017/2/28.
//  Copyright © 2017年 Shenzhen Soffice Software. All rights reserved.
//

#import "SFAuthenticationTool.h"
#import <UIKit/UIKit.h>
#import <LocalAuthentication/LocalAuthentication.h>

@implementation SFAuthenticationTool

+ (instancetype)sharedInstance
{
    static SFAuthenticationTool *item = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        item = [[self alloc]init];
    });
    return item;
}

/**
 获取指纹是否开启的Key
 */
- (NSString *)getAuthenKey:(NSString *)identity {
    NSString *key = [NSString stringWithFormat:@"authen_%@",identity];
    return key;
}

/**
 指纹功能开启/关闭设置
 @param open 是否开启
 */
- (void)setAuthenticationStatus:(BOOL)open indentity:(NSString *)identity
{
    [[NSUserDefaults standardUserDefaults] setBool:open forKey:[self getAuthenKey:identity]];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/**
 指纹验证是否开启
 */
- (BOOL)authenticationIsOpenithIndentity:(NSString *)identity
{
    BOOL open = [[NSUserDefaults standardUserDefaults] boolForKey:[self getAuthenKey:identity]];
    return open;
}

/**
 仅用于判断设备是否支持Touch ID
 @return BOOL
 */
- (BOOL)canEvaluatePolicy
{
    //创建LAContext
    LAContext *context = [LAContext new];
    NSError *error = nil;
    BOOL canEvaluate = [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
    if (error && error.code == LAErrorTouchIDNotAvailable) {
        canEvaluate = NO; // 不支持
    } else {
        canEvaluate = YES;
    }
    return canEvaluate;
}

// 判断指纹数据是否有变化
- (BOOL)isEvaluateChanged:(LAContext *)context
{
    NSData *domainState = nil;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
        
        domainState = context.evaluatedPolicyDomainState;
        NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
        
        NSData *oldDAta = [userD objectForKey:@"domainState"];
        if (oldDAta) {
            if (![oldDAta isEqualToData:domainState]) {
                [userD setObject:domainState forKey:@"domainState"];
                [userD synchronize];
                return YES;
            }
        } else {
            [userD setObject:domainState forKey:@"domainState"];
            [userD synchronize];
        }
    }
    
    return NO;
}

- (void)saveEvaluatedPolicyDomainStateWithContext:(LAContext *)context
{
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
        LAPolicy policy = LAPolicyDeviceOwnerAuthenticationWithBiometrics;
        NSError *error = nil;
        BOOL canEvaluate = [context canEvaluatePolicy:policy error:&error];
        
        if (canEvaluate) {
            NSData *domainState = context.evaluatedPolicyDomainState;
            NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
            [userD setObject:domainState forKey:@"domainState"];
            [userD synchronize];
        }
    }
}

/**
 指纹验证
 
 @param fallbackTitle 指纹弹出框右侧按钮标题
 @param result 验证结果
 @param fallBack 指纹右按钮操作
 @param cancel 取消验证
 */
- (void)evaluateAuthenticateWithFallbackTitle:(NSString *)fallbackTitle validateChange:(BOOL)validate result:(void(^)(BOOL success, NSString *alertTitle))result fallBack:(void(^)(NSString *message))fallBack cancel:(void(^)(BOOL authFailed))cancel
{
    //创建LAContext
    LAContext *context = [LAContext new];
    
    //这个属性是设置指纹输入失败之后的弹出框的选项
    if (fallbackTitle) {
        context.localizedFallbackTitle = fallbackTitle;
    } else {
        context.localizedFallbackTitle = @"";  // 隐藏输入密码入口
    }
    
    NSError *error = nil;
    BOOL canEvaluate = [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
    
    // 判断指纹数据是否有变化
    if (validate && [self isEvaluateChanged:context]) {
        if (fallBack) {
            fallBack(@"您的系统指纹数据有变化，需要重新登录完成验证。");
        }
        return;
    }
    
    if (canEvaluate) {
        
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"通过Home键验证已有手机指纹" reply:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                DLog(@"验证成功 刷新主界面");
                
                // 保存指纹数据状态
                [self saveEvaluatedPolicyDomainStateWithContext:context];
                
                if (result) {
                    result(success, nil);
                }
            }else{
                DLog(@"%@",error.localizedDescription);
                switch (error.code) {
                    case LAErrorSystemCancel:
                    {
                        DLog(@"系统取消授权，如其他APP切入");
                        break;
                    }
                    case LAErrorUserCancel:
                    {
                        DLog(@"用户取消验证Touch ID");
                        if (cancel) {
                            cancel(NO);
                        }
                        break;
                    }
                    case LAErrorAuthenticationFailed:
                    {
                        DLog(@"三次授权失败，指纹验证错误");
                        // 相当于取消操作
                        if (cancel) {
                            cancel(YES);
                        }
                        break;
                    }
                    case LAErrorPasscodeNotSet:
                    {
                        DLog(@"系统未设置密码");
                        break;
                    }
                    case LAErrorTouchIDNotAvailable:
                    {
                        DLog(@"设备Touch ID不可用，例如未打开");
                        break;
                    }
                    case LAErrorTouchIDNotEnrolled:
                    {
                        DLog(@"设备Touch ID不可用，用户未录入");
                        break;
                    }
                    case LAErrorUserFallback:
                    {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            DLog(@"用户选择输入密码，切换主线程处理");
                            if (fallBack) {
                                fallBack(nil);
                            }
                        });
                        break;
                    }
                    default: // LAErrorTouchIDLockout
                    {
                        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0) {
                            [context evaluatePolicy:LAPolicyDeviceOwnerAuthentication localizedReason:@"通过Home键验证已有手机指纹" reply:^(BOOL success, NSError * _Nullable error) {
                                if (success) {
                                    DLog(@"验证成功 刷新主界面");
                                    // 保存指纹数据状态
                                    [self saveEvaluatedPolicyDomainStateWithContext:context];
                                    
                                    if (result) {
                                        result(success, nil);
                                    }
                                } else {
                                    if (cancel) {
                                        cancel(NO);
                                    }
                                }
                            }];
                        } else {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                DLog(@"其他情况，切换主线程处理，五次验证失败进入,指纹被锁定");
                                if (result) {
                                    result(success, @"指纹被锁定，请关闭一次屏幕后重试");
                                }
                            });
                        }
                        
                        break;
                    }
                }
            }
        }];
    }else{
        
        NSString *msg = nil;
        BOOL needEvaluatePolicyAgain = NO; // 是否需要再次验证指纹
        switch (error.code) {
            case LAErrorTouchIDNotAvailable:
            {
                DLog(@"该设备不支持 Touch ID - %@", error.localizedDescription);
                msg = @"该设备不支持 Touch ID";
                break;
            }
            case LAErrorTouchIDNotEnrolled:
            {
                DLog(@"TouchID is not enrolled，没有设置密码/没有指纹记录，请先到系统开启指纹服务");
                msg = @"你需要先在本机系统“设置-Touch ID与密码”中添加指纹才能使用此功能。";
                break;
            }
            case LAErrorPasscodeNotSet:
            {
                DLog(@"A passcode has not been set，本机系统没有设置密码");
                msg = @"本机系统没有设置密码";
                break;
            }
            default:
            {
                DLog(@"TouchID not available，五次验证失败后，指纹无效，清除开启指纹状态，弹出输入密码验证界面，要重新开启指纹，需要关闭一次屏幕验证才行");
                msg = @"指纹被锁定，请关闭一次屏幕后重试";
                if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0) {
                    msg = nil;
                    needEvaluatePolicyAgain = YES;
                    [context evaluatePolicy:LAPolicyDeviceOwnerAuthentication localizedReason:@"通过Home键验证已有手机指纹" reply:^(BOOL success, NSError * _Nullable error) {
                        if (success) {
                            DLog(@"验证成功 刷新主界面");
                            if (result) {
                                result(success, nil);
                            }
                        } else {
                            if (cancel) {
                                cancel(NO);
                            }
                        }
                    }];
                }
                break;
            }
        }
        if (result && !needEvaluatePolicyAgain) {
            result(NO, msg);
        }
        DLog(@"%@",error.localizedDescription);
    }
    
}


@end
