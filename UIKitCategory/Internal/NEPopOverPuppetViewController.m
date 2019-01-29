//
//  NEPopOverPuppetViewController.m
//  mail
//
//  Created by hzyuxiaohua on 09/04/2018.
//  Copyright © 2018 NetEase (Hangzhou) Network Co., Ltd. All rights reserved.
//

#import "NEPopOverPuppetViewController.h"

CGRect currentRect(UIView *view, UIViewController *controller)
{
    CGRect rect = [controller.view convertRect:view.frame fromView:view.superview];
    rect.origin.x = MAX(0 ,MIN(rect.origin.x, controller.view.frame.size.width));
    rect.origin.y = MAX(0 ,MIN(rect.origin.y, controller.view.frame.size.height));
    
    return rect;
}

@interface NEPopOverDelegateProxy ()

@property (nonatomic, weak) NEPopOverPuppetViewController *puppet;

@end    // NEPopOverDelegateProxy

@interface NEPopOverPuppetViewController ()

@property (nonatomic, readwrite) NEPopOverDelegateProxy *proxy;
@property (nonatomic, weak) id<NEPopOverPuppetDelegate> delegate;

@end    // NEPopOverPuppetViewController

@implementation NEPopOverPuppetViewController

+ (instancetype)viewControllerWithDelegate:(id<NEPopOverPuppetDelegate>)delegate
{
    NEPopOverPuppetViewController *instance = [NEPopOverPuppetViewController new];
    
    return instance;
}

#pragma mark - getter & setter

- (NEPopOverDelegateProxy *)proxy
{
    if (!_proxy) {
        _proxy = [NEPopOverDelegateProxy new];
        _proxy.puppet = self;
    }
    
    return _proxy;
}

@end    // NEPopOverPuppetViewController

@implementation NEPopOverDelegateProxy

- (void)popoverPresentationControllerDidDismissPopover:
    (UIPopoverPresentationController *)popoverPresentationController
{
    if ([self.puppet.delegate respondsToSelector:@selector(popOverPuppetViewControllerDidDismiss)]) {
        [self.puppet.delegate popOverPuppetViewControllerDidDismiss];
        [self.puppet dismissViewControllerAnimated:YES completion:NULL];
    }
}

- (void)popoverPresentationController:
    (UIPopoverPresentationController *)popoverPresentationController
          willRepositionPopoverToRect:(inout CGRect *)rect
                               inView:(inout UIView **)view
{
    [self.puppet dismissViewControllerAnimated:YES completion:NULL];
    return;
    
    if (!self.controller || !self.source) {
        [self.puppet.delegate popOverPuppetViewControllerDidDismiss];
        [self.puppet dismissViewControllerAnimated:YES completion:NULL];
        
        return;
    }
    
    *view = self.controller.view;
    *rect = currentRect(self.source, self.controller);
}

@end    // NEPopOverDelegateInstance
