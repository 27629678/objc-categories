//
//  NSDate+String.h
//  mail
//
//  Created by hzyuxiaohua on 2018/6/13.
//  Copyright © 2018 NetEase (Hangzhou) Network Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (String)

/**
 毫秒级时间戳字符串

 @return 时间戳字符串
 */
- (NSString *)timeIntervalToString;

/**
 当前时间的毫秒级时间戳字符串
 
 @return 时间戳字符串
 */
+ (NSString *)currentTimeIntervalToString;

@end
