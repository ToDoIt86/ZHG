//
//  TabBar.m
//  ZHG
//
//  Created by lihong on 14-5-7.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import "TabBar.h"

static UIWindow *window = nil;

@implementation TabBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (IBAction)action:(UIButton *)sender
{
    if(self.block) self.block(sender.tag);
}

+ (void)showTabBar:(SelectedIndexAtTabBarBlock)block
{
    if(window) return;

    UINib *nib = [UINib nibWithNibName:@"TabBar" bundle:nil];
    TabBar *tabBar = [[nib instantiateWithOwner:nil options:nil] objectAtIndex:0];
    tabBar.block = block;
    
    CGRect newRect = [[UIScreen mainScreen] bounds];
    newRect.origin.y = newRect.size.height - tabBar.bounds.size.height;
    newRect.size = tabBar.bounds.size;
    
    window = [[UIWindow alloc] initWithFrame:newRect];
    window.windowLevel = UIWindowLevelAlert-0.5;
    [window addSubview:tabBar];
    [window makeKeyAndVisible];
}

+ (void)hide
{
    if(window)  window.hidden = YES;

}

+ (void)show
{
    if(window) window.hidden = NO;

}
@end
