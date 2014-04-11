//
//  SIMenuTableWrapperView.m
//  QDMail
//
//  Created by Wenzhe Zhou on 14-3-29.
//  Copyright (c) 2014年 QiDuo Tech Inc. All rights reserved.
//

#import "SIMenuTableWrapperView.h"
#import "SIMenuTable.h"

@interface SIMenuTableWrapperView()

@property (nonatomic, copy) NSArray *items;
@property (nonatomic, strong) SIMenuTable *table;
@property (nonatomic, strong) UIView *colorView;
@property (nonatomic, strong) UIView *backgroundTapView;

@end

@implementation SIMenuTableWrapperView

- (id)initWithFrame:(CGRect)frame withItems:(NSArray *)items
{
    self = [super initWithFrame:frame];
    if (self) {
        self.items = items;
        
        
        [self addSubview:self.colorView];
        [self addSubview:self.table];
        [self addSubview:self.backgroundTapView];
        
        [self bringSubviewToFront:self.backgroundTapView];
        [self bringSubviewToFront:self.table];
    }
    return self;
}

- (void)layoutSubviews {
    CGRect bounds = self.bounds;
    self.backgroundTapView.frame = bounds;
    
    CGFloat topBarHeight;
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
        topBarHeight = 64.f;
    } else {
        topBarHeight = 44.f;
    }
    bounds.origin.y += topBarHeight;
    bounds.size.height -= topBarHeight;
    
    self.colorView.frame = bounds;
    self.table.frame = bounds;
}

- (void)_handleTap {
    if (self.delegate) {
        [self.delegate didBackgroundTap];
    }
}

#pragma mark - setter && getter

- (SIMenuTable *)table {
    if (_table == nil) {
        _table = [[SIMenuTable alloc] initWithFrame:CGRectZero items:self.items];
    }
    return _table;
}

- (void)setDelegate:(id<SIMenuDelegate>)delegate {
    _delegate = delegate;
    self.table.menuDelegate = delegate;
}

- (void)setInitialSelectedIndex:(NSInteger)initialSelectedIndex {
    _initialSelectedIndex = initialSelectedIndex;
    self.table.selectedIndex = initialSelectedIndex;
}

- (UIView *)colorView {
    if (_colorView == nil) {
        _colorView = [[UIView alloc] initWithFrame:CGRectZero];
        _colorView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.6];
    }
    return _colorView;
}

- (UIView *)backgroundTapView {
    if (_backgroundTapView == nil) {
        _backgroundTapView = [[UIView alloc] initWithFrame:CGRectZero];

        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]
                                                        initWithTarget:self
                                                        action:@selector(_handleTap)];
        [_backgroundTapView addGestureRecognizer:tapGestureRecognizer];
    }
    return _backgroundTapView;
}

@end
