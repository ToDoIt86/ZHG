//
//  AppDelegate.m
//  ZHG
//  Created by lihong on 14-4-3.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import "AppDelegate.h"
#import "HomeVC.h"
#import "UIColor+RGB.h"
#import "LHLocationManager.h"
#import "UserLoginVC.h"
#import "UserManager.h"
#import "SettingVC.h"
#import "MessageVC.h"
#import "MoreVC.h"
#import "UserCenterVC.h"
#import "HelpCenter.h"
#import "UIColor+RGB.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [LHLocationManager sharedInstance];
    [self setAppearance];
    
    UIViewController *vc1, *vc2, *vc3, *vc4, *vc5;
    vc1 = [[HomeVC alloc] initWithNibName:@"HomeVC" bundle:nil];
    vc2 = [[UserCenterVC alloc] initWithNibName:@"UserCenterVC" bundle:nil];
    vc3 = [[MessageVC alloc] initWithNibName:@"MessageVC" bundle:nil];
    vc4 = [[HelpCenter alloc] initWithNibName:@"HelpCenter" bundle:nil];
    vc5 = [[MoreVC alloc] initWithNibName:@"MoreVC" bundle:nil];
    
    UINavigationController *nav1, *nav2, *nav3, *nav4, *nav5;
    nav1 = [[UINavigationController alloc] initWithRootViewController:vc1];
    nav2 = [[UINavigationController alloc] initWithRootViewController:vc2];
    nav3 = [[UINavigationController alloc] initWithRootViewController:vc3];
    nav4 = [[UINavigationController alloc] initWithRootViewController:vc4];
    nav5 = [[UINavigationController alloc] initWithRootViewController:vc5];

    UITabBarController *tbCon = [[UITabBarController alloc] init];
    [tbCon setViewControllers:@[nav1,nav2,nav3,nav4,nav5]];
    
    for(UITabBarItem *item in tbCon.tabBar.items)
    {
        item.imageInsets = UIEdgeInsetsMake(4, -5, -10, -5);
        item.title = nil;
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = tbCon;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)setAppearance
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigation_bar_background"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor colorWithWhite:1 alpha:1], NSForegroundColorAttributeName,[UIFont systemFontOfSize:18], NSFontAttributeName,
                                                           nil]];
    
    UIImage *image = [[UIImage imageNamed:@"tabbar"] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1)];
    [[UITabBar appearance] setBackgroundImage:image];
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    
    NSDictionary *attr = @{UITextAttributeTextColor:[UIColor whiteColor]};
    [[UITabBarItem appearance] setTitleTextAttributes:attr forState:UIControlStateNormal];
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
