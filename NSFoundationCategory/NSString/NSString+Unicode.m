//
//  NSString+Unicode.m
//  mail
//
//  Created by h-yxh on 15-5-8.
//  Copyright (c) 2015年 NetEase (Hangzhou) Network Co., Ltd. All rights reserved.
//

#import "NSString+Unicode.h"

@implementation NSString (Unicode)

- (NSString *)unicodeString
{
    NSData* data = [self dataUsingEncoding:NSNonLossyASCIIStringEncoding];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

@end
