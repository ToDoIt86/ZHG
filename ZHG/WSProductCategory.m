//
//  WSProductCategory.m
//  ZHG
//
//  Created by lihong on 14-4-28.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import "WSProductCategory.h"

@implementation WSProductCategory
+ (void)getCategoryIdWithParentId:(NSInteger)parentId onCompleted:(JSONModelObjectBlock)block
{
    [SOAPClient requestFromURL:SOAPService(@"Ecommerce/ServiceClassService.asmx") soapAction:SOAPAction(@"GetChildClass") params:@{@"parentid":@(parentId)} completion:^(NSString *jsonString, JSONModelError *err) {
        NSLog(@"%@",jsonString);
    }];
}
@end
