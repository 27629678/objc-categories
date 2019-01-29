//
//  NSURL+Scheme.h
//  mail
//
//  Created by hzyuxiaohua on 2018/9/14.
//  Copyright © 2018 NetEase (Hangzhou) Network Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (Scheme)

- (BOOL)isHttpScheme;

- (BOOL)isMailToScheme;

- (BOOL)isNativeScheme;

@end
