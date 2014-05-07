//
//  TabBar.h
//  ZHG
//
//  Created by lihong on 14-5-7.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectedIndexAtTabBarBlock)(NSInteger index);

@interface TabBar : UIView

@property (nonatomic, copy) SelectedIndexAtTabBarBlock block;

+ (void)showTabBar:(SelectedIndexAtTabBarBlock)block;

+ (void)hide;
+ (void)show;

@end
