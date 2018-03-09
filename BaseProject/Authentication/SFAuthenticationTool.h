//
//  STKLocalAuthenticationManager.h
//  Tronker
//
//  Created by soffice-Jimmy on 2017/2/28.
//  Copyright © 2017年 Shenzhen Soffice Software. All rights reserved.
//

#import <Foundation/Foundation.h>

//指纹密码管理类
@interface SFAuthenticationTool : NSObject

+ (instancetype)sharedInstance;

/**
 指纹功能开启状态
 @param open 是否开启
 */
- (void)setAuthenticationStatus:(BOOL)open indentity:(NSString *)identity;
- (BOOL)authenticationIsOpenithIndentity:(NSString *)identity;

/**
 仅用于判断设备是否支持Touch ID
 @return BOOL
 */
- (BOOL)canEvaluatePolicy;

/**
 指纹验证
 @param fallbackTitle 指纹弹出框右侧按钮标题
 @param validate 是否校验原来的指纹，设置时不校验NO，验证时需要校验YES
 @param result 验证结果
 @param fallBack 指纹右按钮操作
 @param cancel 取消验证
 */
- (void)evaluateAuthenticateWithFallbackTitle:(NSString *)fallbackTitle validateChange:(BOOL)validate result:(void(^)(BOOL success, NSString *alertTitle))result fallBack:(void(^)(NSString *message))fallBack cancel:(void(^)(BOOL authFailed))cancel;

@end
