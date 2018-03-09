//
//  NSObject+SFBuilder.h
//  Tronker
//
//  Created by 王声远 on 17/3/28.
//  Copyright © 2017年 Shenzhen Soffice Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (SFBuilder)

+ (void) objExchangeInstanceMethodWithOriginSel:(SEL)originalSelector newSel:(SEL)newSelector;

- (instancetype (^)())objToName;

- (void)decodeObjWithCoder:(NSCoder *)aCoder;

- (void)encodeObjWithCoder:(NSCoder *)aCoder;

//设置是通过添加的还是通过交换的，这个结果直接影响addMethodOrExchangeInstanceMethodWithSel的值,返回YES为添加,NO时交换
+ (BOOL)setMethodIsAddOrExchangeWithSel:(SEL)sel;

//这个通过runtime机制添加或交换方法时判断是否是添加的，YES是添加的，NO是交换的
+ (BOOL)addMethodOrExchangeInstanceMethodWithSel:(SEL)sel;

@end
