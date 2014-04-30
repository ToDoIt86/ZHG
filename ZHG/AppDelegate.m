//
//  AppDelegate.m
//  ZHG
//  ***_*** 恭喜你接手了一坨...CODES，特别是..UI.. 😁😄😄😄
//  Created by lihong on 14-4-3.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import "AppDelegate.h"
#import "HomeVC.h"
#import "WSProductCategory.h"
#import "WSFoodShops.h"
#import "UIColor+RGB.h"
#import "LHLocationManager.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [LHLocationManager sharedInstance];
    
    UINavigationController *navigaationController =
    [[UINavigationController alloc] initWithRootViewController:[[HomeVC alloc] initWithNibName:@"HomeVC" bundle:nil]];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = navigaationController;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigation_bar_background"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor colorWithWhite:1 alpha:1], NSForegroundColorAttributeName,[UIFont systemFontOfSize:18], NSFontAttributeName,
                                                            nil]];

    [self.window makeKeyAndVisible];

    for(UIView *v in navigaationController.navigationBar.subviews)
    {
        if([NSStringFromClass([v class]) isEqualToString:@"_UINavigationBarBackground"])
        {
            [v setFrame:CGRectMake(0, 0, 320,44)];
        }
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
