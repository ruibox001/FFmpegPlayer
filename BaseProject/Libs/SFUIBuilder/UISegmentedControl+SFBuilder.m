//
//  UISegmentedControl+SFBuilder.m
//  Tronker
//
//  Created by 王声远 on 2017/5/12.
//  Copyright © 2017年 Shenzhen Soffice Software. All rights reserved.
//

#import "UISegmentedControl+SFBuilder.h"

@implementation UISegmentedControl (SFBuilder)

/*
_titleView = [[UISegmentedControl alloc]initWithItems:@[@"通知",@"对话"]];
_titleView.frame = _titleBackgroundView.bounds;
_titleView.layer.cornerRadius = 4;
_titleView.layer.borderWidth = 1;
_titleView.layer.borderColor = UIColor_Tronker_MainColor.CGColor;
_titleView.clipsToBounds = YES;
_titleView.tintColor = UIColor_Tronker_MainColor;
[_titleView setSelectedSegmentIndex:0];
UIFont *font = [UIFont systemFontOfSize:14.0f];
NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
[_titleView setTitleTextAttributes:attributes forState:UIControlStateNormal];
[_titleView setTitleTextAttributes:attributes forState:UIControlStateSelected];
[_titleView addTarget:self action:@selector(segmentedControlClick) forControlEvents:UIControlEventValueChanged];
*/

@end
