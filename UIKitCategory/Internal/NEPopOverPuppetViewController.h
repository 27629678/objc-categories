//
//  NEPopOverPuppetViewController.h
//  mail
//
//  Created by hzyuxiaohua on 09/04/2018.
//  Copyright © 2018 NetEase (Hangzhou) Network Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

extern CGRect currentRect(UIView *view, UIViewController *controller);

@protocol NEPopOverPuppetDelegate <NSObject>

@optional
- (void)popOverPuppetViewControllerDidDismiss;

@end

@interface NEPopOverDelegateProxy : NSObject <UIPopoverPresentationControllerDelegate>

@property (nonatomic, weak) UIView *source;

@property (nonatomic, weak) UIViewController *controller;

@end    // NEPopOverDelegateProxy

@interface NEPopOverPuppetViewController : UIViewController

@property (nonatomic, readonly) NEPopOverDelegateProxy *proxy;

+ (instancetype)viewControllerWithDelegate:(id<NEPopOverPuppetDelegate>)delegate;

@end    // NEPopOverPuppetViewController
