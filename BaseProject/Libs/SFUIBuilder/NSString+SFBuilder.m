//
//  NSString+SF.m
//  Tronker
//
//  Created by 王声远 on 17/3/16.
//  Copyright © 2017年 Shenzhen Soffice Software. All rights reserved.
//

#import "NSString+SFBuilder.h"
#import "SFUtils.h"
#import "NSDateFormatter+SFBuilder.h"

static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

@implementation NSString (SFBuilder)

- (mutableAttributeStr *(^)())strToAttibuteString {
    return ^(){
        return [[NSMutableAttributedString alloc] initWithString:self];
    };
}

- (CGSize (^)(UIFont *,CGSize))strGetSize {
    return ^(UIFont *font,CGSize size){
        NSDictionary *attrs = @{NSFontAttributeName : font};
        return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
    };
}

- (CGFloat (^)(UIFont *,CGFloat))strGetHeight {
    return ^(UIFont *font,CGFloat width){
        return self.strGetSize(font,CGSizeMake(width, HUGE)).height;
    };
}

- (CGFloat (^)(UIFont *,CGFloat))strGetWidth {
    return ^(UIFont *font,CGFloat height){
        return self.strGetSize(font,CGSizeMake(HUGE, height)).width;
    };
}

- (int (^)())strToIntVal {
    return ^(){
        return [[SFUtils numberWithString:self] intValue];
    };
}

- (NSInteger (^)())strToIntegerVal {
    return ^(){
        return [[SFUtils numberWithString:self] integerValue];
    };
}

- (float (^)())strToFloatVal {
    return ^(){
        return [[SFUtils numberWithString:self] floatValue];
    };
}

- (BOOL (^)(NSString *))strValidateWithRule {
    return ^(NSString *rule) {
        NSPredicate *redicate = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",rule];
        return [redicate evaluateWithObject:self];
    };
}

- (NSDictionary * (^)())strToDict {
    return ^(){
        NSError *err = nil;
        NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        return dic;
    };
}

- (NSData * (^)())strToData {
    return ^(){
        return [self dataUsingEncoding:NSUTF8StringEncoding];
    };
}

- (BOOL (^)(NSString *))strContainStr {
    return ^(NSString *str) {
        if([self rangeOfString:str options:NSCaseInsensitiveSearch].location != NSNotFound)
        {
            return YES;
        }
        return NO;
    };
}

- (BOOL (^)(NSString *))strStartWith {
    return ^(NSString *str) {
        return [self hasPrefix:str];
    };
}

- (BOOL (^)(NSString *))strEndWith {
    return ^(NSString *str) {
        return [self hasSuffix:str];
    };
}


- (SFPropertyNSStringStringBlock)strAppendWithStart {
    return ^(NSString *str) {
        return [str stringByAppendingString:self];
    };
}

- (SFPropertyNSStringStringBlock)strAppendWithEnd {
    return ^(NSString *str) {
        return [self stringByAppendingString:str];
    };
}

- (SFPropertyNSStringStringBlock)strIgnoreStr {
    return ^(NSString *object) {
        NSString *newStr = [self stringByReplacingOccurrencesOfString:object withString:@""];
        return newStr;
    };
}

- (SFPropertyNSStringTwoObjectBlock)strReplaceStr{
    return ^(id obj0,id obj1) {
        NSString *newStr = [self stringByReplacingOccurrencesOfString:obj0 withString:obj1];
        return newStr;
    };
}

- (BOOL (^)())strIsImgUrl {
    return ^() {
        if ([self hasPrefix:@"http"]) {
            return YES;
        }
        return NO;
    };
}

- (SFPropertyNSStringEmptyBlock)strToMd5 {
    return ^(){
        return [SFUtils md5HexDigestWithData:[self dataUsingEncoding:NSUTF8StringEncoding]];
    };
}

- (UIColor *(^)())strToColor {
    return ^(){
        return [SFUtils colorWithColorObject:self];
    };
}

- (NSTimeInterval (^)(NSString *)) strSecondWithFormat{
    return ^(NSString *format){
        return [[dateFormator.dateFormaterWithFormat(format) dateFromString:self] timeIntervalSince1970];
    };
}

- (BOOL (^)())strIsInteger {
    return ^() {
        NSScanner* scan = [NSScanner scannerWithString:self];
        NSInteger val;
        BOOL result = ([scan scanInteger:&val] && [scan isAtEnd]);
        return result;
    };
}

- (BOOL (^)())strIsFloat {
    return ^() {
        NSScanner* scan = [NSScanner scannerWithString:self];
        float val;
        BOOL result = ([scan scanFloat:&val] && [scan isAtEnd]);
        return result;
    };
}

- (NSDate *(^)(NSString *))strFormatToDate {
    return ^(NSString *f){
        return [dateFormator.dateFormaterWithFormat(f) dateFromString:self];
    };
}

/*enum {
    NSNumberFormatterNoStyle = kCFNumberFormatterNoStyle,                   123456789
    NSNumberFormatterDecimalStyle = kCFNumberFormatterDecimalStyle,         123,456,789
    NSNumberFormatterCurrencyStyle = kCFNumberFormatterCurrencyStyle,       ￥123,456,789.00
    NSNumberFormatterPercentStyle = kCFNumberFormatterPercentStyle,         -539,222,988%
    NSNumberFormatterScientificStyle = kCFNumberFormatterScientificStyle,   1.23456789E8
    NSNumberFormatterSpellOutStyle = kCFNumberFormatterSpellOutStyle        一亿二千三百四十五万六千七百八十九
}*/
- (SFPropertyNSStringIntBlock)strFormatNumberStyle {
    return ^(NSInteger style){
        if (!self.strIsInteger()) {
            return self;
        }
        NSNumber *num = [NSNumber numberWithInteger:[self integerValue]];
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        formatter.numberStyle = style;
        return [formatter stringFromNumber:num];
    };
}

- (UIImage *(^)())strLocalImage
{
    return ^(){
        return [UIImage imageNamed:self];
    };
}

- (UIImage *(^)()) strFileToImage
{
    return ^(){
        return [UIImage imageWithContentsOfFile:self];
    };
}

- (SFPropertyNSStringEmptyBlock)strReverse {
    return ^(){
        NSMutableString *reverString = [NSMutableString stringWithCapacity:self.length];
        [self enumerateSubstringsInRange:NSMakeRange(0, self.length) options:NSStringEnumerationReverse | NSStringEnumerationByComposedCharacterSequences  usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
            [reverString appendString:substring];
        }];
        return reverString;
    };
}

- (NSURL *(^)())strToURL
{
    return ^(){
        return [NSURL URLWithString:self];
    };
}

/******************************************************************************
 函数名称 : + (NSString *)base64Decrypt
 函数描述 : base64格式字符串转换为文本数据(解密)
 输出参数 : N/A
 返回参数 : (NSString *)
 备注信息 :
 ******************************************************************************/
- (NSString *)base64Decrypt
{
    static char *decodingTable = NULL;
    if (decodingTable == NULL)
    {
        decodingTable = malloc(256);
        if (decodingTable == NULL)
            return nil;
        memset(decodingTable, CHAR_MAX, 256);
        NSUInteger i;
        for (i = 0; i < 64; i++)
            decodingTable[(short)encodingTable[i]] = i;
    }
    
    const char *characters = [self cStringUsingEncoding:NSASCIIStringEncoding];
    if (characters == NULL)     //  Not an ASCII string!
        return nil;
    char *bytes = malloc((([self length] + 3) / 4) * 3);
    if (bytes == NULL)
        return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (YES)
    {
        char buffer[4];
        short bufferLength;
        for (bufferLength = 0; bufferLength < 4; i++)
        {
            if (characters[i] == '\0')
                break;
            if (isspace(characters[i]) || characters[i] == '=')
                continue;
            buffer[bufferLength] = decodingTable[(short)characters[i]];
            if (buffer[bufferLength++] == CHAR_MAX)      //  Illegal character!
            {
                free(bytes);
                return nil;
            }
        }
        
        if (bufferLength == 0)
            break;
        if (bufferLength == 1)      //  At least two characters are needed to produce one byte!
        {
            free(bytes);
            return nil;
        }
        
        //  Decode the characters in the buffer to bytes.
        bytes[length++] = (buffer[0] << 2) | (buffer[1] >> 4);
        if (bufferLength > 2)
            bytes[length++] = (buffer[1] << 4) | (buffer[2] >> 2);
        if (bufferLength > 3)
            bytes[length++] = (buffer[2] << 6) | buffer[3];
    }
    
    bytes = realloc(bytes, length);
    return [[NSString alloc] initWithBytes:bytes length:length encoding:NSUTF8StringEncoding];
}

/******************************************************************************
 函数名称 : + (NSString *)base64Encrypt
 函数描述 : 文本数据转换为base64格式字符串(加密)
 输出参数 : N/A
 返回参数 : (NSString *)
 备注信息 :
 ******************************************************************************/
- (NSString *)base64Encrypt
{
    if ([self length] == 0)
        return @"";
    
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    char *characters = malloc((([data length] + 2) / 3) * 4);
    if (characters == NULL)
        return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (i < [data length])
    {
        char buffer[3] = {0,0,0};
        short bufferLength = 0;
        while (bufferLength < 3 && i < [data length])
            buffer[bufferLength++] = ((char *)[data bytes])[i++];
        
        //  Encode the bytes in the buffer to four characters, including padding "=" characters if necessary.
        characters[length++] = encodingTable[(buffer[0] & 0xFC) >> 2];
        characters[length++] = encodingTable[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
        if (bufferLength > 1)
            characters[length++] = encodingTable[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
        else characters[length++] = '=';
        if (bufferLength > 2)
            characters[length++] = encodingTable[buffer[2] & 0x3F];
        else characters[length++] = '=';
    }
    
    return [[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSASCIIStringEncoding freeWhenDone:YES];
}

- (NSString *(^)()) cutFloatEndZero
{
    return ^(){
        if (![self containsString:@"."]) {
            return self;
        }
        if (self.strEndWith(@".")) {
            return [self substringToIndex:self.length-1];
        }
        
        if (self.strEndWith(@"0")) {
            NSString *stringFloat = [self substringToIndex:self.length - 1];
            return stringFloat.cutFloatEndZero();
        }
        return self;
    };
}

@end
