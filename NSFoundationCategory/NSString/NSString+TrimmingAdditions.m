//
//  NSString+TrimmingAdditions.m
//  mail
//
//  Created by H-YXH on 7/8/14.
//  Copyright (c) 2014 NetEase (Hangzhou) Network Co., Ltd. All rights reserved.
//

#import "NSString+TrimmingAdditions.h"

#import <Foundation/Foundation.h>

// 参考链接：https://qiita.com/a_yasui/items/fc6e1c564b5b21482882
// https://utf8-chartable.de/unicode-utf8-table.pl?start=8192&number=128&utf8=string-literal
static NSString* kTextEmpty = @"\u200B";            // Zero-Width Space
static NSString* kSpecialText = @"\xe2\x80\x86";    // SIX-PER-EM SPACE

@implementation NSString (TrimmingAdditions)

- (NSString *)stringByTrimmingSpecailCharacter
{
    NSString* ret_str = nil;
    ret_str = [self stringByReplacingOccurrencesOfString:kTextEmpty withString:@""];
    ret_str = [ret_str stringByReplacingOccurrencesOfString:kSpecialText withString:@""];
    
    return ret_str;
}

// http://stackoverflow.com/questions/5689288/how-to-remove-whitespace-from-right-end-of-nsstring

- (NSString*)stringByTrimmingLeadingCharactersInSet:(NSCharacterSet *)set
{
    NSUInteger location = 0;
    NSUInteger length = [self length];
    unichar charBuffer[length];
    [self getCharacters:charBuffer range:NSMakeRange(0, length)];
    
    for (location = 0; location != length; location ++) {
        if (![set characterIsMember:charBuffer[location]]) {
            break;
        }
    }
    return [self substringWithRange:NSMakeRange(location, length-location)];
}

- (NSString*)stringByTrimmingTrailingCharactersInSet:(NSCharacterSet *)set
{
    NSUInteger location = 0;
    NSUInteger length = [self length];
    unichar charBuffer[length];
    [self getCharacters:charBuffer range:NSMakeRange(location, length-location)];
    for (length = [self length]; length > 0; length --) {
        if (![set characterIsMember:charBuffer[length-1]]) {
            break;
        }
    }
    return [self substringWithRange:NSMakeRange(location, length-location)];
}

- (NSString *)trimmingWhiteAndNewlineCharacters
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)stringByCroppedAtIndex:(NSUInteger)index
{
    if (self.length <= index) {
        return self.copy;
    }
    
    NSRange range = [self rangeOfComposedCharacterSequenceAtIndex:index];
    NSInteger idx = range.location < index ? range.location : index;
    
    return [self substringToIndex:idx];
}

- (BOOL)hasPrefixCharactersInSet:(NSCharacterSet*)set
{
    if (self.length == 0) {
        return NO;
    }
    
    NSUInteger location = 0;
    NSUInteger length = [self length];
    unichar charBuffer[length];
    [self getCharacters:charBuffer range:NSMakeRange(0, length)];
    
    for (location = 0; location != length; location ++) {
        if (![set characterIsMember:charBuffer[location]]) {
            break;
        }
    }
    return location > 0 ? YES : NO;
}

- (BOOL)hasSuffixCharactersInSet:(NSCharacterSet*)set
{
    NSUInteger location = 0;
    NSUInteger length = [self length];
    unichar charBuffer[length];
    [self getCharacters:charBuffer range:NSMakeRange(location, length-location)];
    for (length = [self length]; length > 0; length --) {
        if (![set characterIsMember:charBuffer[length-1]]) {
            break;
        }
    }
    return length < [self length] ? YES : NO;
}

- (NSUInteger)getByteNum {
    NSUInteger strlength = 0;
    char* p = (char*)[self cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return strlength;
}

- (NSString *)subStringByByteWithIndex:(NSInteger)index {
    NSInteger sum = 0;
    NSString *subStr = [[NSString alloc] init];
    for(int i = 0; i<[self length]; i++){
        unichar strChar = [self characterAtIndex:i];
        if(strChar < 256){
            sum += 1;
        }
        else {
            sum += 2;
        }
        if (sum >= index) {
            subStr = [self substringToIndex:i+1];
            return subStr;
        }
    }
    return subStr;
}
@end
