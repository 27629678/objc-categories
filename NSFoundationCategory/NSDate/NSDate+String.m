//
//  NSDate+String.m
//  mail
//
//  Created by hzyuxiaohua on 2018/6/13.
//  Copyright © 2018 NetEase (Hangzhou) Network Co., Ltd. All rights reserved.
//

#import "NSDate+String.h"

@implementation NSDate (String)

- (NSString *)timeIntervalToString
{
    NSNumber *interval = @([self timeIntervalSince1970] * 1000);
    
    return [NSString stringWithFormat:@"%lld", interval.longLongValue];
}

+ (NSString *)currentTimeIntervalToString
{
    return [[NSDate date] timeIntervalToString];
}

@end
