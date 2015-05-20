//
//  TLDatePickerCollectionViewCell.h
//  MaskLayer
//
//  Created by Terry Lin on 15/5/20.
//  Copyright (c) 2015年 XiaoZhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLDatePickerCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) UILabel* labDay;
@property (nonatomic,strong) UILabel* labWeekDay;

@property (nonatomic,strong) NSDate* date;
@end



@interface NSDate (SameDay)
- (BOOL)isSameDayAsDate:(NSDate*)otherDate;
@end