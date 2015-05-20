//
//  TLDatePicker.m
//  MaskLayer
//
//  Created by Terry Lin on 15/5/20.
//  Copyright (c) 2015年 XiaoZhan. All rights reserved.
//

#import "TLDatePicker.h"

@interface TLDatePicker ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (strong, nonatomic) NSDate *selectedDate;
@property (strong, nonatomic) NSIndexPath *selectedIndexPath;

@property (nonatomic,strong) NSMutableArray* dates;
@end

@implementation TLDatePicker

- (void)awakeFromNib
{
    [self commonInit];
}
- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        [self commonInit];
    }
    
    return self;
}

-(void)commonInit
{
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(CGRectGetHeight(self.bounds), CGRectGetHeight(self.bounds));
    layout.minimumLineSpacing = 0;
    UICollectionView* collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor clearColor];
    layout.sectionInset = UIEdgeInsetsMake(0, CGRectGetWidth(collectionView.bounds)/2-CGRectGetHeight(collectionView.bounds)/2, 0, CGRectGetWidth(collectionView.bounds)/2-CGRectGetHeight(collectionView.bounds)/2);
    [collectionView registerClass:[TLDatePickerCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    self.datesCollectionView = collectionView;
    [self addSubview:self.datesCollectionView];
    
    [self fillDatesFromDate:[NSDate date] numberOfDays:30];
}


#pragma mark -
#pragma mark Methods

- (void)fillDatesFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate
{
    NSAssert([fromDate compare:toDate] == NSOrderedAscending, @"toDate must be after fromDate");
    
    NSMutableArray *dates = [[NSMutableArray alloc] init];
    NSDateComponents *days = [[NSDateComponents alloc] init];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSInteger dayCount = 0;
    while(YES){
        [days setDay:dayCount++];
        NSDate *date = [calendar dateByAddingComponents:days toDate:fromDate options:0];
        
        if([date compare:toDate] == NSOrderedDescending) break;
        [dates addObject:date];
    }
    
    self.dates = dates;
}

- (void)fillDatesFromDate:(NSDate *)fromDate numberOfDays:(NSInteger)numberOfDays
{
    NSDateComponents *days = [[NSDateComponents alloc] init];
    [days setDay:numberOfDays];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [self fillDatesFromDate:fromDate toDate:[calendar dateByAddingComponents:days toDate:fromDate options:0]];
}


- (void)selectDate:(NSDate *)selectedDate
{
    NSInteger index = NSNotFound;
    for (NSDate* date in self.dates) {
        if ([date isSameDayAsDate:selectedDate]) {
            index = [self.dates indexOfObject:date];
            break;
        }
    }
    if (index!=NSNotFound) {
        _selectedDate = selectedDate;
        NSIndexPath *selectedCellIndexPath = [NSIndexPath indexPathForItem:index inSection:0];
        [self.datesCollectionView selectItemAtIndexPath:selectedCellIndexPath animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    }
}



#pragma mark -
#pragma mark Delegates

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dates.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TLDatePickerCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.date = [self.dates objectAtIndex:indexPath.item];
    
    if ([self.delegate respondsToSelector:@selector(datePicker:AddConfigToCell:)]) {
        [self.delegate datePicker:self AddConfigToCell:cell];
    }
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.datesCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    _selectedDate = [self.dates objectAtIndex:indexPath.item];
    
    [collectionView deselectItemAtIndexPath:self.selectedIndexPath animated:YES];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
        [self scrollViewDidEndDecelerating:scrollView];
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint point = [self.datesCollectionView convertPoint:CGPointMake(CGRectGetMidX(self.datesCollectionView.bounds), CGRectGetMidY(self.datesCollectionView.bounds)) toView:scrollView];
    NSIndexPath* indexPath = [self.datesCollectionView indexPathForItemAtPoint:point];
    [self.datesCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    _selectedDate = [self.dates objectAtIndex:indexPath.item];
    self.selectedIndexPath = indexPath;
}


@end
