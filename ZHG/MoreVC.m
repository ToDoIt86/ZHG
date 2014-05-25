//
//  MoreVC.m
//  ZHG
//
//  Created by lihong on 14-5-23.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import "MoreVC.h"

@interface MoreVC ()

@end

@implementation MoreVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"更多";
        self.tabBarItem.image = [UIImage imageNamed:@"home_more"];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
