//
//  UIView+ContentSize.m
//  ZHG
//
//  Created by lihong on 14-5-6.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import "UIView+ContentSize.h"

@implementation UIView (size)
- (CGSize)calculateSize
{
    CGRect newRect = CGRectZero;
    for(UIView *view in self.subviews)
    {
        newRect = CGRectUnion(newRect, view.frame);
    }
    
    return newRect.size;
}
@end
