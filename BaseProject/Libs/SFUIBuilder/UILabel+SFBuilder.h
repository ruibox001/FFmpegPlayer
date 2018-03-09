//
//  UILabel+SFBuilder.h
//  SFFrameWork
//
//  Created by 王声远 on 17/3/13.
//  Copyright © 2017年 王声远. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFUIBuilderDef.h"

#define Label   [UILabel new]

@interface UILabel (SFBuilder)

/**
 UILabel的文本设置
 @return 链试调用返回
 */
SF_UILABEL_PROP(Object) labelText;

/**
 UILabel的文本字体
 @return 链试调用返回
 */
SF_UILABEL_PROP(Object) labelFont;

/**
 UILabel的文本颜色
 @return 链试调用返回
 */
SF_UILABEL_PROP(Object) labelTextColor;

/**
 UILabel的文本对齐方式
 @return 链试调用返回
 */
SF_UILABEL_PROP(Int) labelAlign;

/**
 UILabel添加富文本字符串
 @return 链试调用返回
 */
SF_UILABEL_PROP(Object) labelmAttiStr;

/**
 UILabel添加底下链接线
 UILabel添加中间抛弃线
 @return 链试调用返回
 */
SF_UILABEL_PROP(Object) labelBottonLineWithColor;
SF_UILABEL_PROP(Object) labelMiddleLineWithColor;

SF_UILABEL_PROP(Int) labelLineNum;

@end
