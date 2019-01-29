//
//  NSDictionary+Accessory.m
//  mail
//
//  Created by hzyuxiaohua on 2017/2/22.
//  Copyright © 2017年 NetEase (Hangzhou) Network Co., Ltd. All rights reserved.
//

#import "NSDictionary+Accessory.h"

@implementation NSDictionary (Accessory)

- (BOOL)booleanForKey:(id)key
{
    NSNumber* boolean = [self numberForKey:key];
    if (boolean) {
        return boolean.boolValue;
    }
    
    NSString* value = [self stringForKey:key];
    if ([value.lowercaseString isEqualToString:@"yes"] ||
        [value.lowercaseString isEqualToString:@"true"])
    {
        return YES;
    }
    
    return NO;
}

- (NSData *)dataForKey:(id)key
{
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSData class]]) {
        return value;
    }
    
    return nil;
}

- (NSString *)stringForKey:(id)key
{
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSString class]]) {
        return value;
    }
    
    if ([value isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *)value stringValue];
    }
    
    return nil;
}

- (NSNumber *)numberForKey:(id)key
{
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSNumber class]]) {
        return value;
    }
    
    if ([value isKindOfClass:[NSString class]]) {
        return @([value longLongValue]);
    }
    
    return nil;
}

- (NSArray *)arrayForKey:(id)key
{
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSArray class]]) {
        return value;
    }
    
    return nil;
}

- (NSDictionary *)dictionaryForKey:(id)key
{
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSDictionary class]]) {
        return value;
    }
    
    return nil;
}

- (NSDictionary *)transformUsingKeys:(NSDictionary *)keys
{
    NSMutableDictionary* dict = [NSMutableDictionary dictionary];
    [keys enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([obj isKindOfClass:[NSArray class]]) {
            NSMutableArray* values = [NSMutableArray array];
            
            for (id key in obj) {
                id value = [self concreteObjectForKey:key];
                
                if (!value) {
                    continue;
                }
                
                [values addObject:value];
            }
            
            [dict setObject:values.copy forKey:key];
            return;
        }
        
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSMutableDictionary* values = [NSMutableDictionary dictionary];
            [obj enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                id value = [self concreteObjectForKey:obj];
                
                if (!value) {
                    return;
                }
                
                [values setObject:value forKey:key];
            }];
            
            [dict setObject:values forKey:key];
            return;
        }
        
        id value = [self concreteObjectForKey:obj];
        if (value) {
            [dict setObject:value forKey:key];
        }
    }];
    
    return dict;
}

- (id)concreteObjectForKey:(id)key
{
    if ([key isKindOfClass:[NSString class]]) {
        return [self objectForKeyChain:key];
    }
    
    return [self objectForKey:key];
}

- (id)objectForKeyChain:(NSString *)keyChain
{
    id obj = [self objectForKey:keyChain];
    if (obj) {
        return obj;
    }
    
    NSArray* keys = [keyChain componentsSeparatedByString:@"."];
    if (keys.count <= 1) {
        return obj;
    }
    
    NSInteger idx = 0;
    obj = [self objectForKey:keys[idx ++]];
    for ( ; idx < keys.count; idx ++) {
        if (!obj || ![obj isKindOfClass:[NSDictionary class]]) {
            return nil;
        }
        
        NSString* key = [keys objectAtIndex:idx];
        if (idx == keys.count - 1) {
            return [obj objectForKey:key];
        }
        
        obj = [obj dictionaryForKey:key];
    }
    
    return obj;
}

@end    // NSDictionary (Accessory)

@implementation NSDictionary (NEJSON)

- (NSData *)jsonData
{
    NSError* error = nil;
    NSData* data = [NSJSONSerialization dataWithJSONObject:self options:0 error:&error];
    if (error) {
        NSLog(@"<NSDictionary+Json Error:%@>", error);
        return nil;
    }
    
    return data;
}

- (NSString *)jsonString
{
    NSData* data = [self jsonData];
    if (data.length == 0) {
        return nil;
    }
    
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

+ (instancetype)dictionaryFromJsonData:(NSData *)data
{
    if (!data) {
        return nil;
    }
    
    NSError *error = nil;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    
    if (error) {
        NSCAssert(NO, @"");
        NSLog(@"<NSDictionary+Json Error:%@>", error);
        return nil;
    }
    
    if (![dict isKindOfClass:[NSDictionary class]]) {
        NSCAssert(NO, @"");
        return nil;
    }
    
    return dict;
}

+ (instancetype)dictionaryFromJsonString:(NSString *)json
{
    if (json.length == 0) {
        return nil;
    }
    
    
    NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];
    
    return [NSDictionary dictionaryFromJsonData:data];
}

@end    // NSDictionary (NEJSON)

@implementation NSDictionary (NEURL)

+ (instancetype)dictionaryFromUrlQuery:(NSString *)query
{
    NSMutableDictionary* dict = [NSMutableDictionary dictionary];
    NSArray* components = [query componentsSeparatedByString:@"&"];
    for (NSString* component in components) {
        NSArray* key2value = [component componentsSeparatedByString:@"="];
        if (key2value.count > 2) {
            continue;
        }
        
        NSString* key = [key2value.firstObject stringByRemovingPercentEncoding];
        if (key2value.count == 1) {
            [dict setObject:@(YES) forKey:key];
            continue;
        }
        
        NSString* value = [key2value.lastObject stringByRemovingPercentEncoding];
        [dict setObject:value forKey:key];
    }
    
    return dict;
}

@end    // NSDictionary (URL)

@implementation NSMutableDictionary (Merge)

- (void)merge:(NSDictionary *)target
{
    if (![target isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    [target enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key,
                                                id  _Nonnull obj,
                                                BOOL * _Nonnull stop)
     {
         // 0. append
         if (![self objectForKey:key]) {
             [self setObject:obj forKey:key];
             
             return;
         }
         
         // 1. none dict value, merge with new value
         id origin_obj = [self objectForKey:key];
         if (![origin_obj isKindOfClass:[NSDictionary class]]) {
             [self setObject:obj forKey:key];
             
             return;
         }
         
         // 2. new obj is none dict value, merge with new value
         if (![obj isKindOfClass:[NSDictionary class]]) {
             [self setObject:obj forKey:key];
             
             return;
         }
         
         // 3. merge recursively
         BOOL isMutable = [origin_obj isKindOfClass:[NSMutableDictionary class]];
         NSMutableDictionary *origin = isMutable ? origin_obj : [origin_obj mutableCopy];
         [origin merge:obj];
         
         [self setObject:(isMutable ? origin : origin.copy) forKey:key];
     }];
}

@end    // NSMutableDictionary (Merge)

@implementation NSDictionary (Merge)

- (NSDictionary *)merge:(NSDictionary *)target
{
    NSMutableDictionary *ret_dict = self.mutableCopy;
    [ret_dict merge:target];
    
    return ret_dict.copy;
}

@end    // NSDictionary (Merge)

@implementation NSDictionary (Array)

- (NSArray *)transformToArray
{
    NSMutableArray *targets = [NSMutableArray array];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
        [targets addObject:@{ key: value }];
    }];
    
    return targets.copy;
}

@end    // NSDictionary (Array)
