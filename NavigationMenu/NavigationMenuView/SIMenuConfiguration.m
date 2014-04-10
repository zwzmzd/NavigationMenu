//
//  SIMenuConfiguration.m
//  NavigationMenu
//
//  Created by Ivan Sapozhnik on 2/20/13.
//  Copyright (c) 2013 Ivan Sapozhnik. All rights reserved.
//

#import "SIMenuConfiguration.h"

@implementation SIMenuConfiguration
//Menu width
+ (float)menuWidth
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    return window.frame.size.width;
}

//Menu item height
+ (float)itemCellHeight
{
    return 45.f;
}

//Animation duration of menu appearence
+ (float)animationDuration
{
    return 0.3f;
}

//Menu substrate alpha value
+ (float)backgroundAlpha
{
    return 0.6;
}

//Menu alpha value
+ (float)menuAlpha
{
    return 1.f;
}

//Value of bounce
+ (float)bounceOffset
{
    return -7.0;
}

//Arrow image near title
+ (UIImage *)arrowImage
{
    return [UIImage imageNamed:@"arrow_down.png"];
}

//Distance between Title and arrow image
+ (float)arrowPadding
{
    return 13.0;
}

//Items color in menu
+ (UIColor *)itemsColor
{
    return [UIColor colorWithRed:241.f / 255.f green:241.f / 255.f blue:241.f / 255.f alpha:1.f];
}

+ (UIColor *)mainColor
{
    return [UIColor blackColor];
}

+ (float)selectionSpeed
{
    return 2.f;
}

+ (UIColor *)itemTextColor
{
    return [UIColor colorWithRed:102.f / 255.f green:102.f / 255.f blue:102.f / 255.f alpha:1.f];
}

+ (UIColor *)highlightItemTextColor {
    return [UIColor colorWithRed:0x23 / 255.f green:0x8d / 255.f blue:0xd7 / 255.f alpha:1.f];
}

+ (UIColor *)selectionColor
{
    return [UIColor colorWithRed:45.0/255.0 green:105.0/255.0 blue:166.0/255.0 alpha:1.0];
}

+ (UIColor *)separatorColor {
    return [UIColor colorWithRed:224.f /255.0 green:224.f /255.0 blue:224.f /255.0 alpha:1.0];
}
@end
