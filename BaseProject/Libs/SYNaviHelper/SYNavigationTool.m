//
//  SYNavigationTool.m
//  SYFrameWork
//
//  Created by 王声远 on 17/3/9.
//  Copyright © 2017年 王声远. All rights reserved.
//

#import "SYNavigationTool.h"

#define IPhoneWidth   ([[UIScreen mainScreen] bounds].size.width)    //手机屏幕宽
#define IPhoneHeight ([[UIScreen mainScreen] bounds].size.height)    //手机屏幕高

#define back_image @"back_white"
#define SFCOLOR_BLACK_COLOR [UIColor whiteColor]
#define SFFONT_NAV_TITLE_SIZE 18.0                      // 默认导航字体大小
#define kNavigationLeftRightFont 14
#define kDefaultColor [UIColor blackColor]

@interface SYNavigationTool()

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) NSMutableDictionary *blocks;         //标题

@end

@implementation SYNavigationTool

- (void)addTitle:(NSString *)title ctl:(UIViewController *)ctl tintColor:(UIColor *)titleColor{
    if (![ctl.navigationItem.titleView isEqual:self.titleLabel]) {
        ctl.navigationItem.titleView = self.titleLabel;
    }
    if (titleColor) {
        self.titleLabel.textColor = titleColor;
    }
    self.titleLabel.text = title;
}

- (void)addLeft:(id)left ctl:(UIViewController *)ctl tintColor:(UIColor *)color clickBlock:(NavButtonClickBlock)block{

    if (!left) {
        UIImage *image = [[UIImage imageNamed:back_image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIBarButtonItem *leftItem = [self getItem];
        leftItem.image = image;
        ctl.navigationItem.leftBarButtonItem = leftItem;
        if (block) {
            [self.blocks setValue:block forKey:[self getObjectKey:leftItem]];
        }
        return;
    }
    
    color = color ?: kDefaultColor;
    if ([left isKindOfClass:[NSArray class]]) {
        [self setItems:left left:YES controller:ctl tintColor:color clickBlock:block];
    }
    else {
        ctl.navigationItem.leftBarButtonItem = [self getItem:left tag:0 left:YES tintColor:color clickBlock:block];
    }
}

- (void)addRight:(id)right ctl:(UIViewController *)ctl tintColor:(UIColor *)color clickBlock:(NavButtonClickBlock)block {
    if (!right) {
        return;
    }
    color = color ?: kDefaultColor;
    if ([right isKindOfClass:[NSArray class]]) {
        [self setItems:right left:NO controller:ctl tintColor:color clickBlock:block];
    }
    else {
        ctl.navigationItem.rightBarButtonItem = [self getItem:right tag:0 left:NO tintColor:color clickBlock:block];
    }
}

- (UIBarButtonItem *)getItem:(id)titleOrImage tag:(NSInteger)tag left:(BOOL)left tintColor:(UIColor *)color clickBlock:(NavButtonClickBlock)block{
    
    UIBarButtonItem *item = [self getItem];
    item.tag = tag;
    [item setTintColor:color];
    
    if ([titleOrImage isKindOfClass:[UIImage class]]) {
        item.image = titleOrImage;
        if (block) {
            [self.blocks setValue:block forKey:[self getObjectKey:item]];
        }
    }
    else if ([titleOrImage isKindOfClass:[NSString class]]) {
        UIEdgeInsets insert = left? UIEdgeInsetsMake(0, -20, 0, 0) : UIEdgeInsetsMake(0, 0, 0, -20);
        UIButton *button = [self getButtonTitleEdge:insert title:titleOrImage titleColor:color];
        button.tag = tag;
        [item setCustomView:button];
        if (block) {
            [self.blocks setValue:block forKey:[self getObjectKey:button]];
        }
    }
    return item;
}

- (void)setItems:(NSArray *)titleOrImages left:(BOOL)left controller:(UIViewController *)ctl tintColor:(UIColor *)color clickBlock:(NavButtonClickBlock)block {
    
    NSMutableArray<UIBarButtonItem *> *items = [NSMutableArray array];
    for (int i = 0; i < titleOrImages.count; i ++) {
        UIBarButtonItem *item = [self getItem:titleOrImages[i] tag:i left:left tintColor:color clickBlock:block];
        [items addObject:item];
    }
    
    if (left) {
        ctl.navigationItem.leftBarButtonItems = items;
    }
    else {
        ctl.navigationItem.rightBarButtonItems = items;
    }
}

#pragma mark - 懒加载
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, 80,44)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [_titleLabel setFont:[UIFont systemFontOfSize:18]];
    }
    return _titleLabel;
}

- (NSMutableDictionary *)blocks {
    if (!_blocks) {
        _blocks = [NSMutableDictionary dictionary];
    }
    return _blocks;
}

- (UIButton *)getButtonTitleEdge:(UIEdgeInsets)insets title:(NSString *)title titleColor:(UIColor *)color {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, 44, 44)];
    button.tag = 0;
    [button addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    button.backgroundColor = [UIColor clearColor];
    button.titleLabel.font = [UIFont systemFontOfSize:kNavigationLeftRightFont];
    button.titleEdgeInsets = insets;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    return button;
}

- (UIBarButtonItem *)getItem {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] init];
    item.tag = 0;
    item.style = UIBarButtonItemStylePlain;
    item.target = self;
    item.action = @selector(clickBtn:);
    return item;
}

#pragma mark - 点击事件

- (NSString *)getObjectKey:(id)btn {
    return [NSString stringWithFormat:@"%p",btn];
}

- (void)clickBtn:(id)btn {
    id block = [self.blocks valueForKey:[self getObjectKey:btn]];
    if (block) {
        NavButtonClickBlock b = (NavButtonClickBlock)block;
        UIView *v = (UIView *)btn;
        NSLog(@"click id = %@ > tag=%ld",NSStringFromClass([btn class]),(long)v.tag);
        b(v.tag);
    }
}

@end
