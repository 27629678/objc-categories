//
//  NSObject+Accessory.h
//  mail
//
//  Created by hzyuxiaohua on 2017/3/13.
//  Copyright © 2017年 NetEase (Hangzhou) Network Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

extern BOOL has_method_for_obj(id obj, SEL sel);

@interface NSObject (Accessory)

+ (BOOL)hasClassMethodForSelectorString:(NSString *)sel;

+ (BOOL)hasClassMethodForSelector:(SEL)sel;

+ (BOOL)hasIvarWithName:(NSString *)ivar;

- (BOOL)hasPropertyWithName:(NSString *)property;

- (BOOL)hasMethodForSelector:(SEL)sel;

- (BOOL)hasMethodForSelectorString:(NSString *)sel;

- (void)gotoSelector:(SEL)aSelector;
- (void)gotoSelector:(SEL)aSelector withObject:(id)object;
- (void)gotoSelector:(SEL)aSelector withObject:(id)object1 withObject:(id)object2;
- (id)gotoSelectorWithReturnValue:(SEL)aSelector;
- (id)gotoSelectorWithReturnValue:(SEL)aSelector withObject:(id)object;
- (id)gotoSelectorWithReturnValue:(SEL)aSelector withObject:(id)object1 withObject:(id)object2;

@end
