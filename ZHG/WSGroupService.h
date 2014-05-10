//
//  WSFoodShops.h
//  ZHG
//
//  Created by lihong on 14-4-13.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import "SOAPClient.h"
#import <CoreLocation/CoreLocation.h>

// 探商淘美食服务接口
@interface WSGroupService : SOAPClient

+ (void)getAllGroupOnCompleted:(JSONModelObjectBlock)block;

+ (void)getNearGroupByClassid:(NSUInteger)pageSize
                    pageIndex:(NSUInteger)pageIndex
                   coordinate:(CLLocationCoordinate2D)coordinate
                  onCompleted:(JSONModelObjectBlock)block;

+ (void)getGroupByClassid:(NSUInteger)pageSize
                pageIndex:(NSUInteger)pageIndex
               coordinate:(CLLocationCoordinate2D)coordinate
                    order:(NSString *)order
              onCompleted:(JSONModelObjectBlock)block;

+ (void)getGroupByAreaId:(NSNumber *)areaId
                pageSize:(NSUInteger)pageSize
               pageIndex:(NSUInteger)pageIndex
              coordinate:(CLLocationCoordinate2D)coordinate
                   order:(NSString *)order
             onCompleted:(JSONModelObjectBlock)block;

+ (void)getNearGroupByDistance:(NSUInteger)pageSize
                     pageIndex:(NSUInteger)pageIndex
                    coordinate:(CLLocationCoordinate2D)coordinate
                         distance:(CGFloat)distance
                   onCompleted:(JSONModelObjectBlock)block;

+ (void)getGroupBySales:(NSUInteger)pageSize
              pageIndex:(NSUInteger)pageIndex
             coordinate:(CLLocationCoordinate2D)coordinate
            onCompleted:(JSONModelObjectBlock)block;

+ (void)getGroupByDiscount:(NSUInteger)pageSize
                 pageIndex:(NSUInteger)pageIndex
                coordinate:(CLLocationCoordinate2D)coordinate
               onCompleted:(JSONModelObjectBlock)block;

@end
