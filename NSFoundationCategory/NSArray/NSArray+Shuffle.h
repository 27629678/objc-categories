//
//  NSArray+Shuffle.h
//  mail
//
//  Created by hzyuxiaohua on 2018/11/27.
//  Copyright © 2018 NetEase (Hangzhou) Network Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (Shuffle)

- (id)anyObject;

- (NSArray *)shuffleArray;

@end

NS_ASSUME_NONNULL_END
