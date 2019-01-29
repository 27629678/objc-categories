//
//  UINavigationBar+ButtonItemIndex.m
//  NavigationBar
//
//  Created by hzyuxiaohua on 28/03/2018.
//  Copyright © 2018 hzyuxiaohua. All rights reserved.
//

#import "UINavigationBar+ButtonItemIndex.h"

@implementation UINavigationBar (ButtonItemIndex)

- (NSArray<UIView *> *)allButtonItemViews
{
    if (@available(iOS 11.0, *)) {
        return [self allButtonItemViewsForHightThanIOS11];
    }
    
    return [self allButtonItemViewsForLowerThanIOS11];
}

- (UIView *)buttonViewAtIndex:(NSUInteger)index
{
    return [[self allButtonItemViews] objectAtIndex:index];
}

#pragma mark - private

- (NSArray *)allButtonItemViewsForLowerThanIOS11
{
    NSMutableArray *buttons = [NSMutableArray array];
    for (UIView *view in self.subviews) {
        if (![NSStringFromClass(view.class) isEqualToString:@"UINavigationButton"]) {
            continue;
        }
        
        [buttons addObject:view];
    }
    
    [buttons sortUsingComparator:^NSComparisonResult(UIView *v1, UIView *v2) {
        return [@(v1.frame.origin.x) compare:@(v2.frame.origin.x)];
    }];
    
    return buttons.copy;
}

- (NSArray *)allButtonItemViewsForHightThanIOS11
{
    UIView *contentView = nil;
    for (UIView *view in self.subviews) {
        if (![NSStringFromClass(view.class) isEqualToString:@"_UINavigationBarContentView"]) {
            continue;
        }
        
        contentView = view;
        break;
    }
    
    NSMutableArray *buttons = [NSMutableArray array];
    for (UIView *view in contentView.subviews) {
        if (![NSStringFromClass(view.class) isEqualToString:@"_UIButtonBarStackView"]) {
            continue;
        }
        
        for (UIView *button in view.subviews) {
            if (![NSStringFromClass(button.class) isEqualToString:@"_UIButtonBarButton"]) {
                continue;
            }
            
            [buttons addObject:button];
        }
    }
    
    return buttons.copy;
}

@end
