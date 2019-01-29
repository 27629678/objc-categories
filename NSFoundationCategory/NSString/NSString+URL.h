//
//  NSString+URL.h
//  mail
//
//  Created by hzyuxiaohua on 2018/7/25.
//  Copyright © 2018 NetEase (Hangzhou) Network Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (URL)

- (NSURL *)url;

- (NSString *)urlQueryEncodedString;

@end
