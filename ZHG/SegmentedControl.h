//
//  SegmentedControl.h
//  ZHG
//
//  Created by lihong on 14-4-18.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SegmentedControl : UIControl

@property (nonatomic, readonly) NSUInteger selectedIndex;
@property (nonatomic, strong) UIColor *itemTitleColor;
@property (nonatomic, strong) UIFont  *itemTitleFont;


- (id)initWithItems:(NSArray *)items;
- (void)setSCFrame:(CGRect)frame;
- (void)hideIndicatorView:(BOOL)yesOrNo;
- (void)setItemTitle:(NSString *)title for:(NSUInteger)itemIndex;

- (void)insertIndicatorWithImageName:(NSString *)imageName atIndex:(NSUInteger)index;
- (void)removeIndicatorAtIndex:(NSUInteger)index;
- (void)removeAllIndicator;

@end
