//
//  WSFoodShops.m
//  ZHG
//
//  Created by lihong on 14-4-13.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import "WSFoodShops.h"

static NSUInteger classId = 2;

@implementation WSFoodShops

+ (void)getNearGroupWithpageSize:(NSUInteger)pageSize pageIndex:(NSUInteger)pageIndex coordinate:(CLLocationCoordinate2D)coordinate onCompleted:(JSONModelObjectBlock)block
{
    [SOAPClient requestFromURL:SOAPService(@"basic/GroupService.asmx") soapAction:SOAPAction(@"GetNearGroupByClassid") params:@{@"classid":@(classId),@"pagesize":@(pageSize),@"pageindex":@(pageIndex),@"Latitude":@(coordinate.latitude),@"Longitude":@(coordinate.longitude)} completion:^(NSString *jsonString, JSONModelError *err) {
        NSLog(@"%@",jsonString);
    }];
}
@end
