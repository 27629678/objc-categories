//
//  UIViewController+PopOver.m
//  mail
//
//  Created by hzyuxiaohua on 09/04/2018.
//  Copyright © 2018 NetEase (Hangzhou) Network Co., Ltd. All rights reserved.
//

#import "UIViewController+PopOver.h"

#import "NEPopOverPuppetViewController.h"

#import <objc/runtime.h>

void *kPuppetViewController = &kPuppetViewController;

@interface UIViewController () <NEPopOverPuppetDelegate, UIPopoverPresentationControllerDelegate>

@property (nonatomic, strong) NEPopOverPuppetViewController *puppetViewController;

@end

@implementation UIViewController (PopOver)

- (void)showView:(UIView *)view inSourceView:(UIView *)source
{
    if (CGRectIsEmpty(source.frame)) {
        NSCAssert(NO, @"");
        
        return;
    }
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [self iPhoneShowView:view];
        
        return;
    }
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        [self iPadShowView:view atSourceView:source];
        
        return;
    }
    
    NSCAssert(NO, @"MUST NOT running to here.");
    return;
}

#pragma mark - private

#pragma mark - iphone
- (void)iPhoneShowView:(UIView *)view
{
    
}

#pragma mark - ipad
- (void)iPadShowView:(UIView *)view atSourceView:(UIView *)source
{
    NEPopOverPuppetViewController *target = [self puppetViewController];
    target.view = view;
    target.proxy.source = source;
    target.proxy.controller = self;
    target.preferredContentSize = view.frame.size;
    target.modalPresentationStyle = UIModalPresentationPopover;
    
    UIPopoverPresentationController *popover = target.popoverPresentationController;
    popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
    popover.sourceRect = currentRect(source, self);
    popover.sourceView = self.view;
    popover.delegate = target.proxy;
    
    [self presentViewController:target animated:YES completion:NULL];
}

#pragma mark - miscs

#pragma mark - puppet delegate

- (void)popOverPuppetViewControllerDidDismiss
{
    
}

#pragma mark - getter & setter

- (UIViewController *)puppetViewController
{
    UIViewController *puppet = objc_getAssociatedObject(self, kPuppetViewController);

    if (!puppet) {
        puppet = [NEPopOverPuppetViewController viewControllerWithDelegate:self];
        objc_setAssociatedObject(self, kPuppetViewController, puppet, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }

    return puppet;
}

- (void)setPuppetViewController:(UIViewController *)puppet
{
    objc_setAssociatedObject(self, kPuppetViewController, puppet, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end    // UIViewController (PopOver)
