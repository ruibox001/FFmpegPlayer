//
//  UIView+SFBuilder.m
//  SFFrameWork
//
//  Created by 王声远 on 17/3/14.
//  Copyright © 2017年 王声远. All rights reserved.
//

#import "UIView+SFBuilder.h"

@implementation UIView (SFBuilder)

/**
 UIView的边框大小颜色圆角
 @return 链试调用返回
 */
- (SFPropertyUILabelThreeObjectBlock)viewBorderColorWidthRadius {
    return ^id (id borderColor, id borderWidth, id radius) {
        UIColor *color = nil;
        if ([borderColor isKindOfClass:[UIColor class]]) {
            color = borderColor;
        }
        if (color) {
            [self.layer setMasksToBounds:YES];
            [self.layer setCornerRadius:[radius intValue]];
            [self.layer setBorderWidth:[borderWidth floatValue]];
            [self.layer setBorderColor:color.CGColor];
        }
        return self;
    };
}

/**
 UIView的点击事件
 @return 链试调用返回
 */
- (SFPropertyUIViewTargetSelBlock)viewTargetSel {
    return ^ (id target, SEL sel) {
        if (target && sel) {
            UITapGestureRecognizer *gasture = [[UITapGestureRecognizer alloc] initWithTarget:target action:sel];
            self.userInteractionEnabled =YES;
            [self addGestureRecognizer:gasture];
        }
        return self;
    };
}

- (SFPropertyUIViewTargetSelBlock)viewLongTargetSel{
    return ^ (id target, SEL sel) {
        if (target && sel) {
            self.userInteractionEnabled =YES;
            UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:target action:sel];
            gesture.minimumPressDuration = 0.5;
            [self addGestureRecognizer:gesture];
        }
        return self;
    };
}

/**
 UIView的frame
 @return 链试调用返回
 */
- (SFPropertyUIViewRectBlock)viewxywhFrame {
    return ^ (SFRect rect) {
        [self setFrame:rect.value];
        return self;
    };
}

- (SFPropertyUIViewObjectBlock)viewIntoView {
    return ^ (id pView) {
        if ([pView isKindOfClass:[UIView class]]) {
            [pView addSubview:self];
        }
        return self;
    };
}

/**
 UIView的origin.x
 @return 链试调用返回
 */
- (SFPropertyUIViewFloatBlock)viewOx {
    return ^ (CGFloat x) {
        CGRect frame = self.frame;
        frame.origin.x = x;
        [self setFrame:frame];
        return self;
    };
}

/**
 UIView的origin.y
 @return 链试调用返回
 */
- (SFPropertyUIViewFloatBlock)viewOy {
    return ^ (CGFloat y) {
        CGRect frame = self.frame;
        frame.origin.y = y;
        [self setFrame:frame];
        return self;
    };
}

/**
 UIView的size.width
 @return 链试调用返回
 */
- (SFPropertyUIViewFloatBlock)viewW {
    return ^ (CGFloat w) {
        CGRect frame = self.frame;
        frame.size.width = w;
        [self setFrame:frame];
        return self;
    };
}

/**
 UIView的size.height
 @return 链试调用返回
 */
- (SFPropertyUIViewFloatBlock)viewH {
    return ^ (CGFloat h) {
        CGRect frame = self.frame;
        frame.size.height = h;
        [self setFrame:frame];
        return self;
    };
}

/**
 UIView的origin
 @return 链试调用返回
 */
- (SFPropertyUIViewPointBlock)viewxyOrigin {
    return ^ (SFPoint xy) {
        CGRect frame = self.frame;
        frame.origin = xy.value;
        [self setFrame:frame];
        return self;
    };
}

/**
 UIView的size
 @return 链试调用返回
 */
- (SFPropertyUIViewSizeBlock)viewwhSize {
    return ^ (SFSize wh) {
        CGRect frame = self.frame;
        frame.size = wh.value;
        [self setFrame:frame];
        return self;
    };
}

/**
 UIView的缩放X轴
 @return 链试调用返回
 */
- (SFPropertyUIViewFloatBlock)viewScaleX {
    return ^ (CGFloat scaleX) {
        [self.layer setValue:@(scaleX) forKeyPath:@"transform.scale.x"];
        return self;
    };
}

/**
 UIView的缩放Y轴
 @return 链试调用返回
 */
- (SFPropertyUIViewFloatBlock)viewScaleY {
    return ^ (CGFloat scaleY) {
        [self.layer setValue:@(scaleY) forKeyPath:@"transform.scale.y"];
        return self;
    };
}

//背景颜色
- (SFPropertyUIViewObjectBlock)viewBgColor {
    return ^id (id bgColor) {
        if ([bgColor isKindOfClass:[UIColor class]]) {
            self.backgroundColor = bgColor;
        }
        return self;
    };
}

- (SFPropertyUIViewIntBlock)viewTag {
    return ^(NSInteger t){
        self.tag = t;
        return self;
    };
}

- (SFPropertyUIViewBoolBlock)viewUserEnable {
    return ^(BOOL enabel){
        self.userInteractionEnabled = enabel;
        return self;
    };
}

- (SFPropertyUIViewBoolBlock)viewHidden {
    return ^(BOOL hidden){
        self.hidden = hidden;
        return self;
    };
}

- (SFPropertyUIViewIntBlock)viewContentMode
{
    return ^(NSInteger mode) {
        self.contentMode = mode;
        return self;
    };
}

/**
 给界面添加渐变颜色
 @return self
 */
- (SFPropertyUIViewObjectBlock)viewMakerAlpha {
    return ^ (id maker) {
        if (!maker) {
            return self;
        }
        if ([maker isKindOfClass:[SFAlphaMaker class]]) {
            SFAlphaMaker *mk = maker;
            
            NSMutableArray *cgColors = [NSMutableArray array];
            for (UIColor *color in mk.alphaColors) {
                NSAssert([color isKindOfClass:[UIColor class]],@"alphaColors必须为颜色数据");
                [cgColors addObject:(__bridge id)color.CGColor];
            }
            if (cgColors.count == 0) {
                return self;
            }
            
            CAGradientLayer *gradientLayer = [CAGradientLayer layer];
            gradientLayer.colors = cgColors;
            if (mk.locs && mk.locs.count > 0) {
                gradientLayer.locations = mk.locs;
            }
            else {
                gradientLayer.locations = @[@0, @1.0];
            }
            gradientLayer.startPoint = mk.sPoint;
            gradientLayer.endPoint = mk.ePoint;
            gradientLayer.frame = self.bounds;
            [self.layer addSublayer:gradientLayer];
        }
        return self;
    };
}

/**
 通过界面生成图片
 @return 返回图片
 */
- (UIImage *(^)())viewSnapshotToImage
{
    return ^(){
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0);
        [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
    };
}

/**
 通过界面生成界面
 @return 生成截图的View
 */
- (UIView *(^)())viewCustomViewFromSnapshop {
    return ^(){
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        UIView *snapshot = [[UIImageView alloc] initWithImage:image];
        snapshot.backgroundColor = [UIColor whiteColor];
        return snapshot;
    };
}

/**
 给界面添加渐变颜色
 @param alphaColors 渐变颜色数组
 @param startPoint 开始点0-1
 @param endPoint 结束点0-1
 */
- (void)viewAddAlphaColors:(NSArray *)alphaColors startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint{
    NSMutableArray *cgColors = [NSMutableArray array];
    for (UIColor *color in alphaColors) {
        NSAssert([color isKindOfClass:[UIColor class]],@"alphaColors必须为颜色数据");
        [cgColors addObject:(__bridge id)color.CGColor];
    }
    if (cgColors.count == 0) {
        return;
    }
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = cgColors;
    gradientLayer.locations = @[@0, @1.0];
    gradientLayer.startPoint = startPoint;
    gradientLayer.endPoint = endPoint;
    gradientLayer.frame = self.frame;
    [self.layer addSublayer:gradientLayer];
}

- (UIViewController *(^)())viewGetMyController {
    return ^(){
        UIViewController *viewController = nil;
        UIResponder *next = self.nextResponder;
        while (next)
        {
            if ([next isKindOfClass:[UIViewController class]])
            {
                viewController = (UIViewController *)next;
                break;
            }    
            next = next.nextResponder;  
        } 
        return viewController;
    };
}

@end
