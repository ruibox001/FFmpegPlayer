//
//  NSMutableAttributedString+SF.h
//  Tronker
//
//  Created by 王声远 on 17/3/16.
//  Copyright © 2017年 Shenzhen Soffice Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define mutableAttributeStr NSMutableAttributedString

#define mutableAttrStr(x) [mutableAttributeStr attriStringToAttibuteStrings:x]

@interface NSMutableAttributedString (SFBuilder)

+ (mutableAttributeStr *)attriStringToAttibuteStrings:(NSString *)str ;

- (mutableAttributeStr *(^)(UIColor *,NSRange))attriColorRange ;

- (mutableAttributeStr *(^)(UIColor *))attriColor ;

- (mutableAttributeStr *(^)(UIFont *,NSRange))attriFontRange ;

- (mutableAttributeStr *(^)(UIFont *))attriFont ;

- (mutableAttributeStr *(^)(UIColor *,UIFont *,NSRange))attriColorFontRange ;

- (mutableAttributeStr *(^)(UIColor *,UIFont *))attriColorFont ;

- (mutableAttributeStr *(^)(NSTextAlignment,CGFloat,NSRange))attriAlignmentLineSpaceRange ;

- (mutableAttributeStr *(^)(NSTextAlignment,CGFloat))attriAlignmentLineSpace;

- (mutableAttributeStr *(^)(CGFloat))attriLineSpace;

- (mutableAttributeStr *(^)(NSTextAlignment))attriAlignment;

- (mutableAttributeStr *(^)(UIColor *))attributeBottonLineWithColor;
- (mutableAttributeStr *(^)(UIColor *,NSUnderlineStyle style))attributeLineColorAndStyle;

- (CGSize (^)(CGSize))attriGetSize ;

- (CGFloat (^)(CGFloat))attriGetHeight;

@end
