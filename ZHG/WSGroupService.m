//
//  WSFoodShops.m
//  ZHG
//
//  Created by lihong on 14-4-13.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import "WSGroupService.h"
#import "FoodShop.h"
#import "MWSResponse.h"

static NSUInteger classId = 2;

@implementation WSGroupService

+ (void)getAllGroupOnCompleted:(JSONModelObjectBlock)block
{
    [SOAPClient requestFromURL:SOAPService(@"basic/GroupService.asmx") soapAction:SOAPAction(@"getAllGroup") params:nil completion:^(NSString *jsonString, JSONModelError *err) {
        MWSResponse *response = [[MWSResponse alloc] initWithString:jsonString error:nil];
        block(response,err);
    }];
}

+ (void)getNearGroupByClassid:(NSUInteger)pageSize pageIndex:(NSUInteger)pageIndex coordinate:(CLLocationCoordinate2D)coordinate onCompleted:(JSONModelObjectBlock)block
{
    NSDictionary *dict =@{@"classid"  :@(classId),
                          @"pagesize" :@(pageSize),
                          @"pageindex":@(pageIndex),
                          @"Latitude" :@(coordinate.latitude),
                          @"Longitude":@(coordinate.longitude)};
    
    [SOAPClient requestFromURL:SOAPService(@"basic/GroupService.asmx") soapAction:SOAPAction(@"GetNearGroupByClassid") params:dict completion:^(NSString *jsonString, JSONModelError *err) {
        FoodShopResponse *response = [[FoodShopResponse alloc] initWithString:jsonString error:nil];
        block(response,err);
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
    
    [SOAPClient requestFromURL:SOAPService(@"basic/GroupService.asmx") soapAction:SOAPAction(@"GetGroupByClassid") params:dict completion:^(NSString *jsonString, JSONModelError *err) {
        FoodShopResponse *response = [[FoodShopResponse alloc] initWithString:jsonString error:nil];
        block(response,err);
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
    
    [SOAPClient requestFromURL:SOAPService(@"basic/GroupService.asmx") soapAction:SOAPAction(@"GetGroupByAreaId") params:dict completion:^(NSString *jsonString, JSONModelError *err) {
        FoodShopResponse *response = [[FoodShopResponse alloc] initWithString:jsonString error:nil];
        block(response,err);
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
    
    [SOAPClient requestFromURL:SOAPService(@"basic/GroupService.asmx") soapAction:SOAPAction(@"GetNearGroupByDistance") params:dict completion:^(NSString *jsonString, JSONModelError *err) {
        FoodShopResponse *response = [[FoodShopResponse alloc] initWithString:jsonString error:nil];
        block(response,err);
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
    
    [SOAPClient requestFromURL:SOAPService(@"basic/GroupService.asmx") soapAction:SOAPAction(@"GetGroupBySales") params:dict completion:^(NSString *jsonString, JSONModelError *err) {
        FoodShopResponse *response = [[FoodShopResponse alloc] initWithString:jsonString error:nil];
        block(response,err);
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
    
    [SOAPClient requestFromURL:SOAPService(@"basic/GroupService.asmx") soapAction:SOAPAction(@"GetGroupByDiscount") params:dict completion:^(NSString *jsonString, JSONModelError *err) {
        FoodShopResponse *response = [[FoodShopResponse alloc] initWithString:jsonString error:nil];
        block(response,err);
    }];
}
@end
