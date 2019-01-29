//
//  NSFileManager+Util.m
//  mail
//
//  Created by hzyuxiaohua on 2018/11/28.
//  Copyright © 2018 NetEase (Hangzhou) Network Co., Ltd. All rights reserved.
//

#import "NSFileManager+Util.h"

@implementation NSFileManager (Util)

- (BOOL)isFileExsitAtPath:(NSString *)path
{
    if (path.length == 0) {
        return NO;
    }
    
    BOOL isDirectory = NO;
    BOOL isExist = [self fileExistsAtPath:path isDirectory:&isDirectory];
    
    if (isDirectory) {
        return NO;
    }
    
    return isExist;
}

- (BOOL)isDirectoryExistAtPath:(NSString *)path
{
    if (path.length == 0) {
        return NO;
    }
    
    BOOL isDirectory = NO;
    BOOL isExist = [self fileExistsAtPath:path isDirectory:&isDirectory];
    
    return isDirectory && isExist;
}

- (BOOL)createDirectoryIfNeededWithFilePath:(NSString *)path
{
    return [self createDirectoryIfNeeded:path.stringByDeletingLastPathComponent];
}

- (BOOL)createDirectoryIfNeeded:(NSString *)path
{
    if (path.length == 0) {
        return NO;
    }
    
    BOOL isDirectory = NO;
    BOOL isExist = [self fileExistsAtPath:path isDirectory:&isDirectory];
    if (isExist && isDirectory) {
        return YES;
    }
    
    NSError *error = nil;
    BOOL success =
    [self createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
    if (!success || error) {
        NSLog(@"create directory failed with error: %@", error ? : @"no error");
        
        return NO;
    }
    
    return YES;
}

- (BOOL)writeData:(NSData *)data toFileAtPath:(NSString *)path
{
    if (data.length * path.length == 0) {
        return NO;
    }
    
    if (![self isWritableFileAtPath:path]) {
        assert(NO);
        return NO;
    }
    
    return [data writeToFile:path atomically:YES];
}

@end
