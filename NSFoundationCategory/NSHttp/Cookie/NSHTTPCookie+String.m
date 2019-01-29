//
//  NSHTTPCookie+String.m
//  mail
//
//  Created by hzyuxiaohua on 2018/7/30.
//  Copyright © 2018 NetEase (Hangzhou) Network Co., Ltd. All rights reserved.
//

#import "NSHTTPCookie+String.h"

@implementation NSHTTPCookie (String)

- (NSString *)cookieString
{
    if (self.value.length == 0) {
        return self.name;
    }
    
    return [NSString stringWithFormat:@"%@=%@", self.name, self.value];
}

@end
