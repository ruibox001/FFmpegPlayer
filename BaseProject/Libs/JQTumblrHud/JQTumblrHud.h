//
//  JQTumblrHud.h
//
//  Created by HanJunqiang on 17/4/5.
//  Copyright © 2017年 HaRi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JQTumblrHud : UIView

/// hudColor
@property (nonatomic, strong) UIColor *hudColor;

/// showHud
-(void)showAnimated:(BOOL)animated;

/// hideHud
-(void)hideTumblrHud;

/*
 使用
 tumblrHUD = [[JQTumblrHud alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 55) * 0.5,(self.view.frame.size.height - 20) * 0.5, 55, 20)];
 tumblrHUD.hudColor = [UIColor grayColor];
 [self.view addSubview:tumblrHUD];
 [tumblrHUD showAnimated:YES];
 */

@end
