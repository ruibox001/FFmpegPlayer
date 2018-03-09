//
//  NSString+SF.h
//  Tronker
//
//  Created by 王声远 on 17/3/16.
//  Copyright © 2017年 Shenzhen Soffice Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SFUIBuilderDef.h"

#define knumberInputRule @"^[0-9]" //只输入数字正则

#define strAppendInStart(...) self.strAppendWithStart([NSString stringWithFormat:__VA_ARGS__])
#define strAppendInEnd(...) self.strAppendWithEnd([NSString stringWithFormat:__VA_ARGS__])
#define strIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )

#define mutableAttributeStr NSMutableAttributedString

#define strLocal(x)  [x toLocal]

@interface NSString (SFBuilder)

- (mutableAttributeStr *(^)())strToAttibuteString;

- (CGSize (^)(UIFont *,CGSize))strGetSize;

- (CGFloat (^)(UIFont *,CGFloat))strGetHeight ;

- (CGFloat (^)(UIFont *,CGFloat))strGetWidth;

- (int (^)())strToIntVal;

- (NSInteger (^)())strToIntegerVal;

- (float (^)())strToFloatVal;

- (BOOL (^)(NSString *))strValidateWithRule;

- (NSDictionary * (^)())strToDict;

- (NSData * (^)())strToData;

- (BOOL (^)(NSString *str))strContainStr;

- (BOOL (^)(NSString *str))strStartWith;

- (BOOL (^)(NSString *str))strEndWith;

SF_NSString_PROP(String) strAppendWithStart;

SF_NSString_PROP(String) strAppendWithEnd;

SF_NSString_PROP(String) strIgnoreStr;

SF_NSString_PROP(TwoObject)strReplaceStr;

SF_NSString_PROP(Empty) strToMd5;

- (BOOL (^)()) strIsImgUrl;
- (UIColor *(^)())strToColor;

- (NSDate *(^)(NSString *))strFormatToDate;

- (NSTimeInterval (^)(NSString *)) strSecondWithFormat;

- (BOOL (^)())strIsInteger;

- (BOOL (^)())strIsFloat;

SF_NSString_PROP(Int) strFormatNumberStyle;

- (UIImage *(^)()) strLocalImage;
- (UIImage *(^)()) strFileToImage;

//字符串反转
SF_NSString_PROP(Empty) strReverse;

- (NSURL *(^)())strToURL;

/******************************************************************************
 函数名称 : + (NSString *)base64Decrypt
 函数描述 : base64格式字符串转换为文本数据(解密)
 输出参数 : N/A
 返回参数 : (NSString *)
 备注信息 :
 ******************************************************************************/
- (NSString *)base64Decrypt;

/******************************************************************************
 函数名称 : + (NSString *)base64Encrypt
 函数描述 : 文本数据转换为base64格式字符串(加密)
 输出参数 : N/A
 返回参数 : (NSString *)
 备注信息 :
 ******************************************************************************/
- (NSString *)base64Encrypt;

- (NSString *(^)()) cutFloatEndZero;

@end
