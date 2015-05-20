//
//  TLDatePicker.h
//  MaskLayer
//
//  Created by Terry Lin on 15/5/20.
//  Copyright (c) 2015年 XiaoZhan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLDatePickerCollectionViewCell.h"

@class TLDatePicker;

@protocol TLDatePickerDelegate <NSObject>
@optional
-(void)datePicker:(TLDatePicker*)picker AddConfigToCell:(TLDatePickerCollectionViewCell*)cell;
@end


@interface TLDatePicker : UIView
@property (nonatomic,weak) NSObject<TLDatePickerDelegate>* delegate;
@property (strong, nonatomic) UICollectionView *datesCollectionView;
- (void)selectDate:(NSDate *)selectedDate;
@end
