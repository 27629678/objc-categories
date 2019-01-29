//
//  UITableView+CalculateCellPosition.m
//  mail
//
//  Created by ZFD on 15/5/15.
//  Copyright (c) 2015年 NetEase (Hangzhou) Network Co., Ltd. All rights reserved.
//

#import "UITableView+CalculateCellPosition.h"

@implementation UITableView (CalculateCellPosition)

-(CGRect)frameOfCellAtIndex:(NSIndexPath *)index{
    CGFloat yLocationOfCell = 0.0;
    CGFloat oneHeight = 0.0;
    if ([self.delegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]) {
            for (int i = 0; i<= index.section; i++) {
                long endRow = [self numberOfRowsInSection:i]-1;
                if (endRow == -1) {
                    continue;
                }
                if (index.section == i) {
                    ///最后一个section，不需要全部遍历
                    endRow = index.row;
                }
                for (int n = 0; n<= endRow; n++) {
                    yLocationOfCell += oneHeight;
                    oneHeight= [self.delegate tableView:self heightForRowAtIndexPath:[NSIndexPath indexPathForRow:n inSection:i]];
//                    NSLog(@"sction = %d one height = %f,row = %d",i,oneHeight,n);
                }
            }
//        NSLog(@"yelocation of cell = %f",yLocationOfCell);
        return CGRectMake(0.0, yLocationOfCell, self.frame.size.width, oneHeight);
    }else{
        NSAssert(NO, @"tableView delegate does not exist");
        return CGRectZero;
    }
}

@end
