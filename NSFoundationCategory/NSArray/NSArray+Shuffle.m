//
//  NSArray+Shuffle.m
//  mail
//
//  Created by hzyuxiaohua on 2018/11/27.
//  Copyright © 2018 NetEase (Hangzhou) Network Co., Ltd. All rights reserved.
//

#import "NSArray+Shuffle.h"

@implementation NSArray (Shuffle)

- (id)anyObject
{
    if (self.count == 0) {
        return nil;
    }
    
    return [self objectAtIndex:arc4random_uniform((uint32_t)self.count)];
}

- (NSArray *)shuffleArray
{
    if (self.count == 0) {
        return self.copy;
    }
    
    NSMutableArray *ret = self.mutableCopy;
    
    size_t upper_bound = self.count;
    for (size_t idx = 0; idx != MAX(self.count, 10); idx ++) {
        size_t r1 = arc4random_uniform((uint32_t)upper_bound);
        size_t r2 = arc4random_uniform((uint32_t)upper_bound);
        if (r1 == r2) {
            continue;
        }
        
        [ret exchangeObjectAtIndex:r1 withObjectAtIndex:r2];
    }
    
    return ret.copy;
}

@end
