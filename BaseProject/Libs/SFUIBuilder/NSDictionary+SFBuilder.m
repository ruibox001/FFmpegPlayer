//
//  NSDictionary+SF.m
//  DDG
//
//  Created by 王声远 on 17/3/21.
//  Copyright © 2017年 王声远. All rights reserved.
//

#import "NSDictionary+SFBuilder.h"

@implementation NSDictionary (SFBuilder)

- (NSString* (^)())dictToString
{
    return ^(){
        NSError *parseError = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&parseError];
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    };
}

- (NSData* (^)())dictToData
{
    return ^(){
        NSError *parseError = nil;
        return [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&parseError];
    };
}

- (SFPropertyNSDictionaryObjectBlock)dictAddDict {
    return ^(id dict){
        NSMutableDictionary *d = [NSMutableDictionary dictionaryWithDictionary:self];
        if ([dict isKindOfClass:[NSDictionary class]]) {
            
            
            
            NSDictionary *dic = dict;
            for (NSString *key in dic.allKeys) {
                [d setObject:dic[key] forKey:key];
            }
        }
        return d;
    };
}

- (BOOL (^)(NSString *))dictMacthKey {
    return ^(NSString *key) {
        for (NSString *k in self.allKeys) {
            if ([key isEqualToString:k]) {
                return YES;
            }
        }
        return NO;
    };
}

- (id (^)(NSString *))dictGetValueWithKey {
    return ^(NSString *key){
        return [self objectForKey:key];
    };
}

@end
