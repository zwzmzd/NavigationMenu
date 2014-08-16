//
//  SINavigationMenuView.m
//  NavigationMenu
//
//  Created by Ivan Sapozhnik on 2/19/13.
//  Copyright (c) 2013 Ivan Sapozhnik. All rights reserved.
//

#import "SINavigationMenuView.h"
#import "SIMenuButton.h"
#import "SIMenuTableWrapperView.h"
#import "QuartzCore/QuartzCore.h"
#import "SIMenuConfiguration.h"

@interface SINavigationMenuView  ()
@property (nonatomic, strong) SIMenuButton *menuButton;
@property (nonatomic, strong) SIMenuTableWrapperView *tableWrapperView;
@property (nonatomic, strong) UIView *menuContainer;
@end

@implementation SINavigationMenuView

- (id)initWithFrame:(CGRect)frame title:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        frame.origin.y += 1.0;
        self.menuButton = [[SIMenuButton alloc] initWithFrame:frame];
        self.menuButton.title.text = title;
        [self.menuButton addTarget:self action:@selector(onHandleMenuTap:) forControlEvents:UIControlEventTouchUpInside];
        self.enabled = YES;
        [self addSubview:self.menuButton];
    }
    return self;
}

- (void)displayMenuInView:(UIView *)view
{
    self.menuContainer = view;
    
    // 预先将所需要的UIView全部生成好，并使用强引用保存起来。
    // 注意在初始化时正确设置它们的frame，否则layoutSubviews要等到UIView显示时才会调用，
    // 这样会影响动画的startFrame和endFrame正确性
    if (_tableWrapperView == nil) {
        CGRect frame = self.menuContainer.bounds;
        
        if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
            // iOS7上不要覆盖状态栏，否则模拟器可能会出现显示问题
            frame.origin.y += 20.f;
            frame.size.height -= 20.f;
        }
        
        _tableWrapperView = [[SIMenuTableWrapperView alloc] initWithFrame:frame withItems:self.items];
        _tableWrapperView.delegate = self;
        _tableWrapperView.initialSelectedIndex = self.initialSelectedIndex;
    }
}

- (void)setTitle:(NSString *)title {
    self.menuButton.title.text = title;
    [self.menuButton layoutSubviews];
}

#pragma mark -
#pragma mark Actions
- (void)onHandleMenuTap:(id)sender
{
    if (!self.enabled) {
        return;
    }
    
    if (self.menuButton.isActive) {
        [self onShowMenu];
    } else {
        [self onHideMenu:nil];
    }
}

- (void)onShowMenu
{
    [self.menuContainer addSubview:self.tableWrapperView];
    [self.tableWrapperView show];
    [self rotateArrow:M_PI];
}

- (void)onHideMenu:(void (^)())completion
{
    [self rotateArrow:0];
    [self.tableWrapperView hide:completion];
}

- (void)rotateArrow:(float)degrees
{
    [UIView animateWithDuration:[SIMenuConfiguration animationDuration] delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.menuButton.arrow.layer.transform = CATransform3DMakeRotation(degrees, 0, 0, 1);
    } completion:NULL];
}

#pragma mark -
#pragma mark Delegate methods

- (void)didSelectItemAtIndex:(NSUInteger)index
{
    self.menuButton.isActive = !self.menuButton.isActive;
    [self rotateArrow:0];
    [self onHideMenu:^{
        [self.delegate didSelectItemAtIndex:index];
    }];
}

- (void)didBackgroundTap
{
    self.menuButton.isActive = !self.menuButton.isActive;
    [self onHandleMenuTap:nil];
}

#pragma mark - setter && getter

#pragma mark -
#pragma mark Memory management
- (void)dealloc
{
    if (self.tableWrapperView) {
        [self.tableWrapperView removeFromSuperview];
    }
    
    self.items = nil;
    self.menuButton = nil;
    self.menuContainer = nil;
}

@end
