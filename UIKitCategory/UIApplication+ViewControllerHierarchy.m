 //
//  UIApplication+ViewControllerHierarchy.m
//  mail
//
//  Created by hzyuxiaohua on 08/03/2018.
//  Copyright © 2018 NetEase (Hangzhou) Network Co., Ltd. All rights reserved.
//

#import "UIApplication+ViewControllerHierarchy.h"

@implementation UIApplication (ViewControllerHierarchy)

+ (NSDictionary *)viewControllerHierarchy
{
    return [[UIApplication sharedApplication] viewControllerHierarchy];
}

- (NSDictionary *)viewControllerHierarchy
{
    NSMutableDictionary *hierarchy = [NSMutableDictionary dictionary];
    for (UIWindow *window in self.windows) {
        NSString *description = [self descriptionForWindow:window];
        if (description.length == 0) {
            continue;
        }
        
        [hierarchy setObject:[self hierarchyForWindow:window] forKey:description];
    }
    
    return @{ @"application" : hierarchy };
}

#pragma mark - hierarchy

- (NSDictionary *)hierarchyForWindow:(UIWindow *)window
{
    NSDictionary *hierarchy = [self hierarchyForViewController:window.rootViewController];
    return @{ @"root" : hierarchy };
}

- (NSDictionary *)hierarchyForViewController:(UIViewController *)vc
{
    if ([vc isKindOfClass:[UITabBarController class]]) {
        UITabBarController *bvc = (UITabBarController *)vc;
        return @{ [self descriptionForTabBarController:bvc]
                  : [self hierarchyForTabBarController:bvc] };
    }
    
    if ([vc isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nvc = (UINavigationController *)vc;
        return @{ [self descriptionForNavigationViewController:nvc]
                  : [self hierarchyForNavigationViewController:nvc] };
    }
    
    if (vc.presentedViewController) {
        return @{ [self descriptionForViewController:vc]
                  : [self hierarchyForViewController:vc.presentedViewController] };
    }
    
    return @{ [self descriptionForViewController:vc] : @"null" };
}

- (NSArray *)hierarchyForTabBarController:(UITabBarController *)bvc
{
    NSMutableArray *hierarchy = [NSMutableArray array];
    for (UIViewController *vc in bvc.viewControllers) {
        [hierarchy addObject:[self hierarchyForViewController:vc]];
    }
    
    return hierarchy;
}

- (NSArray *)hierarchyForNavigationViewController:(UINavigationController *)nvc
{
    return nvc.viewControllers;
}

#pragma mark - description

- (NSString *)descriptionForWindow:(UIWindow *)window
{
    return [NSString stringWithFormat:@"%@_%@_%@(%p)",
            NSStringFromClass(window.class), @(window.windowLevel), @(window.isKeyWindow), window];
}

- (NSString *)descriptionForViewController:(UIViewController *)vc
{
    if (!vc) {
        return @"no root view controller";
    }
    
    return [NSString stringWithFormat:@"[VC]-%@", NSStringFromClass(vc.class)];
}

- (NSString *)descriptionForTabBarController:(UITabBarController *)bvc
{
    return [NSString stringWithFormat:@"[TabBar]-%@(%@ sub vcs:)",
            NSStringFromClass(bvc.class), @(bvc.viewControllers.count)];
}

- (NSString *)descriptionForNavigationViewController:(UINavigationController *)nvc
{
    return [NSString stringWithFormat:@"[NVC]-%@(%@ sub vcs:)",
            NSStringFromClass(nvc.class), @(nvc.viewControllers.count)];
}

@end
