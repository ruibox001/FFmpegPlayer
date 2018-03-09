//
//  NSMutableAttributedString+SF.m
//  Tronker
//
//  Created by 王声远 on 17/3/16.
//  Copyright © 2017年 Shenzhen Soffice Software. All rights reserved.
//

#import "NSMutableAttributedString+SFBuilder.h"

#define DefaultLineSpace 8  //默认行间距

#define selfRange NSMakeRange(0, self.length)

@implementation NSMutableAttributedString (SFBuilder)

+ (mutableAttributeStr *)attriStringToAttibuteStrings:(NSString *)str {
    return [[mutableAttributeStr alloc] initWithString:str];
}

- (mutableAttributeStr *(^)(UIColor *,NSRange))attriColorRange {
    return ^(UIColor *color,NSRange range){
        [self addAttribute:NSForegroundColorAttributeName value:color range:range];
        return self;
    };
}

- (mutableAttributeStr *(^)(UIColor *))attriColor {
    return ^(UIColor *color){
        [self addAttribute:NSForegroundColorAttributeName value:color range:selfRange];
        return self;
    };
}

- (mutableAttributeStr *(^)(UIFont *,NSRange))attriFontRange {
    return ^(UIFont *font,NSRange range){
        [self addAttribute:NSFontAttributeName value:font range:range];
        return self;
    };
}

- (mutableAttributeStr *(^)(UIFont *))attriFont {
    return ^(UIFont *font){
        [self addAttribute:NSFontAttributeName value:font range:selfRange];
        return self;
    };
}

- (mutableAttributeStr *(^)(UIColor *,UIFont *,NSRange))attriColorFontRange {
    return ^(UIColor *color,UIFont *font,NSRange range){
        [self addAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:color} range:range];
        return self;
    };
}

- (mutableAttributeStr *(^)(UIColor *,UIFont *))attriColorFont {
    return ^(UIColor *color,UIFont *font){
        [self addAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:color} range:selfRange];
        return self;
    };
}

- (mutableAttributeStr *(^)(NSTextAlignment,CGFloat,NSRange))attriAlignmentLineSpaceRange {
    return ^(NSTextAlignment a,CGFloat space,NSRange range){
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:space];
        paragraphStyle.alignment = a;
        [self addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
        return self;
    };
}

- (mutableAttributeStr *(^)(NSTextAlignment,CGFloat))attriAlignmentLineSpace {
    return ^(NSTextAlignment a,CGFloat space){
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:space];
        paragraphStyle.alignment = a;
        [self addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.length)];
        return self;
    };
}

- (mutableAttributeStr *(^)(CGFloat))attriLineSpace {
    return ^(CGFloat space){
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:space];
        [self addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.length)];
        return self;
    };
}

- (mutableAttributeStr *(^)(NSTextAlignment))attriAlignment {
    return ^(NSTextAlignment a){
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:DefaultLineSpace];
        paragraphStyle.alignment = a;
        [self addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.length)];
        return self;
    };
}

- (CGSize (^)(CGSize))attriGetSize {
    return ^(CGSize size){
        CGRect rect = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
        return rect.size;
    };
}

- (CGFloat (^)(CGFloat))attriGetHeight {
    return ^(CGFloat width){
        CGRect rect = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
        return rect.size.height;
    };
}

/**
 *  给文字添加下划线
 *  @return 属性字符串
 */
- (NSMutableAttributedString *(^)(UIColor *))attributeBottonLineWithColor {
    return ^(UIColor *color){
        NSRange contentRange = {0, [self length]};
        [self addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
        [self addAttribute:NSUnderlineColorAttributeName value:color range:contentRange];
        return self;
    };
}

- (NSMutableAttributedString *(^)(UIColor *, NSUnderlineStyle))attributeLineColorAndStyle {
    return ^(UIColor *color,NSUnderlineStyle style){
        NSRange contentRange = {0, [self length]};
        [self addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:style] range:contentRange];
        [self addAttribute:NSUnderlineColorAttributeName value:color range:contentRange];
        return self;
    };
}

@end
