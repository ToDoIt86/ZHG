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
#import "UIScrollView+ContentSize.h"
#import "TabBar.h"
#import "UserCenterVC.h"
#import "UserManager.h"
#import "SettingVC.h"
#import "DarenHomeVC.h"

@interface HomeVC ()<UINavigationControllerDelegate>
@property (nonatomic, strong) UIImageView *logImageView;
@property (nonatomic, strong) UIButton *searchButton;

@property (weak, nonatomic) IBOutlet UIScrollView *adScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *adPageControl;

@property (weak, nonatomic) IBOutlet UIScrollView *menuScrollView;

@property (strong, nonatomic) IBOutlet UIView *tabBar;
@property (strong, nonatomic) UIWindow *tabBarWindow;
@end

@implementation HomeVC


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.image = [UIImage imageNamed:@"home_setting"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.logImageView = [[UIImageView alloc] initWithFrame:CGRectMake(-5, 0, 100, 44)];
    [self.logImageView setImage:[UIImage imageNamed:@"logo"]];
    
    self.searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.searchButton.frame = CGRectMake(320-44, 0, 44, 44);
    [self.searchButton setImage:[UIImage imageNamed:@"home_search_button"] forState:UIControlStateNormal];
    
    
    [self insertAdContent];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar addSubview:self.logImageView];
    [self.navigationController.navigationBar addSubview:self.searchButton];
    
    // 进入达人后，导航栏会被隐藏，tabbar背景会被改变。这里改回来
    self.navigationController.navigationBarHidden = NO;
    UIImage *image = [[UIImage imageNamed:@"tabbar"] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1)];
    [self.tabBarController.tabBar setBackgroundImage:image];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.logImageView removeFromSuperview];
    [self.searchButton removeFromSuperview];
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
}

- (IBAction)pushDarenHomeVC:(id)sender
{
    DarenHomeVC *dhvc = [[DarenHomeVC alloc] initWithNibName:@"DarenHomeVC" bundle:nil];
    [self.navigationController pushViewController:dhvc animated:YES];
}

#pragma mark － Advertising

- (void)insertAdContent
{
    self.adPageControl.numberOfPages = 4;
    CGRect newRect = self.adScrollView.bounds;
    for(int i = 0; i < 4; i++)
    {
        newRect.origin.x = i*newRect.size.width;
        UIImageView *iamgeView = [[UIImageView alloc] initWithFrame:newRect];
        iamgeView.image = [UIImage imageNamed:[NSString stringWithFormat:@"ad%d.jpg",i]];
        [self.adScrollView addSubview:iamgeView];
    }
    
    [self.adScrollView calculateAndSetContentSize];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    NSInteger pageIndex = floorf( scrollView.contentOffset.x/scrollView.bounds.size.width);
    self.adPageControl.currentPage = pageIndex;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
}
@end
