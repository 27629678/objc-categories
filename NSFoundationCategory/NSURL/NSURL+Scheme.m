//
//  NSURL+Scheme.m
//  mail
//
//  Created by hzyuxiaohua on 2018/9/14.
//  Copyright © 2018 NetEase (Hangzhou) Network Co., Ltd. All rights reserved.
//

#import "NSURL+Scheme.h"

@implementation NSURL (Scheme)

- (BOOL)isHttpScheme
{
    return [self isCanonicalScheme:@"http"] || [self isCanonicalScheme:@"https"];
}

- (BOOL)isMailToScheme
{
    return [self isCanonicalScheme:@"mailto"];
}

- (BOOL)isNativeScheme
{
    return [self isCanonicalScheme:@"ios"];
}

#pragma mark - private

- (BOOL)isCanonicalScheme:(NSString *)scheme
{
    return [self.scheme caseInsensitiveCompare:scheme] == NSOrderedSame;
}

@end
