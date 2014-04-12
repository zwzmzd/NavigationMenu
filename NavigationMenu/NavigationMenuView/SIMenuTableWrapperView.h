//
//  SIMenuTableWrapperView.h
//  QDMail
//
//  Created by Wenzhe Zhou on 14-3-29.
//  Copyright (c) 2014年 QiDuo Tech Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SIMenuDelegate;

@interface SIMenuTableWrapperView : UIView

@property (nonatomic, assign) NSInteger initialSelectedIndex;
@property (nonatomic, weak) id<SIMenuDelegate> delegate;

- (id)initWithFrame:(CGRect)frame withItems:(NSArray *)items;

- (void)show;
- (void)hide:(void (^)())completion;

@end
