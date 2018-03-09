//
//  UIImage+SFBuilder.h
//  DDG
//
//  Created by 王声远 on 17/3/21.
//  Copyright © 2017年 王声远. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFUIBuilderDef.h"

#define placeHolderImage [UIImage imageNamed:@"kong_1.jpg"]
#define colorImage(x)    [SFUtils createImageWithColor:x]

@interface UIImage (SFBuilder)

//获取图片某点的颜色
- (UIColor *(^)(CGPoint point))imgGetColorAtPoint;

SF_UIImage_PROP(Empty) imgToCircleImage;

SF_UIImage_PROP(Object) imgChangImgColor;

SF_UIImage_PROP(CSize) imgScanWithSize;

@end
