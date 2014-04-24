//
//  HomeVC.m
//  ZHG
//
//  Created by lihong on 14-4-8.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import "HomeVC.h"
#import "SOAPClient.h"
#import "FoodShopsListVC.h"
#import "UserLoginVC.h"

@interface HomeVC ()

@end

@implementation HomeVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action
- (IBAction)pushFoodShopsListVC:(UIButton *)sender
{
    FoodShopsListVC *vc = [[FoodShopsListVC alloc] initWithNibName:@"FoodShopsListVC" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
    
   // UserLoginVC *vc = [[UserLoginVC alloc] initWithNibName:@"UserLoginVC" bundle:nil];
   // [self presentModalViewController:vc animated:YES];
}

@end
