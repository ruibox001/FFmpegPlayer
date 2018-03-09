//
//  NSDictionary+SF.h
//  DDG
//
//  Created by 王声远 on 17/3/21.
//  Copyright © 2017年 王声远. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFUIBuilderDef.h"

@interface NSDictionary (SFBuilder)

- (NSString* (^)())dictToString;

- (NSData* (^)())dictToData;

SF_NSDictionary_PROP(Object) dictAddDict;

- (BOOL (^)(NSString *)) dictMacthKey;

- (id (^)(NSString *))dictGetValueWithKey;

@end
