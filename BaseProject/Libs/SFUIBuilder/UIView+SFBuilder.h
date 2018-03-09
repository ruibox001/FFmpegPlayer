//
//  UIView+SFBuilder.h
//  SFFrameWork
//
//  Created by 王声远 on 17/3/14.
//  Copyright © 2017年 王声远. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFAlphaMaker.h"

#define View   [UIView new]

#define xywh(...) viewxywhFrame((SFRect){__VA_ARGS__})
#define xy(...)   viewxyOrigin((SFPoint){__VA_ARGS__})
#define wh(...)   viewwhSize((SFSize){__VA_ARGS__})

@interface UIView (SFBuilder)

/**
 UIView的边框大小颜色圆角
 @return 链试调用返回
 */
SF_UILABEL_PROP(ThreeObject) viewBorderColorWidthRadius;

/**
 UIView的点击事件
 @return 链试调用返回
 */
SF_UIVIEW_PROP(TargetSel) viewTargetSel;
SF_UIVIEW_PROP(TargetSel) viewLongTargetSel;

/**
 UIView的frame
 @return 链试调用返回
 */
SF_UIVIEW_PROP(Rect) viewxywhFrame;

/**
 UIView把当前界面添加到父控件上
 @return 链试调用返回
 */
SF_UIVIEW_PROP(Object) viewIntoView;

/**
 UIView的origin.x
 @return 链试调用返回
 */
SF_UIVIEW_PROP(Float) viewOx;

/**
 UIView的origin.y
 @return 链试调用返回
 */
SF_UIVIEW_PROP(Float) viewOy;

/**
 UIView的size.width
 @return 链试调用返回
 */
SF_UIVIEW_PROP(Float) viewW;

/**
 UIView的size.height
 @return 链试调用返回
 */
SF_UIVIEW_PROP(Float) viewH;

/**
 UIView的origin
 @return 链试调用返回
 */
SF_UIVIEW_PROP(Point) viewxyOrigin;

/**
 UIView的size
 @return 链试调用返回
 */
SF_UIVIEW_PROP(Size) viewwhSize;

/**
 UIView的缩放X轴
 @return 链试调用返回
 */
SF_UIVIEW_PROP(Float) viewScaleX;

/**
 UIView的缩放Y轴
 @return 链试调用返回
 */
SF_UIVIEW_PROP(Float) viewScaleY;

/**
 UIView的背景颜色
 @return 链试调用返回
 */
SF_UIVIEW_PROP(Object) viewBgColor;

SF_UIVIEW_PROP(Int) viewTag;

/**
 UIView通过SFAlphaMaker对象填充数据后再设置渐变
 @return 链试调用返回
 */
SF_UIVIEW_PROP(Object) viewMakerAlpha;
SF_UIVIEW_PROP(Bool) viewUserEnable;

SF_UIVIEW_PROP(Bool) viewHidden;

SF_UIVIEW_PROP(Int) viewContentMode;

/**
 通过界面生成图片
 @return 返回图片
 */
- (UIImage *(^)())viewSnapshotToImage;

/**
 通过界面生成界面
 @return 生成截图的View
 */
- (UIView *(^)())viewCustomViewFromSnapshop;

/**
 获取某个view所在的控制器
 */
- (UIViewController *(^)())viewGetMyController;

@end
