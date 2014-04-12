//
//  SOAPAction.m
//  ZHG
//
//  Created by lihong on 14-4-12.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import "SOAPAction.h"

#define makeSOAPAction(method)\
[NSString stringWithFormat:@"http://hmwj.com/%@",method]

@implementation SOAPAction

+ (SOAPAction *)shared
{
    static SOAPAction *instance = nil;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        instance = [[SOAPAction alloc] init];
    });
    
    return instance;
}

- (NSString *)userLogin
{
    return makeSOAPAction(@"chkLogin");
}

@end
