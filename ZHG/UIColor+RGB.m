//
//  UIColor+RGB.m
//  ZHG
//
//  Created by lihong on 14-4-25.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import "UIColor+RGB.h"

@implementation UIColor (RGB)
+ (UIColor *)r:(ColorType)r g:(ColorType)g b:(ColorType)b a:(CGFloat)a
{
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a];

}
+ (UIColor *)r:(ColorType)r g:(ColorType)g b:(ColorType)b
{
    return [UIColor r:r g:g b:b a:1.0];
}
@end
