//
//  TLDatePickerCollectionViewCell.m
//  MaskLayer
//
//  Created by Terry Lin on 15/5/20.
//  Copyright (c) 2015年 XiaoZhan. All rights reserved.
//

#import "TLDatePickerCollectionViewCell.h"



@implementation TLDatePickerCollectionViewCell
{
    NSDateFormatter* _dayFormatter;
    NSDateFormatter* _weekDayFormatter;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        _dayFormatter = [[NSDateFormatter alloc] init];
        _dayFormatter.dateFormat = @"dd";
        _weekDayFormatter = [[NSDateFormatter alloc] init];
        _weekDayFormatter.dateFormat = @"EEE";
        
        UILabel* labDay = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)/2)];
        labDay.textAlignment = NSTextAlignmentCenter;
        labDay.textColor = [UIColor blackColor];
        self.labDay = labDay;
        [self.contentView addSubview:self.labDay];
        
        UILabel* labWeekDay = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)/2)];
        labWeekDay.textAlignment = NSTextAlignmentCenter;
        labWeekDay.textColor = [UIColor lightGrayColor];
        self.labWeekDay = labWeekDay;
        [self.contentView addSubview:self.labWeekDay];
    }
    
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.labDay sizeToFit];
    [self.labWeekDay sizeToFit];
    
    self.labWeekDay.center = CGPointMake(CGRectGetWidth(self.bounds)/2, CGRectGetHeight(self.bounds)/2-CGRectGetHeight(self.labDay.frame));
    self.labDay.center = CGPointMake(CGRectGetWidth(self.bounds)/2, CGRectGetHeight(self.bounds)/2+10);
}


-(void)setDate:(NSDate *)date
{
    if (![_date isEqualToDate:date]) {
        _date = date;
        self.labWeekDay.text = [_weekDayFormatter stringFromDate:date];
        
        if ([_date isSameDayAsDate:[NSDate date]]) {
            self.labDay.text = @"TODAY";
        }else{
            self.labDay.text = [_dayFormatter stringFromDate:date];
        }
        [self setNeedsLayout];
    }
}

@end




@implementation NSDate (SameDay)

- (BOOL)isSameDayAsDate:(NSDate*)otherDate {
    
    if ([[NSCalendar currentCalendar] respondsToSelector:@selector(isDate:inSameDayAsDate:)]) {
        return [[NSCalendar currentCalendar] isDate:self inSameDayAsDate:otherDate];
    }else{
        // From progrmr's answer...
        NSCalendar* calendar = [NSCalendar currentCalendar];
        
        unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
        NSDateComponents* comp1 = [calendar components:unitFlags fromDate:self];
        NSDateComponents* comp2 = [calendar components:unitFlags fromDate:otherDate];
        
        return [comp1 day]   == [comp2 day] &&
        [comp1 month] == [comp2 month] &&
        [comp1 year]  == [comp2 year];
    }
}

@end
