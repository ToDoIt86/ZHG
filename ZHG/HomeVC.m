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

@interface HomeVC ()
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
    
    CGRect  windowRect = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-44, 320, 44);
    self.tabBarWindow = [[UIWindow alloc] initWithFrame:windowRect];
    self.tabBarWindow.backgroundColor = [UIColor redColor];
    self.tabBarWindow.windowLevel = UIWindowLevelAlert-0.01;
    [self.tabBarWindow makeKeyAndVisible];
    
    [self.tabBarWindow addSubview:self.tabBar];
    [self insertAdContent];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar addSubview:self.logImageView];
    [self.navigationController.navigationBar addSubview:self.searchButton];
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
    
   // UserLoginVC *vc = [[UserLoginVC alloc] initWithNibName:@"UserLoginVC" bundle:nil];
   // [self presentModalViewController:vc animated:YES];
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
@end
