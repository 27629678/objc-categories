//
//  NSObject+Accessory.m
//  mail
//
//  Created by hzyuxiaohua on 2017/3/13.
//  Copyright © 2017年 NetEase (Hangzhou) Network Co., Ltd. All rights reserved.
//

#import "NSObject+Accessory.h"

#import <objc/runtime.h>

extern BOOL has_method_for_obj(id obj, SEL sel)
{
    return class_getInstanceMethod([obj class], sel) != NULL;
}

@implementation NSObject (Accessory)

+ (BOOL)hasClassMethodForSelectorString:(NSString *)sel
{
    if (sel.length == 0) {
        return NO;
    }
    
    SEL selector = NSSelectorFromString(sel);
    
    return [self hasClassMethodForSelector:selector];
}

+ (BOOL)hasClassMethodForSelector:(SEL)sel
{
    return class_getClassMethod(self, sel) != NULL;
}

+ (BOOL)hasIvarWithName:(NSString *)ivar
{
    if (ivar.length == 0) {
        return NO;
    }
    
    unsigned int pCount = 0;
    const char* t1 = ivar.UTF8String;
    const char* t2 = [[NSString stringWithFormat:@"_%@", ivar] UTF8String];
    size_t len1 = strlen(t1);
    size_t len2 = strlen(t2);
    
    Ivar *vars = class_copyIvarList(self.class, &pCount);
    for (int idx = 0; idx < pCount; idx ++) {
        Ivar target = vars[idx];
        const char* t0 = ivar_getName(target);
        size_t len0 = strlen(t0);
        
        if (len0 != len1 && len0 != len2) {
            continue;
        }
        
        if (memcmp(t0, t1, MIN(len0, len1)) == 0) {
            return YES;
        }
        
        if (memcmp(t0, t2, MIN(len0, len2)) == 0) {
            return YES;
        }
    }
    
    return NO;
}

- (BOOL)hasPropertyWithName:(NSString *)property
{
    if (property.length == 0) {
        return NO;
    }
    
    return class_getProperty(self.class, property.UTF8String) != NULL;
}

- (BOOL)hasMethodForSelectorString:(NSString *)sel
{
    if (sel.length == 0) {
        return NO;
    }
    
    SEL selector = NSSelectorFromString(sel);
    
    return [self hasMethodForSelector:selector];
}

- (BOOL)hasMethodForSelector:(SEL)sel
{
    return class_getInstanceMethod(self.class, sel) != NULL;
}

- (void)gotoSelector:(SEL)aSelector
{
    void (*imp)(id, SEL)  = (void (*)(id, SEL))[self methodForSelector:aSelector];
    if(imp) {
        imp(self, aSelector);
    }
}

- (void)gotoSelector:(SEL)aSelector withObject:(id)object
{
    void (*imp)(id, SEL, id)  = (void (*)(id, SEL, id))[self methodForSelector:aSelector];
    if(imp) {
        imp(self, aSelector, object);
    }
}

- (void)gotoSelector:(SEL)aSelector withObject:(id)object1 withObject:(id)object2
{
    void (*imp)(id, SEL, id, id)  = (void (*)(id, SEL, id, id))[self methodForSelector:aSelector];
    if(imp) {
        imp(self, aSelector, object1, object2);
    }
}

- (id)gotoSelectorWithReturnValue:(SEL)aSelector
{
    id (*imp)(id, SEL)  = (id (*)(id, SEL))[self methodForSelector:aSelector];
    if(imp) {
        return imp(self, aSelector);
    }
    return nil;
}

- (id)gotoSelectorWithReturnValue:(SEL)aSelector withObject:(id)object
{
    id (*imp)(id, SEL, id)  = (id (*)(id, SEL, id))[self methodForSelector:aSelector];
    if(imp) {
        return imp(self, aSelector, object);
    }
    return nil;
}

- (id)gotoSelectorWithReturnValue:(SEL)aSelector withObject:(id)object1 withObject:(id)object2
{
    id (*imp)(id, SEL, id, id)  = (id (*)(id, SEL, id, id))[self methodForSelector:aSelector];
    if(imp) {
        return imp(self, aSelector, object1, object2);
    }
    return nil;
}


@end
