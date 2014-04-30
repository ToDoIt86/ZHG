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

+ (void)getNearGroupByClassid:(NSUInteger)pageSize pageIndex:(NSUInteger)pageIndex coordinate:(CLLocationCoordinate2D)coordinate onCompleted:(JSONModelObjectBlock)block
{
    NSDictionary *dict =@{@"classid"  :@(classId),
                          @"pagesize" :@(pageSize),
                          @"pageindex":@(pageIndex),
                          @"Latitude" :@(coordinate.latitude),
                          @"Longitude":@(coordinate.longitude)};
    
    [SOAPClient requestFromURL:SOAPService(@"basic/GroupService.asmx") soapAction:SOAPAction(@"GetNearGroupByClassid") params:dict completion:^(NSString *jsonString, JSONModelError *err) {
        NSLog(@"%@",jsonString);
    }];
}

+ (void)getGroupByClassid:(NSUInteger)pageSize pageIndex:(NSUInteger)pageIndex coordinate:(CLLocationCoordinate2D)coordinate order:(NSString *)order onCompleted:(JSONModelObjectBlock)block
{
    NSDictionary *dict =@{@"classid"  :@(classId),
                          @"pagesize" :@(pageSize),
                          @"pageindex":@(pageIndex),
                          @"Latitude" :@(coordinate.latitude),
                          @"Longitude":@(coordinate.longitude),
                          @"order"    :order};
    
    [SOAPClient requestFromURL:SOAPService(@"basic/GroupService.asmx") soapAction:SOAPAction(@"GetGroupByClassid ") params:dict completion:^(NSString *jsonString, JSONModelError *err) {
        NSLog(@"%@",jsonString);
    }];
}

+ (void)getGroupByAreaId:(NSString *)areaId pageSize:(NSUInteger)pageSize pageIndex:(NSUInteger)pageIndex coordinate:(CLLocationCoordinate2D)coordinate order:(NSString *)order onCompleted:(JSONModelObjectBlock)block
{
    NSDictionary *dict =@{@"areaid"   :areaId,
                          @"pagesize" :@(pageSize),
                          @"pageindex":@(pageIndex),
                          @"Latitude" :@(coordinate.latitude),
                          @"Longitude":@(coordinate.longitude),
                          @"order"    :order};
    
    [SOAPClient requestFromURL:SOAPService(@"basic/GroupService.asmx") soapAction:SOAPAction(@"GetGroupByAreaId ") params:dict completion:^(NSString *jsonString, JSONModelError *err) {
        NSLog(@"%@",jsonString);
    }];
}

+ (void)getNearGroupByDistance:(NSUInteger)pageSize
                     pageIndex:(NSUInteger)pageIndex
                    coordinate:(CLLocationCoordinate2D)coordinate
                      distance:(CGFloat)distance
                   onCompleted:(JSONModelObjectBlock)block
{
    NSDictionary *dict =@{@"classid"  :@(classId),
                          @"pagesize" :@(pageSize),
                          @"pageindex":@(pageIndex),
                          @"Latitude" :@(coordinate.latitude),
                          @"Longitude":@(coordinate.longitude),
                          @"Distance" :@(distance)};
    
    [SOAPClient requestFromURL:SOAPService(@"basic/GroupService.asmx") soapAction:SOAPAction(@"GetNearGroupByDistance ") params:dict completion:^(NSString *jsonString, JSONModelError *err) {
        NSLog(@"%@",jsonString);
    }];
}

+ (void)getGroupBySales:(NSUInteger)pageSize
              pageIndex:(NSUInteger)pageIndex
             coordinate:(CLLocationCoordinate2D)coordinate
            onCompleted:(JSONModelObjectBlock)block
{
    NSDictionary *dict =@{@"classid"  :@(classId),
                          @"pagesize" :@(pageSize),
                          @"pageindex":@(pageIndex),
                          @"Latitude" :@(coordinate.latitude),
                          @"Longitude":@(coordinate.longitude)
                         };
    
    [SOAPClient requestFromURL:SOAPService(@"basic/GroupService.asmx") soapAction:SOAPAction(@"GetGroupBySales ") params:dict completion:^(NSString *jsonString, JSONModelError *err) {
        NSLog(@"%@",jsonString);
    }];
}

+ (void)getGroupByDiscount:(NSUInteger)pageSize
                 pageIndex:(NSUInteger)pageIndex
                coordinate:(CLLocationCoordinate2D)coordinate
               onCompleted:(JSONModelObjectBlock)block
{
    NSDictionary *dict =@{@"classid"  :@(classId),
                          @"pagesize" :@(pageSize),
                          @"pageindex":@(pageIndex),
                          @"Latitude" :@(coordinate.latitude),
                          @"Longitude":@(coordinate.longitude)
                          };
    
    [SOAPClient requestFromURL:SOAPService(@"basic/GroupService.asmx") soapAction:SOAPAction(@"GetGroupByDiscount ") params:dict completion:^(NSString *jsonString, JSONModelError *err) {
        NSLog(@"%@",jsonString);
    }];
}
@end
