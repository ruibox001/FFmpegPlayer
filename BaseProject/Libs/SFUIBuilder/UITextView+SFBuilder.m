//
//  UITextView+SFBuilder.m
//  Tronker
//
//  Created by 王声远 on 2017/4/28.
//  Copyright © 2017年 Shenzhen Soffice Software. All rights reserved.
//

#import "UITextView+SFBuilder.h"
#import "UIView+SFBuilder.h"

@implementation UITextView (SFBuilder)

- (SFPropertyUITextViewIdTargetSelBlock)leftImgNameTargetSel
{
    return ^(id imgName,id target, SEL sel){
        [self addLeftBtn:imgName target:target sel:sel];
        return self;
    };
}

- (SFPropertyUITextViewIdTargetSelBlock)rightImgNameTargetSel
{
    return ^(id imgName,id target, SEL sel){
        [self addRightBtn:imgName target:target sel:sel];
        return self;
    };
}

- (void)addLeftBtn:(NSString *)imgName target:(id)target sel:(SEL)sec
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor clearColor];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    if (target && sec) {
        [button addTarget:target action:sec forControlEvents:UIControlEventTouchUpInside];
    }
    UIView *view = [self getBgView];
    [view addSubview:button];
    button.tag = 0;
    [button setFrame:CGRectMake(0, 0, view.frame.size.width/2.0, view.frame.size.height)];
    [self setInputAccessoryView:view];
}

- (void)addRightBtn:(NSString *)imgName target:(id)target sel:(SEL)sec
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor whiteColor];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    if (target && sec) {
        [button addTarget:target action:sec forControlEvents:UIControlEventTouchUpInside];
    }
    button.tag = 1;
    UIView *view = self.inputAccessoryView;
    if (!view) {
        view = [self getBgView];
    }
    [view addSubview:button];
    [button setFrame:CGRectMake(view.frame.size.width/2.0, 0, view.frame.size.width/2.0, view.frame.size.height)];
    [self setInputAccessoryView:view];
}

//InputAccessoryView的背景界面
- (UIView *)getBgView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
    [view setBackgroundColor:[UIColor whiteColor]];
    view.viewBorderColorWidthRadius([UIColor clearColor],@1,@1);
    
    return view;
}

@end
