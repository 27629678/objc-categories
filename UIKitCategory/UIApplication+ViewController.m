//
//  UIApplication+ViewController.m
//  mail
//
//  Created by hzyuxiaohua on 2018/8/6.
//  Copyright © 2018 NetEase (Hangzhou) Network Co., Ltd. All rights reserved.
//

#import "UIApplication+ViewController.h"

@implementation UIApplication (ViewController)

+ (UIViewController *)presentedViewController
{
    UIViewController *target = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    if (target.presentedViewController) {
        return target.presentedViewController;
    }
    
    return target;
}

@end
