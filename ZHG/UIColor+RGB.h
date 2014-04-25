//
//  UIColor+RGB.h
//  ZHG
//
//  Created by lihong on 14-4-25.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import <UIKit/UIKit.h>

typedef unsigned char ColorType;

@interface UIColor (RGB)
+ (UIColor *)r:(ColorType)r g:(ColorType)g b:(ColorType)b;
@end
