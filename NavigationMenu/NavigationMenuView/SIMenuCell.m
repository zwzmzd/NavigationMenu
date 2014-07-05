//
//  SAMenuCell.m
//  NavigationMenu
//
//  Created by Ivan Sapozhnik on 2/19/13.
//  Copyright (c) 2013 Ivan Sapozhnik. All rights reserved.
//

#import "SIMenuCell.h"
#import "SIMenuConfiguration.h"
#import "UIColor+Extension.h"
#import "SICellSelection.h"
#import "UIImage+QDMailAdditions.h"
#import <QuartzCore/QuartzCore.h>

@interface SIMenuCell ()
@property (nonatomic, strong) SICellSelection *cellSelection;
@property (nonatomic, strong) UIView *lineView;
@end

@implementation SIMenuCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [SIMenuConfiguration ordinaryMenuCellBackgroundColor];
        self.textLabel.font = [UIFont boldSystemFontOfSize:18.f];
        self.textLabel.textAlignment = NSTextAlignmentLeft;
        
        [self.contentView addSubview:self.lineView];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect bounds = self.bounds;
    self.lineView.frame = CGRectMake(10.f, bounds.size.height - 0.5f, bounds.size.width - 20.f, 0.5f);
    
    // 用于调整cell内容的左边距
    CGFloat offsetX = 0.f;
    
    CGRect imageViewFrame = self.imageView.frame;
    imageViewFrame.origin.x += offsetX;
    self.imageView.frame = imageViewFrame;
    
    CGRect textLabelFrame = self.textLabel.frame;
    textLabelFrame.origin.x += offsetX;
    self.textLabel.frame = textLabelFrame;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    // 在菜单的每项被点击之后，这个函数会被highlightRowAtIndexPath和unhighlightRowAtIndexPath各调用一次
    // 导致界面不能正确地高亮
    // 所以使用bypassUnhighligtCallback变量来忽略第二次调用，这个变量在cellForIndexPath中会被设置为NO
    if (highlighted || self.bypassUnhighligtCallback) {
        self.textLabel.textColor = [SIMenuConfiguration highlightItemTextColor];
        self.imageView.image = [UIImage themeImageNamed:self.highlightIcon];
        self.contentView.backgroundColor = [SIMenuConfiguration highlightBackgroundColor];
        
        self.bypassUnhighligtCallback = YES;
    } else if (self.isSelected) {
        self.textLabel.textColor = [SIMenuConfiguration selectedItemTextColor];
        self.imageView.image = [UIImage themeImageNamed:self.selectedIcon];
        self.contentView.backgroundColor = [SIMenuConfiguration ordinaryMenuCellBackgroundColor];
    } else {
        self.textLabel.textColor = [SIMenuConfiguration itemTextColor];
        self.imageView.image = [UIImage themeImageNamed:self.normalIcon];
        self.contentView.backgroundColor = [SIMenuConfiguration ordinaryMenuCellBackgroundColor];
    }
}

- (UIView *)lineView
{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] initWithFrame:CGRectZero];
        _lineView.backgroundColor = [SIMenuConfiguration separatorColor];
    }
    return _lineView;
}

- (void)dealloc
{
    self.cellSelection = nil;
}

@end
