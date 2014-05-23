//
//  UserCenterVC.m
//  ZHG
//
//  Created by lihong on 14-4-16.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import "UserCenterVC.h"
#import "UserLoginVC.h"
#import "UserManager.h"
#import "UserManager.h"
#import "UserLoginVC.h"

@interface UserCenterVC ()

@end

@implementation UserCenterVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"个人中心";
        self.tabBarItem.image = [UIImage imageNamed:@"home_user_center"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"帮助中心" forState:UIControlStateNormal];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 35, 0, 0)];
    [button setFrame:CGRectMake(0, 0,  100, 40)];
    [button addTarget:self action:@selector(openHelpCenter) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    if([UserManager isUserLogin] == NO)
    {
        UINavigationController *navigaationController;
        UserLoginVC *ulVC = [[UserLoginVC alloc] initWithNibName:@"UserLoginVC" bundle:nil];
        navigaationController = [[UINavigationController alloc] initWithRootViewController:ulVC];
        [self presentViewController:navigaationController animated:YES completion:NULL];
    }
}


#pragma mark - Action

- (void)openHelpCenter
{
    
}

- (IBAction)userLogout:(id)sender
{
    [UserManager logoutFromLocal];
    
    UINavigationController *navigaationController;
    UserLoginVC *ulVC = [[UserLoginVC alloc] initWithNibName:@"UserLoginVC" bundle:nil];
    navigaationController = [[UINavigationController alloc] initWithRootViewController:ulVC];
    [self presentViewController:navigaationController animated:YES completion:NULL];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
