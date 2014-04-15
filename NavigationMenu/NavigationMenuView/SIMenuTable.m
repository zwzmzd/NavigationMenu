//
//  SAMenuTable.m
//  NavigationMenu
//
//  Created by Ivan Sapozhnik on 2/19/13.
//  Copyright (c) 2013 Ivan Sapozhnik. All rights reserved.
//

#import "SIMenuTable.h"
#import "SIMenuCell.h"
#import "SIMenuConfiguration.h"
#import <QuartzCore/QuartzCore.h>
#import "UIColor+Extension.h"
#import "SICellSelection.h"

@interface SIMenuTable ()

@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) NSArray *items;

@end

@implementation SIMenuTable

- (id)initWithFrame:(CGRect)frame items:(NSArray *)items
{
    self = [super initWithFrame:frame];
    if (self) {
        self.items = [NSArray arrayWithArray:items];
        
        self.layer.backgroundColor = [UIColor color:[SIMenuConfiguration mainColor] withAlpha:0.0].CGColor;
        self.clipsToBounds = YES;
        
        self.table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        self.table.delegate = self;
        self.table.dataSource = self;
        self.table.backgroundColor = [UIColor clearColor];
        self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.table.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.table.bounces = NO;
        
        [self addFooter];
        
        self.selectedIndex = 0;
    }
    return self;
}

- (void)addFooter
{
    UIView *footer = [[UIView alloc] initWithFrame:CGRectZero];
    self.table.tableFooterView = footer;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onBackgroundTap:)];
    [footer addGestureRecognizer:tap];
}

- (void)show:(void (^)())animation
{
    [self.table reloadData];
    [self addSubview:self.table];
    
    CGRect startFrame = self.bounds;
    CGRect endFrame = self.bounds;
    startFrame.origin.y -= self.items.count * [SIMenuConfiguration itemCellHeight];
    
    self.table.frame = startFrame;
    [UIView animateWithDuration:[SIMenuConfiguration animationDuration] animations:^{
        self.table.frame = endFrame;
        if (animation) {
            animation();
        }
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            self.table.contentOffset = CGPointMake(0, 0);
        }];
    }];
}

- (void)hide:(void (^)())completion animation:(void (^)())animation {
    CGRect endFrame = self.bounds;
    endFrame.origin.y -= self.items.count * [SIMenuConfiguration itemCellHeight];

    [UIView animateWithDuration:[SIMenuConfiguration animationDuration] animations:^{
        self.table.frame = endFrame;
        if (animation) {
            animation();
        }
    } completion:^(BOOL finished) {
        if (completion) {
            [self.table removeFromSuperview];
            completion();
        }
    }];
}

- (void)onBackgroundTap:(id)sender
{
    [self.menuDelegate didBackgroundTap];
}

- (void)layoutSubviews {
    CGRect bounds = self.bounds;
    
    self.table.tableFooterView.frame = CGRectMake(0.f,
                                                  (self.items.count * [SIMenuConfiguration itemCellHeight]),
                                                  bounds.size.width,
                                                  bounds.size.height - (self.items.count * [SIMenuConfiguration itemCellHeight]));
}

- (void)dealloc
{
    self.items = nil;
    self.table = nil;
    self.menuDelegate = nil;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [SIMenuConfiguration itemCellHeight];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    SIMenuCell *cell = (SIMenuCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[SIMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [[self.items objectAtIndex:indexPath.row] objectForKey:@"name"];
    cell.normalIcon = [[self.items objectAtIndex:indexPath.row] objectForKey:@"iconName"];
    cell.highlightIcon = [[self.items objectAtIndex:indexPath.row] objectForKey:@"highlightIconName"];
    
    if (indexPath.row == self.selectedIndex) {
        cell.alwaysNeedHighlight = YES;
    } else {
        cell.alwaysNeedHighlight = NO;
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selectedIndex != indexPath.row) {
        self.selectedIndex = indexPath.row;
    }
    [self.menuDelegate didSelectItemAtIndex:indexPath.row];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

@end
