//
//  WKWebView+SFBuilder.m
//  Tronker
//
//  Created by 王声远 on 2017/4/28.
//  Copyright © 2017年 Shenzhen Soffice Software. All rights reserved.
//

#import "WKWebView+SFBuilder.h"

@implementation WKWebView (SFBuilder)

- (SFPropertyWKWebViewObjectBlock)runjs {
    return ^(id js){
        [self evaluateJavaScript:js completionHandler:nil];
        return self;
    };
}

- (void)runJs:(NSString *)js handler:(void (^)(id _Nullable, NSError * _Nullable))completionHandler
{
    [self evaluateJavaScript:js completionHandler:completionHandler];
}

+ (void)remoteAllCacheData:(void (^)(void))completionHandler {
    NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
    NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
    [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:completionHandler];
}

@end
