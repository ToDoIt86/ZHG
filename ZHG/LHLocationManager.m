//
//  LHLocationManager.m
//  LHLocationManager
//
//  Created by lihong on 14-4-30.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import "LHLocationManager.h"

@interface LHLocationManager()<CLLocationManagerDelegate>
@property (nonatomic, readwrite) NSString*streetAddress;
@property (nonatomic, readwrite) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) CLGeocoder *clGeocoder;
@property (nonatomic, strong) CLLocationManager *clLocationManager;
@property (nonatomic, assign) BOOL isDecoding;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation LHLocationManager

+ (instancetype)sharedInstance
{
    static LHLocationManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[LHLocationManager alloc] init];
        
        instance.clLocationManager = [[CLLocationManager alloc] init];
        instance.clLocationManager.delegate = instance;
        
        instance.clGeocoder = [[CLGeocoder alloc] init];
        
        instance.timer = [NSTimer scheduledTimerWithTimeInterval:120
                                                          target:instance.clLocationManager
                                                        selector:@selector(startUpdatingLocation)
                                                        userInfo:nil
                                                         repeats:YES];
        
        [[NSNotificationCenter defaultCenter] addObserver:instance
                                                 selector:@selector(handleAppNotification)
                                                     name:UIApplicationDidFinishLaunchingNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:instance
                                                 selector:@selector(handleAppNotification)
                                                     name:UIApplicationWillEnterForegroundNotification
                                                   object:nil];
    });
    
    return instance;
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation
{
    
    /* 检查得到的位置是否是新的，IOS会在获取位置首先去获取缓存的位置信息，缓存位置信息在应用程序之前共享.
       比如在打开应用A之前，我们正在使用百度地图，那么应用A获取的位置信息可能是刚才百度地图缓存的 */
    
    NSTimeInterval interval = [[newLocation timestamp] timeIntervalSinceNow];
    if(interval > -30 && interval < 0)
    {
        [manager stopUpdatingLocation];
        
        self.coordinate = newLocation.coordinate;
        
        if(self.isDecoding == NO)
        {
            [self.clGeocoder reverseGeocodeLocation:newLocation
                                  completionHandler:^(NSArray *placemarks, NSError *error) {
                                      
              if(error == nil && placemarks.count)
              {
                  CLPlacemark *p = [placemarks objectAtIndex:0];
                  self.streetAddress =
                  [NSString stringWithFormat:@"%@%@%@%@",
                   p.locality       ? p.locality       :@"",
                   p.subLocality    ? p.subLocality    :@"" ,
                   p.thoroughfare   ? p.thoroughfare   :@"",
                   p.subThoroughfare? p.subThoroughfare:@""];
              }
                                      
              self.isDecoding = NO;
            }];
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    // 用户不允许使用设备当前的位置
    if(error.code == kCLErrorDenied)
    {
        [manager stopUpdatingLocation];
    }
    
}

#pragma mark -
- (void)handleAppNotification
{
    if([CLLocationManager locationServicesEnabled])
    {
        if([CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied)
        {
            [self.clLocationManager startUpdatingLocation];
        }
        else
        {
            // 在应用级别禁用了定位功能
        }
    }
    else
    {
        // 在系统级别禁用了定位功能
    }
}

#pragma mark - Override
- (NSString *)streetAddress
{
    return [_streetAddress copy];
}
@end
