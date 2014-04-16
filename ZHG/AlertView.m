//
//  AlertView.m
//  ZHG
//
//  Created by lihong on 14-4-16.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import "AlertView.h"

static AlertViewBlock alertViewBlock;

@implementation AlertView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (AlertView *)sharedInstance
{
    static AlertView *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[AlertView alloc] init];
        instance.delegate = instance;
    });
    
    return instance;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertViewBlock)
    {
        alertViewBlock(buttonIndex);
    }
}

+ (void)showWithMessage:(NSString *)message
{
    [AlertView showWithMessage:message block:NULL];
}

+ (void)showWithMessage:(NSString *)message block:(AlertViewBlock)block
{
    [AlertView showWithTitle:@"提示" message:message buttons:@[@"关闭"] block:block];
}

+ (void)showWithTitle:(NSString *)title
              message:(NSString *)message
              buttons:(NSArray *)titles
                block:(AlertViewBlock)block
{
    if(block)
    {
       alertViewBlock = [block copy];
    }
    
    [[AlertView sharedInstance] setTitle:title];
    [[AlertView sharedInstance] setMessage:message];
    for(NSString *buttonTitle in titles)
    {
        [[AlertView sharedInstance] addButtonWithTitle:buttonTitle];
    }
    
    [[AlertView sharedInstance] show];
}
@end
