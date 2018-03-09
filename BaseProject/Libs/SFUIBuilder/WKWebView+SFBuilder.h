//
//  WKWebView+SFBuilder.h
//  SFFrameWork
//
//  Created by 王声远 on 2017/4/28.
//  Copyright © 2017年 Shenzhen Soffice Software. All rights reserved.
//

#import <WebKit/WebKit.h>
#import <UIKit/UIKit.h>
#import "SFUIBuilderDef.h"

@interface WKWebView (SFBuilder)
NS_ASSUME_NONNULL_BEGIN

SF_WKWebView_PROP(Object) runjs;
- (void)runJs:(NSString *)js handler:(void (^ _Nullable)(_Nullable id, NSError * _Nullable error))completionHandler;

+ (void)remoteAllCacheData:(void (^)(void))completionHandler;

NS_ASSUME_NONNULL_END
@end
