//
//  SFNonDataView.m
//  SofficeMoi
//
//  Created by Eayon on 15/12/9.
//  Copyright © 2015年 Soffice. All rights reserved.
//

#import "SFNonDataView.h"

@interface SFNonDataView ()

@property (strong, nonatomic) UIImageView   *mErrorImageView;

@end

@implementation SFNonDataView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        [self loadComponent:frame];
    }
    return self;
}

#pragma mark - 加载组件

-(void)loadComponent:(CGRect)frame
{
    [self setHidden:YES];

    UITapGestureRecognizer *gasture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(refreshButtonClick)];
    self.userInteractionEnabled =YES;
    [self addGestureRecognizer:gasture];
    
    self.mErrorImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    self.mErrorImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.mErrorImageView];
}

- (void)setHiddenNoDataView:(BOOL)hiddenNoDataView {
    _hiddenNoDataView = hiddenNoDataView;
    self.hidden = hiddenNoDataView;
}

- (void) refreshButtonClick
{
    if (self.pressRefreshButtonBlock) {
        self.pressRefreshButtonBlock();
    }
}
- (void) setMErrorViewImageName:(NSString *)mErrorViewImageName
{
    UIImage *img = [UIImage imageNamed:mErrorViewImageName];
    CGFloat w = [UIScreen mainScreen].bounds.size.width*0.4;
    CGFloat imgH = img.size.height/img.size.width*w;
    self.mErrorImageView.frame = CGRectMake((self.frame.size.width-w)*0.5, (self.frame.size.height-imgH)*0.5, w, imgH);
    [self.mErrorImageView setImage:img];
}

- (void)setNoDataImageOffsetY:(CGFloat)y
{
    CGRect frame = self.mErrorImageView.frame;
    frame.origin.y += y;
    self.mErrorImageView.frame = frame;
}

@end
