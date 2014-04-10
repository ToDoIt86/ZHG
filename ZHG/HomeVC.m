//
//  HomeVC.m
//  ZHG
//
//  Created by lihong on 14-4-8.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import "HomeVC.h"
#import "SOAPClient.h"

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
    
    [SOAPClient requestFromURL:@"http://222.87.129.196/Service/user/UserService.asmx"
                    soapAction:@"http://hmwj.com/chkLogin"
                        params:@{@"account":@"lihongtest",@"pwd":@"lihong2013"}
                    completion:NULL];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
