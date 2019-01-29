//
//  NSFileManager+Util.h
//  mail
//
//  Created by hzyuxiaohua on 2018/11/28.
//  Copyright © 2018 NetEase (Hangzhou) Network Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSFileManager (Util)

- (BOOL)isFileExsitAtPath:(NSString *)path;

- (BOOL)isDirectoryExistAtPath:(NSString *)path;

- (BOOL)createDirectoryIfNeeded:(NSString *)path;

- (BOOL)createDirectoryIfNeededWithFilePath:(NSString *)path;

- (BOOL)writeData:(NSData *)data toFileAtPath:(NSString *)path;

@end

NS_ASSUME_NONNULL_END
