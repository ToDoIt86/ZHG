//
//  UIScrollView+ContentSize.m
//  ZHG
//
//  Created by lihong on 14-4-29.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import "UIScrollView+ContentSize.h"

@implementation UIScrollView (ContentSize)

- (void)calculateAndSetContentSize
{
    CGRect newRect = CGRectZero;
    for(UIView *view in self.subviews)
    {
        newRect = CGRectUnion(newRect, view.frame);
    }
    
    self.contentSize = newRect.size;
}

@end
