//
//  SAMenuCell.h
//  NavigationMenu
//
//  Created by Ivan Sapozhnik on 2/19/13.
//  Copyright (c) 2013 Ivan Sapozhnik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SIMenuCell : UITableViewCell

@property (strong, nonatomic) NSString *normalIcon;
@property (strong, nonatomic) NSString *selectedIcon;
@property (strong, nonatomic) NSString *highlightIcon;
@property (assign, nonatomic) BOOL isSelected;
@property (assign, nonatomic) BOOL bypassUnhighligtCallback;

@end
