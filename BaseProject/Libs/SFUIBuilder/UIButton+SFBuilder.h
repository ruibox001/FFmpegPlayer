//
//  UIButton+Builder.h
//  SFFrameWork
//
//  Created by 王声远 on 17/3/13.
//  Copyright © 2017年 王声远. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFUIBuilderDef.h"

#define Button   [UIButton buttonWithType:UIButtonTypeCustom]

@interface UIButton (SFBuilder)

/**
 UIButton的普通状态文本
 @return 链试调用返回
 */
SF_UIBUTTON_PROP(Object) btnNorTitle;
SF_UIBUTTON_PROP(Object) btnNorImage;
SF_UIBUTTON_PROP(Object) btnNorAttributeStr;

/**
 UIButton的选中状态文本
 @return 链试调用返回
 */
SF_UIBUTTON_PROP(Object) btnSeleTitle;
SF_UIBUTTON_PROP(Object) btnSeleImage;
SF_UIBUTTON_PROP(Object) btnSeleAttributeStr;

/**
 UIButton的普通状态文本颜色
 @return 链试调用返回
 */
SF_UIBUTTON_PROP(Object) btnNorTitleColor;

/**
 UIButton的选中状态文本颜色
 @return 链试调用返回
 */
SF_UIBUTTON_PROP(Object) btnSeleTitleColor;

/**
 UIButton的文本大小
 @return 链试调用返回
 */
SF_UIBUTTON_PROP(Object) btnFont;

/**
 UIButton的点击事件
 @return 链试调用返回
 */
SF_UIBUTTON_PROP(TargetSel) btnTargetAction;

/**
 UIButton的设置是否select
 @return 链试调用返回
 */
SF_UIBUTTON_PROP(Bool) btnSelet;

SF_UIBUTTON_PROP(Int) btnAlign;

@end
