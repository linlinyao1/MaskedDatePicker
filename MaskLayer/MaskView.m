//
//  MaskView.m
//  MaskLayer
//
//  Created by Terry Lin on 15/5/20.
//  Copyright (c) 2015年 XiaoZhan. All rights reserved.
//

#import "MaskView.h"

@interface MaskView ()
@property (nonatomic,strong) UIView* backViewContainer;
@property (nonatomic,strong) UIView* frontViewContainer;
@end

@implementation MaskView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backViewContainer = [[UIView alloc] initWithFrame:self.bounds];
        self.frontViewContainer = [[UIView alloc] initWithFrame:self.bounds];
        [self addSubview:self.backViewContainer];
        [self addSubview:self.frontViewContainer];
    }
    return self;
}

-(void)setBackView:(UIScrollView *)backView
{
    if (_backView!=backView) {
        _backView = backView;
        _backView.frame = self.bounds;
        [[self.backViewContainer subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self.backViewContainer addSubview:_backView];
    }
}

-(void)setFrontView:(UIScrollView *)frontView
{
    if (_frontView!=frontView) {
        [_frontView removeObserver:self forKeyPath:@"contentOffset"];
        _frontView = frontView;
        _frontView.frame = self.bounds;
        [[self.frontViewContainer subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self.frontViewContainer addSubview:_frontView];
        [_frontView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    }
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (object == self.frontView) {
        NSValue* value = change[NSKeyValueChangeNewKey];
        CGPoint point = [value CGPointValue];
        self.backView.contentOffset = point;
    }
}

-(void)applyMask:(CALayer *)maskLayer
{
    self.frontViewContainer.layer.mask = maskLayer;
}




@end
