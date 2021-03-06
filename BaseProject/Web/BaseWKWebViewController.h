//
//  STKBaseWKWebViewController.h
//  Tronker
//
//  Created by soffice-Jimmy on 2017/4/12.
//  Copyright © 2017年 Shenzhen Soffice Software. All rights reserved.
//

#import "BaseViewController.h"
#import "WKJsMethodControl.h"

typedef enum : NSUInteger {
    STKLoadURLTypeDefault,      //默认不显示
    STKLoadURLTypeShowShare     //导航栏右侧分享
} STKLoadURLType;

@interface BaseWKWebViewController : BaseViewController

@property (strong, nonatomic) NSString *titleString;

@property (strong, nonatomic) NSString *urlString;

@property (assign, nonatomic) STKLoadURLType urlType;

- (WKJsMethodControl *)getJsController;

@end
