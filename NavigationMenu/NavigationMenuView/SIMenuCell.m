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
        self.contentView.backgroundColor = [UIColor color:[SIMenuConfiguration itemsColor] withAlpha:[SIMenuConfiguration menuAlpha]];
        self.textLabel.textColor = [SIMenuConfiguration itemTextColor];
        self.textLabel.font = [UIFont boldSystemFontOfSize:18.f];
        self.textLabel.textAlignment = NSTextAlignmentLeft;
        
        [self.contentView addSubview:self.lineView];
        
        self.selectionStyle = UITableViewCellEditingStyleNone;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect bounds = self.bounds;
    self.lineView.frame = CGRectMake(10.f, bounds.size.height - 0.5f, bounds.size.width - 20.f, 0.5f);
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    if (highlighted) {
        self.textLabel.textColor = [SIMenuConfiguration highlightItemTextColor];
        self.imageView.image = [UIImage themeImageNamed:self.highlightIcon];
    } else {
        self.textLabel.textColor = [SIMenuConfiguration itemTextColor];
        self.imageView.image = [UIImage themeImageNamed:self.normalIcon];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)setSelected:(BOOL)selected withCompletionBlock:(void (^)())completion
{
    self.textLabel.textColor = [SIMenuConfiguration highlightItemTextColor];
    completion();
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
