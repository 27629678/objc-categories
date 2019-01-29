//
//  UINavigationBar+ButtonItemIndex.h
//  NavigationBar
//
//  Created by hzyuxiaohua on 28/03/2018.
//  Copyright © 2018 hzyuxiaohua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (ButtonItemIndex)

- (NSArray<UIView *> *)allButtonItemViews;

- (UIView *)buttonViewAtIndex:(NSUInteger)index;

@end
