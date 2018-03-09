//
//  NSObject+SFBuilder.m
//  Tronker
//
//  Created by 王声远 on 17/3/28.
//  Copyright © 2017年 Shenzhen Soffice Software. All rights reserved.
//

#import "NSObject+SFBuilder.h"

@implementation NSObject (SFBuilder)

+ (void) objExchangeInstanceMethodWithOriginSel:(SEL)originalSelector newSel:(SEL)newSelector {
    
    NSParameterAssert(originalSelector);
    NSParameterAssert(newSelector);
    
    Class class = [self class];
    BOOL imp = [class instancesRespondToSelector:originalSelector];
    [[NSUserDefaults standardUserDefaults] setObject:@(imp) forKey:NSStringFromSelector(originalSelector)];
    if (imp) {
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method newMethod = class_getInstanceMethod(class, newSelector);
        method_exchangeImplementations(originalMethod, newMethod);
    }
    else {
        Method myMethod = class_getInstanceMethod(class, newSelector);
        class_addMethod(class, originalSelector, method_getImplementation(myMethod), method_getTypeEncoding(myMethod));
    }
}

- (instancetype (^)())objToName
{
    return ^(){
        return NSStringFromClass([self class]);
    };
}

- (NSString *)objUniKey {
    return [NSString stringWithFormat:@"%p",self];
}

- (void)decodeObjWithCoder:(NSCoder *)aCoder {
    unsigned int count = 0;
    Ivar *ivar = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++) {
        //根据每一个属性取出对应的key 注意key值是c语言的key
        Ivar iva = ivar[i];
        const char *key = ivar_getName(iva);
        // 转换为oc
        NSString *strName = [NSString stringWithUTF8String:key];
        //进行解档取值
        id value = [aCoder decodeObjectForKey:strName];
        //利用KVC对属性赋值
        [self setValue:value forKey:strName];
    }
}

- (void)encodeObjWithCoder:(NSCoder *)aCoder {
    unsigned int count;
    Ivar *ivar = class_copyIvarList([self class], &count);
    for (int i=0; i < count; i++) {
        Ivar iv = ivar[i];
        const char *name = ivar_getName(iv);
        NSString *strName = [NSString stringWithUTF8String:name];
        //利用KVC取值
        id value = [self valueForKey:strName];
        [aCoder encodeObject:value forKey:strName];
    }
    free(ivar);
}

+ (BOOL)setMethodIsAddOrExchangeWithSel:(SEL)sel {
    BOOL imp = [[self class] instancesRespondToSelector:sel];
    [[NSUserDefaults standardUserDefaults] setObject:@(imp) forKey:NSStringFromSelector(sel)];
    return !imp;
}

+ (BOOL)addMethodOrExchangeInstanceMethodWithSel:(SEL)sel {
    id ob = [[NSUserDefaults standardUserDefaults] objectForKey:NSStringFromSelector(sel)];
    return [ob boolValue];
}

@end
