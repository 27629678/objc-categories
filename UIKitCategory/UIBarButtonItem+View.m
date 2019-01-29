//
//  UIBarButtonItem+View.m
//  mail
//
//  Created by hzyuxiaohua on 29/03/2018.
//  Copyright © 2018 NetEase (Hangzhou) Network Co., Ltd. All rights reserved.
//

#import "UIBarButtonItem+View.h"

@implementation UIBarButtonItem (View)

- (UIView *)barButton
{
    return [self valueForKey:@"_view"];
}

@end
