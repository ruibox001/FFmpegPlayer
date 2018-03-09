//
//  WKJsMethodControl.h
//  BaseProject
//
//  Created by 王声远 on 2017/9/19.
//  Copyright © 2017年 王声远. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsMethodObejct : NSObject

@property (nonatomic,strong) NSString *methodName;
@property (nonatomic,copy) void (^methodBlock)(NSDictionary *dict);

@end

@interface WKJsMethodControl : NSObject

- (instancetype)initWithUcontentController:(WKUserContentController *)u delegate:(id<WKScriptMessageHandler>)delegate;

- (void)addJsmethod:(NSString *)method handler:(void (^)(NSDictionary *dict))block;
- (void)handleWithReceiveScriptMessage:(WKScriptMessage *)message;
- (void)removeAllMethods;

@end
