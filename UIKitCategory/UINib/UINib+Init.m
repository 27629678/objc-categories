//
//  UINib+Init.m
//  mail
//
//  Created by hzyuxiaohua on 2018/9/7.
//  Copyright © 2018 NetEase (Hangzhou) Network Co., Ltd. All rights reserved.
//

#import "UINib+Init.h"

@implementation UINib (Init)

+ (instancetype)nibWithName:(NSString *)name
{
    return [UINib nibWithNibName:name bundle:nil];
}

@end
