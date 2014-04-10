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
#import <QuartzCore/QuartzCore.h>

@interface SIMenuCell ()
@property (nonatomic, strong) SICellSelection *cellSelection;
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
        
        self.selectionStyle = UITableViewCellEditingStyleNone;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)setSelected:(BOOL)selected withCompletionBlock:(void (^)())completion
{
    float alpha = 0.0;
    if (selected) {
        alpha = 1.0;
    } else {
        alpha = 0.0;
    }
    [UIView animateWithDuration:[SIMenuConfiguration selectionSpeed] animations:^{
        self.cellSelection.alpha = alpha;
    } completion:^(BOOL finished) {
        completion();
    }];
}

- (void)dealloc
{
    self.cellSelection = nil;
}

@end
