//
//  NSDateFormatter+SF.h
//  DDG
//
//  Created by 王声远 on 17/3/21.
//  Copyright © 2017年 王声远. All rights reserved.
//

#import <Foundation/Foundation.h>

#define dateFormator [NSDateFormatter newDateFormatter]

@interface NSDateFormatter (SFBuilder)

+ (NSDateFormatter *)newDateFormatter;
- (NSDateFormatter *(^)(NSString *))dateFormaterWithFormat;

@end
