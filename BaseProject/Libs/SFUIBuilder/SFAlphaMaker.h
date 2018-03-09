//
//  SFAlphaMaker.h
//  SFFrameWork
//
//  Created by 王声远 on 17/3/14.
//  Copyright © 2017年 王声远. All rights reserved.
//
//  功能：SFAlphaMaker对象填充数据后再设置给UIView实现渐变
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SFUIBuilderDef.h"

#define AlphaKer SFAlphaMaker

#define startPoint(...)   addStartPoint((SFPoint){__VA_ARGS__})
#define endPoint(...)   addEndPoint((SFPoint){__VA_ARGS__})

@interface SFAlphaMaker : NSObject

@property (strong, nonatomic) NSMutableArray *alphaColors;

@property (strong, nonatomic) NSMutableArray *locs;

@property (assign, nonatomic, readonly) CGPoint sPoint;

@property (assign, nonatomic, readonly) CGPoint ePoint;

AlphaKer *alphaBuilder();

/**
 添加渐变颜色
 */
- (AlphaKer *(^)(UIColor *))addColor;

/**
 添加渐变颜色数组
 */
- (AlphaKer *(^)(NSArray *))arrayColors;

/**
 添加渐变位置点数组，默认[0, 1.0]
 */
- (AlphaKer *(^)(NSArray *))arrayLocs;

/**
 添加渐变起点
 */
- (AlphaKer *(^)(SFPoint))addStartPoint;

/**
 添加结束起点
 */
- (AlphaKer *(^)(SFPoint))addEndPoint;

@end
