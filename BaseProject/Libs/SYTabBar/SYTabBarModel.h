//
//  SYTabBarModel.h
//  SYFrameWork
//
//  Created by 王声远 on 17/3/10.
//  Copyright © 2017年 王声远. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {
    TabBarImageTypeOnlyImage,
    TabBarImageTypeImageTitle
} TabBarImageType;

@interface SYTabBarModel : NSObject

@property (assign, nonatomic) TabBarImageType   type;
@property (assign, nonatomic) int unReadType;
@property (strong, nonatomic) NSString          *tarBarImageNormal; //未选中图片名称
@property (strong, nonatomic) NSString          *tarBarImagePress;  //选中图片名称
@property (strong, nonatomic) NSString          *tarBarName;        //tarBar名称
@property (assign, nonatomic) int               tarBarUnReadCount;  //tarBar未读数
@property (assign, nonatomic) CGFloat           tarBarOffsetY;      //tarBar的Y偏移值

@property (strong, nonatomic) UIColor *tarBarSelectColor;           //tarBar选中颜色
@property (strong, nonatomic) UIColor *tarBarUnSelectColor;         //tarBar未选中颜色

- (instancetype) initWithType:(TabBarImageType)type norImg:(NSString *)norImg preImg:(NSString *)preImg name:(NSString *)name norColor:(UIColor *)norColor seleColor:(UIColor *)seleColor unReadType:(int)unReadType offsetY:(CGFloat)offsetY;

@end
