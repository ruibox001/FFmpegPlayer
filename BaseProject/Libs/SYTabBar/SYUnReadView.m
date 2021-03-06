//
//  SYUnReadView.m
//  SofficeMoi
//
//  Created by Eayon on 5/15/15.
//  Copyright (c) 2015 Soffice. All rights reserved.
//

#import "SYUnReadView.h"

@interface SYUnReadView ()

@property (nonatomic,assign) UnReadCountStyle style;

@end

@implementation SYUnReadView

/**
 初始化
 @param frame 红点的frame
 @return self
 */
-(id)initWithFrame:(CGRect)frame style:(int)style
{
    self = [super initWithFrame:frame];
    if(self){
        self.style = style;
        self.backgroundColor = [UIColor redColor];
        self.textColor = [UIColor whiteColor];
        self.textAlignment = NSTextAlignmentCenter;
        self.adjustsFontSizeToFitWidth = YES;
        self.font = [UIFont boldSystemFontOfSize:11.0];
    }
    return self;
}

/**
 设置未读数和样式
 @param count 未读数，当style==UnReadCountStyleRedPoint时可以为0
 */
- (void)setUnReadCount:(int)count {
    if (self.style == UnReadCountStyleUnReadCount) {
        self.hidden = count == 0;
        self.text = [NSString stringWithFormat:@"%d",count];
        [self layerForViewWithRadius:self.frame.size.width*0.5 lineWidth:0 color:[UIColor clearColor]];
    }
    else if (self.style == UnReadCountStyleRedPoint) {
        self.hidden = count == 0;
        self.text = @"";
        [self layerForViewWithRadius:self.frame.size.width*0.5 lineWidth:6 color:[UIColor clearColor]];
    }
}

/**
 给View添加圆角效果
 @param radius 圆角radius
 @param width 圆角外边框的大小
 @param color 圆角外边框颜色
 */
-(void)layerForViewWithRadius:(CGFloat)radius lineWidth:(CGFloat)width color:(UIColor *)color
{
    //画边框
    [self.layer setMasksToBounds:YES];
    [self.layer setCornerRadius:radius];
    [self.layer setBorderWidth:width];
    [self.layer setBorderColor:color.CGColor];
}

@end
