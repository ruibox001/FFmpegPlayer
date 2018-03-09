//
//  NSData+SF.h
//  DDG
//
//  Created by 王声远 on 17/3/21.
//  Copyright © 2017年 王声远. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (SFBuilder)

- (NSDictionary *(^)())dataToDict;

- (NSString *(^)())dataToString;

- (NSData *)AES256EncryptWithKey:(NSString *)key;   //加密

- (NSData *)AES256DecryptWithKey:(NSString *)key;   //解密

@end
