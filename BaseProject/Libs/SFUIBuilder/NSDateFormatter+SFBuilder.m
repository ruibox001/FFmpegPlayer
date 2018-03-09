//
//  NSDateFormatter+SF.m
//  DDG
//
//  Created by 王声远 on 17/3/21.
//  Copyright © 2017年 王声远. All rights reserved.
//

#import "NSDateFormatter+SFBuilder.h"

@implementation NSDateFormatter (SFBuilder)

+ (NSDateFormatter *)newDateFormatter {
    static NSDateFormatter *dateFormatter = nil;
    if (!dateFormatter) {
        dateFormatter = [NSDateFormatter new];
    }
    return dateFormatter;
}

- (NSDateFormatter *(^)(NSString *))dateFormaterWithFormat {
    return ^(NSString *format){
        self.dateFormat = format;
        return self;
    };
}

@end
