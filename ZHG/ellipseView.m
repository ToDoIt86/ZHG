//
//  ellipseView.m
//  ZHG
//
//  Created by lihong on 14-4-25.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import "ellipseView.h"

@implementation ellipseView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initStep];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if(self){
        [self initStep];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self){
        [self initStep];
    }
    return self;
}


- (void)initStep
{
    self.layer.cornerRadius = 14;
    self.backgroundColor = [UIColor colorWithRed:234.0/0xff green:91.0/0xff blue:80.0/0xff alpha:1.0];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
