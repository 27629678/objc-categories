//
//  NSDictionary+Accessory.h
//  mail
//
//  Created by hzyuxiaohua on 2017/2/22.
//  Copyright © 2017年 NetEase (Hangzhou) Network Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Accessory)

- (BOOL)booleanForKey:(id)key;

- (NSData *)dataForKey:(id)key;

- (NSString *)stringForKey:(id)key;

- (NSNumber *)numberForKey:(id)key;

- (NSArray *)arrayForKey:(id)key;

- (NSDictionary *)dictionaryForKey:(id)key;

- (id)objectForKeyChain:(NSString *)keyChain;

- (NSDictionary *)transformUsingKeys:(NSDictionary *)keys;

@end    // NSDictionary (Accessory)

@interface NSDictionary (NEJSON)

- (NSData *)jsonData;

- (NSString *)jsonString;

+ (instancetype)dictionaryFromJsonData:(NSData *)data;

+ (instancetype)dictionaryFromJsonString:(NSString *)json;

@end    // NSDictionary (NEJSON)

@interface NSDictionary (NEURL)

+ (instancetype)dictionaryFromUrlQuery:(NSString *)query;

@end    // NSDictionary (URL)

@interface NSMutableDictionary (Merge)

- (void)merge:(NSDictionary *)target;

@end    // NSMutableDictionary (Merge)

@interface NSDictionary (Merge)

- (NSDictionary *)merge:(NSDictionary *)target;

@end    // NSDictionary (Merge)

@interface NSDictionary (Array)

// @{k:v, k:v} => @[@{k:v}, @{k:v}]
- (NSArray *)transformToArray;

@end    // NSDictionary (Array)
