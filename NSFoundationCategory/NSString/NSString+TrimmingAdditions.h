//
//  NSString+TrimmingAdditions.h
//  mail
//
//  Created by H-YXH on 7/8/14.
//  Copyright (c) 2014 NetEase (Hangzhou) Network Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TrimmingAdditions)

- (NSString *)stringByTrimmingSpecailCharacter;

- (NSString*)stringByTrimmingLeadingCharactersInSet:(NSCharacterSet *)set;

- (NSString*)stringByTrimmingTrailingCharactersInSet:(NSCharacterSet *)set;

- (BOOL)hasPrefixCharactersInSet:(NSCharacterSet*)set;

- (BOOL)hasSuffixCharactersInSet:(NSCharacterSet*)set;

- (NSString *)trimmingWhiteAndNewlineCharacters;

- (NSString *)stringByCroppedAtIndex:(NSUInteger)index;
/// 计算字符串的字节数(汉字占两个)  
- (NSUInteger)getByteNum;
/// 从字符串中截取指定字节数
- (NSString *)subStringByByteWithIndex:(NSInteger)index;
@end
