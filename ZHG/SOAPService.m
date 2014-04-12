//
//  SOAPService.m
//  ZHG
//
//  Created by lihong on 14-4-12.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import "SOAPService.h"

#define makeSOAPService(servicePath)\
[NSString stringWithFormat:@"http://222.87.129.196/%@",servicePath]

@implementation SOAPService

+ (SOAPService *)shared
{
    static SOAPService *instance = nil;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        instance = [[SOAPService alloc] init];
    });
    
    return instance;
}

- (NSString *)userService
{
    return makeSOAPService(@"Service/user/UserService.asmx");
}
@end
