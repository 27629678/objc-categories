//
//  UIView+FrameAdditions.h
//  mail
//
//  Created by oldman on 14-5-6.
//  Copyright (c) 2014年 NetEase (Hangzhou) Network Co., Ltd. All rights reserved.
//
//  modified from https://gist.github.com/nfarina/3412730

#import <UIKit/UIKit.h>

@interface UIView (FrameAdditions)
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat x, y, width, height; // normal rect properties
@property (nonatomic, assign) CGFloat left, top, right, bottom; // these will stretch the rect
@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;
@property (nonatomic,readonly) CGFloat maxX;
@property (nonatomic,readonly) CGFloat maxY;

/**
 * Removes all subviews.
 */
- (void)removeAllSubviews;
- (void)removeAllSubviewsWithClass:(Class)cls;

- (UIView *)getSuperviewWithClass:(Class)cls;

+ (id)getViewFromXib:(NSString *)name owner:(id)owner;
+ (id)getViewFromXib:(NSString *)name owner:(id)owner tag:(NSInteger)tag;
- (UIImage *)getCaptureImage;
- (UIColor *) colorOfPoint:(CGPoint)point;

@end
