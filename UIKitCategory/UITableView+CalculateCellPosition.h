//
//  UITableView+CalculateCellPosition.h
//  mail
//
//  Created by ZFD on 15/5/15.
//  Copyright (c) 2015年 NetEase (Hangzhou) Network Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (CalculateCellPosition)

///获取在index处的Cell在tableview中的位置,目前假设只有Cell没有sectionView
-(CGRect)frameOfCellAtIndex:(NSIndexPath *)index;

@end
