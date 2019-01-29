//
//  NSMutableArray+Range.m
//  mail
//
//  Created by hzyuxiaohua on 2018/5/22.
//  Copyright © 2018 NetEase (Hangzhou) Network Co., Ltd. All rights reserved.
//

#import "NSMutableArray+Range.h"

@implementation NSMutableArray (Range)

- (NSArray *)objectsOfRange:(NSRange)range
{
    return [self objectsOfRange:range remove:NO];
}

- (NSArray *)objectsOfRange:(NSRange)range remove:(BOOL)remove
{
    if (range.location >= self.count || range.length == 0) {
        return nil;
    }
    
    NSUInteger count = MIN(range.length, self.count - range.location);
    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
    for (NSUInteger idx = 0; idx < count; idx ++) {
        [indexSet addIndex:(idx + range.location)];
    }
    
    NSArray *objects = [self objectsAtIndexes:indexSet];
    
    if (remove) {
        [self removeObjectsAtIndexes:indexSet];
    }
    
    return objects;
}

@end
