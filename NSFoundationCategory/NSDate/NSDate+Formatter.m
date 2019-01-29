//
//  NSDate+Formatter.m
//  mail
//
//  Created by hzyuxiaohua on 21/03/2018.
//  Copyright © 2018 NetEase (Hangzhou) Network Co., Ltd. All rights reserved.
//

#import "NSDate+Formatter.h"

#import "NEMLanguageUtil.h"

@implementation NSDate (Formatter)

- (NSString *)localeDateString
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.locale = [NEMLanguageUtil locale];
    format.dateStyle = NSDateFormatterMediumStyle;
    format.timeStyle = NSDateFormatterShortStyle;
    
    return [format stringFromDate:self];
}

- (NSString *)yyyyMMddHHmmss
{
    NSDateFormatter *format =[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyyMMddHHmmss"];
    
    return [format stringFromDate:self];
}

@end
