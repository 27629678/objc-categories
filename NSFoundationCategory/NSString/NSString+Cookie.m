//
//  NSString+Cookie.m
//  mail
//
//  Created by hzyuxiaohua on 2018/7/30.
//  Copyright © 2018 NetEase (Hangzhou) Network Co., Ltd. All rights reserved.
//

#import "NSString+Cookie.h"

#import "NSString+TrimmingAdditions.h"

@implementation NSString (Cookie)

- (NSDictionary *)cookies
{
    NSArray *items = [self componentsSeparatedByString:@";"];
    NSMutableDictionary *cookies = [NSMutableDictionary dictionary];
    for (NSString *item in items) {
        NSArray *targets = [item componentsSeparatedByString:@"="];
        if (targets.count != 2) {
            continue;
        }
        
        [cookies setObject:[targets.lastObject trimmingWhiteAndNewlineCharacters]
                    forKey:[targets.firstObject trimmingWhiteAndNewlineCharacters]];
    }
    
    
    return cookies.copy;
}

@end
