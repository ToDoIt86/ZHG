//
//  LHLocationManager.h
//  LHLocationManager
//
//  Created by lihong on 14-4-30.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LHLocationManager : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, readonly) NSString *streetAddress;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

@end
