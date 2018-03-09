//
//  UIImageView+SFBuilder.h
//  SFFrameWork
//
//  Created by 王声远 on 17/3/14.
//  Copyright © 2017年 王声远. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFUIBuilderDef.h"

#define ImageView   [UIImageView new]

@interface UIImageView (SFBuilder)

/**
 UIImageView的图片
 @return 链试调用返回
 */
SF_UIIMAGEVIEW_PROP(Object) imgViewImg;

/**
 UIImageView的图片模式
 @return 链试调用返回
 */
SF_UIIMAGEVIEW_PROP(Int) imgViewMode;

@end
