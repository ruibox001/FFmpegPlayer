//
//  WSYAlertView.m
//  Sinllia_iPhone2.0
//
//  Created by 王声远 on 15/6/4.
//  Copyright (c) 2015年 Daisy. All rights reserved.
//

#import "SYAlertView.h"

@interface SYAlertView()<UITextFieldDelegate>

@property (nonatomic,weak) UIView *alertView;

@property (nonatomic,assign) AlertInDirection iDirection;
@property (nonatomic,assign) AlertOutDirection oDirection;

@property (nonatomic,assign) CGRect startRect;

@end

@implementation SYAlertView

+ (instancetype) shareViewWithView:(UIView *)alertView AndInDirection:(AlertInDirection)iDirection andOutDirection:(AlertOutDirection)oDirection
{
    return [[self alloc]initWithView:alertView AndInDirection:iDirection andOutDirection:oDirection];
}

- (instancetype)initWithView:(UIView *)alertView AndInDirection:(AlertInDirection)iDirection andOutDirection:(AlertOutDirection)oDirection
{
    self = [super init];
    if (self) {
        
        self.frame = [UIScreen mainScreen].bounds;
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:self];
        
        [self addSubview:alertView];
        self.alertView = alertView;
        
        self.iDirection = iDirection;
        self.oDirection = oDirection;
        
        CGFloat viewWidth = self.alertView.frame.size.width;
        CGFloat viewHeight = self.alertView.frame.size.height;
        
        CGFloat selfWidth = self.frame.size.width;
        CGFloat selfHeight = self.frame.size.height;
        
        CGRect frame;
        
        switch (iDirection) {
            case AlertInDirectionFromTop:
                
                [self.alertView setFrame:CGRectMake((selfWidth - viewWidth) * 0.5, - viewHeight, viewWidth, viewHeight)];
                frame = self.alertView.frame;
                frame.origin.y = (selfHeight - viewHeight) * 0.5;
                
                break;
            case AlertInDirectionFromLeft:
                
                [self.alertView setFrame:CGRectMake(-viewWidth, (selfHeight - viewHeight) * 0.5, viewWidth, viewHeight)];
                frame = self.alertView.frame;
                frame.origin.x = (selfWidth - viewWidth) * 0.5;
                
                break;
            case AlertInDirectionFromRight:
                
                [self.alertView setFrame:CGRectMake(selfWidth, (selfHeight - viewHeight) * 0.5, viewWidth, viewHeight)];
                frame = self.alertView.frame;
                frame.origin.x = (selfWidth - viewWidth) * 0.5;
                
                break;
            case AlertInDirectionFromBotton:
                
                [self.alertView setFrame:CGRectMake((selfWidth - viewWidth) * 0.5, selfHeight + viewHeight, viewWidth, viewHeight)];
                frame = self.alertView.frame;
                frame.origin.y = (selfHeight - viewHeight) * 0.5;
                
                break;
                
            default:
                [self.alertView setFrame:CGRectMake((selfWidth - viewWidth) * 0.5,(selfWidth - viewHeight)* 0.5, viewWidth, viewHeight)];
                frame = self.alertView.frame;
                frame.origin.y = (selfHeight - viewHeight) * 0.5;
                break;
        }
        
        self.startRect = frame;
        [UIView animateWithDuration:0.5 animations:^{
            [self.alertView setFrame:frame];
            self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        } completion:^(BOOL finished) {
            [self keyBoardRegister];
        }];
    }
    return self;
}

- (void)dismiss
{
    [self endEditing:YES];
    CGFloat viewWidth = self.alertView.frame.size.width;
    CGFloat viewHeight = self.alertView.frame.size.height;
    
    CGFloat selfWidth = self.frame.size.width;
    CGFloat selfHeight = self.frame.size.height;
    
    CGRect frame;
    
    switch (self.oDirection) {
        case AlertOutDirectionFromTop:
            
            frame = self.alertView.frame;
            frame.origin.y = -viewHeight;
            
            break;
            
        case AlertOutDirectionFromLeft:
            
            frame = self.alertView.frame;
            frame.origin.x = -viewWidth;
            
            break;
            
        case AlertOutDirectionFromRight:
            
            frame = self.alertView.frame;
            frame.origin.x = viewWidth+selfWidth;
            
            break;
            
        case AlertOutDirectionFromBotton:
            
            frame = self.alertView.frame;
            frame.origin.y = selfHeight;
            
            break;
            
        default:
            
            frame = self.alertView.frame;
            frame.origin.y = selfHeight;
            
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
    CGRect frame = self.startRect;
    frame.origin.y = 285 - self.startRect.size.height;
    [UIView animateWithDuration:0.5 animations:^{
        [self.alertView setFrame:frame];
    }];
}

- (void)keyboardWillHidden:(NSNotification *)note
{
    [UIView animateWithDuration:0.5 animations:^{
        [self.alertView setFrame:self.startRect];
    }];
}

@end
