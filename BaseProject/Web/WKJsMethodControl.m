//
//  WKJsMethodControl.m
//  BaseProject
//
//  Created by 王声远 on 2017/9/19.
//  Copyright © 2017年 王声远. All rights reserved.
//

#import "WKJsMethodControl.h"

@implementation JsMethodObejct

- (instancetype)initWithMethodName:(NSString *)name block:(void (^)(NSDictionary *dict))block {
    self = [super init];
    if (self) {
        self.methodName = name;
        self.methodBlock = block;
    }
    return self;
}

@end

@interface WKJsMethodControl()<WKScriptMessageHandler>

@property (weak, nonatomic) id<WKScriptMessageHandler> scriptDelegate; //解决ViewController释放失败问题
@property (nonatomic,strong) NSMutableArray<JsMethodObejct *> *methods;
@property (strong, nonatomic) WKUserContentController *uContentController;

@end

@implementation WKJsMethodControl

- (instancetype)initWithUcontentController:(WKUserContentController *)u delegate:(id<WKScriptMessageHandler>)delegate
{
    self = [super init];
    if (self) {
        self.uContentController = u;
        self.scriptDelegate = delegate;
    }
    return self;
}

- (NSMutableArray *)methods {
    if (!_methods) {
        _methods = [NSMutableArray array];
    }
    return _methods;
}

- (void)addJsmethod:(NSString *)method handler:(void (^)(NSDictionary *dict))block {
    JsMethodObejct *jo = [[JsMethodObejct alloc] initWithMethodName:method block:block];
    [self.methods addObject:jo];
    [self.uContentController addScriptMessageHandler:self name:method];
}

- (void)handleWithReceiveScriptMessage:(WKScriptMessage *)message {
    NSString *mName = message.name;
    if (mName == nil || mName.length == 0) {
        return;
    }
    for (JsMethodObejct *jobje in self.methods) {
        if ([jobje.methodName isEqualToString:mName]) {
            if (jobje.methodBlock) {
                jobje.methodBlock(message.body);
            }
            return;
        }
    }
}

- (void)removeAllMethods {
    for (JsMethodObejct *jobje in self.methods) {
        [self.uContentController removeScriptMessageHandlerForName:jobje.methodName];
    }
    [self.methods removeAllObjects];
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    if (self.scriptDelegate) {
        [self.scriptDelegate userContentController:userContentController didReceiveScriptMessage:message];
    }
    else {
        [self handleWithReceiveScriptMessage:message];
    }
}

@end
