//
//  SFNonDataView.h
//  SofficeMoi
//
//  Created by Eayon on 15/12/9.
//  Copyright © 2015年 Soffice. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SFNonDataView : UIView

@property (strong, nonatomic) NSString  *mErrorViewImageName;  // 错误页面图标

@property (assign, nonatomic) BOOL hiddenNoDataView;

@property (copy, nonatomic) void (^pressRefreshButtonBlock)(void);

- (void)setNoDataImageOffsetY:(CGFloat)y;

@end
