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

- (id)initWithItems:(NSArray *)items;
- (void)setSCFrame:(CGRect)frame;
- (void)hideIndicatorView:(BOOL)yesOrNo;
- (void)setItemTitle:(NSString *)title for:(NSUInteger)itemIndex;
@end
