//
//  WSYTBAlertView.m
//  IEasyHome
//
//  Created by 王声远 on 15/8/20.
//  Copyright (c) 2015年 anody. All rights reserved.
//

#import "SYTBAlertView.h"

@interface SYTBAlertView()<UITextFieldDelegate>

@property (nonatomic,weak) UIView *alertView;
@property (nonatomic,assign) TBAlertViewType style;
@property (nonatomic,assign) CGRect startRect;

@end

@implementation SYTBAlertView

+ (instancetype) shareTBAlertViewWithView:(UIView *)alertView style:(TBAlertViewType)style
{
    return [[self alloc]initWithView:alertView style:style];
}

- (instancetype)initWithView:(UIView *)alertView style:(TBAlertViewType)style
{
    self = [super init];
    if (self) {
        
        self.frame = [UIScreen mainScreen].bounds;
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:self];
        
        [self addSubview:alertView];
        self.alertView = alertView;
        
        self.style = style;
        
        CGFloat viewWidth = self.alertView.frame.size.width;
        CGFloat viewHeight = self.alertView.frame.size.height;
        
        CGFloat selfWidth = self.frame.size.width;
        CGFloat selfHeight = self.frame.size.height;
        
        CGRect frame;
        
        switch (style) {
            case TBAlertViewTypeTop:
                
                [self.alertView setFrame:CGRectMake((selfWidth - viewWidth) * 0.5, - viewHeight, viewWidth, viewHeight)];
                frame = self.alertView.frame;
                frame.origin.y = 64;
                
                break;
            case TBAlertViewTypeBotton:
                
                [self.alertView setFrame:CGRectMake((selfWidth - viewWidth) * 0.5, selfHeight, viewWidth, viewHeight)];
                frame = self.alertView.frame;
                frame.origin.y = selfHeight - viewHeight;
                
                break;
                
            default:
                break;
        }
        
        self.startRect = frame;
        [UIView animateWithDuration:0.3 animations:^{
            [self.alertView setFrame:frame];
            self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        } completion:^(BOOL finished) {
            [self keyBoardRegister];
        }];
        
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickWindow:)];
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:gesture];
    }
    return self;
}

- (void)clickWindow:(UITapGestureRecognizer *)gesture
{
    [self dismiss];
}

- (void)dismiss
{
    [self endEditing:YES];
    //CGFloat viewWidth = self.alertView.frame.size.width;
    CGFloat viewHeight = self.alertView.frame.size.height;
    
    //CGFloat selfWidth = self.frame.size.width;
    CGFloat selfHeight = self.frame.size.height;
    
    CGRect frame;
    
    switch (self.style) {
        case TBAlertViewTypeTop:
            
            frame = self.alertView.frame;
            frame.origin.y = -viewHeight;
            
            break;
            
        case TBAlertViewTypeBotton:
            
            frame = self.alertView.frame;
            frame.origin.y = selfHeight;
            
            break;
            
        default:
            break;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.alertView setFrame:frame];
        self.alertView.alpha = 0;
    } completion:^(BOOL finished) {
        self.alertView = nil;
        [self keyBoadDisappear];
        [self removeFromSuperview];
    }];
}


- (void)keyBoardRegister
{
    // 2.监听键盘的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyBoadDisappear
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}


- (void)keyboardWillShow:(NSNotification *)note
{
    if (self.style == TBAlertViewTypeTop) {
        return;
    }
    CGRect frame = self.startRect;
    frame.origin.y = 285 - self.startRect.size.height;
    [UIView animateWithDuration:0.5 animations:^{
        [self.alertView setFrame:frame];
    }];
}

- (void)keyboardWillHidden:(NSNotification *)note
{
    if (self.style == TBAlertViewTypeTop) {
        return;
    }
    [UIView animateWithDuration:0.5 animations:^{
        [self.alertView setFrame:self.startRect];
    }];
}

@end
