//
//  ViewController.m
//  MaskLayer
//
//  Created by Terry Lin on 15/5/19.
//  Copyright (c) 2015年 XiaoZhan. All rights reserved.
//

#import "ViewController.h"
#import "MaskView.h"
#import "TLDatePicker.h"

@interface ViewController ()<TLDatePickerDelegate>

@end

@implementation ViewController
{
    TLDatePicker* _picker1;
    TLDatePicker* _picker2;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    TLDatePicker* picker = [[TLDatePicker alloc] initWithFrame:CGRectMake(0, 200, self.view.bounds.size.width, 100)];
    picker.datesCollectionView.backgroundColor = [UIColor whiteColor];
    picker.delegate = self;
    picker.tag = 101;
    _picker1 = picker;

    
    TLDatePicker* picker2 = [[TLDatePicker alloc] initWithFrame:CGRectMake(0, 200, self.view.bounds.size.width, 100)];
    picker2.datesCollectionView.backgroundColor = [UIColor blackColor];
    picker2.delegate = self;
    picker2.tag = 102;
    _picker2 = picker2;
    
    
    MaskView* maskView = [[MaskView alloc] initWithFrame:CGRectMake(0, 200, self.view.bounds.size.width, 100)];
    [self.view addSubview:maskView];
    maskView.backView = picker.datesCollectionView;
    maskView.frontView = picker2.datesCollectionView;
    [maskView applyMask:[self maskLayer]];
    
    [picker2 selectDate:[[NSDate date] dateByAddingTimeInterval:60*60*24*5]];
}

-(void)datePicker:(TLDatePicker *)picker AddConfigToCell:(TLDatePickerCollectionViewCell *)cell
{
    if (picker.tag == 102) {
        cell.labDay.textColor = [UIColor whiteColor];
    }
}



-(CALayer*)maskLayer
{
    CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width, 100);
    UIGraphicsBeginImageContextWithOptions((size), NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillEllipseInRect(context, CGRectMake((size.width-size.height)/2, 0, size.height, size.height));
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CALayer* layer = [CALayer layer];
    layer.contents = (__bridge id)image.CGImage;
    layer.frame= CGRectMake(0, 0,size.width, size.height);
    return layer;
}


@end
