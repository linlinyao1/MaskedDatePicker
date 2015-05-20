//
//  MaskView.h
//  MaskLayer
//
//  Created by Terry Lin on 15/5/20.
//  Copyright (c) 2015年 XiaoZhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MaskView : UIView


@property (nonatomic,strong) UIScrollView* frontView;
@property (nonatomic,strong) UIScrollView* backView;

-(void)applyMask:(CALayer*)maskLayer;
@end
