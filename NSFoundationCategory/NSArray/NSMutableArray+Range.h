//
//  NSMutableArray+Range.h
//  mail
//
//  Created by hzyuxiaohua on 2018/5/22.
//  Copyright © 2018 NetEase (Hangzhou) Network Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (Range)

- (NSArray *)objectsOfRange:(NSRange)range;

- (NSArray *)objectsOfRange:(NSRange)range remove:(BOOL)remove;

@end
