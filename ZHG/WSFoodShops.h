//
//  WSFoodShops.h
//  ZHG
//
//  Created by lihong on 14-4-13.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import "SOAPClient.h"
#import <CoreLocation/CoreLocation.h>

@interface WSFoodShops : SOAPClient

+ (void)getNearGroupWithpageSize:(NSUInteger)pageSize pageIndex:(NSUInteger)pageIndex coordinate:(CLLocationCoordinate2D)coordinate onCompleted:(JSONModelObjectBlock)block;
@end
