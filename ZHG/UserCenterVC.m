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
#import "FoodCell.h"
#import "UIScrollView+ContentSize.h"
#import "WSUserService.h"
#import "WSOrderService.h"
#import "HelpCenterVC.h"

@interface UserCenterVC ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *vipLevelLabel;
@property (weak, nonatomic) IBOutlet UILabel *growUpValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;
@property (weak, nonatomic) IBOutlet UILabel *bindPhoneLabel;
@property (weak, nonatomic) IBOutlet UITableView *shoppingHistoryLTableView;
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
   
    [self.scrollView calculateAndSetContentSize];
    
    UINib *nib = [UINib nibWithNibName:@"FoodCell" bundle:nil];
    [self.shoppingHistoryLTableView registerNib:nib forCellReuseIdentifier:@"FoodCell"];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"帮助中心" forState:UIControlStateNormal];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 35, 0, 0)];
    [button setFrame:CGRectMake(0, 0,  100, 40)];
    [button addTarget:self action:@selector(openHelpCenter) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    /*
    if([UserManager isUserLogin] == NO)
    {
        UINavigationController *navigaationController;
        UserLoginVC *ulVC = [[UserLoginVC alloc] initWithNibName:@"UserLoginVC" bundle:nil];
        navigaationController = [[UINavigationController alloc] initWithRootViewController:ulVC];
        [self presentViewController:navigaationController animated:YES completion:NULL];
        return;
    }
    
    NSString *usersn = [UserManager getLoginedUser].Buyersn;
    
    
    // 获取用户积分
    [WSUserService getUserScoreWithUsersn:[UserManager getLoginedUser].Buyersn onCompleted:^(JSONModel *model, JSONModelError *err) {
        
    }];
    
    // 获取购物历史数据
    [WSOrderService getOrdersByBuyerSn:usersn index:@"1" size:@"100" onCompleted:^(JSONModel *model, JSONModelError *err) {
        
    }];
     */
}

#pragma mark - Action

- (void)openHelpCenter
{
    [self.tabBarController setSelectedIndex:3];
}

- (IBAction)userLogout:(id)sender
{
    [UserManager logoutFromLocal];
    
    UINavigationController *navigaationController;
    UserLoginVC *ulVC = [[UserLoginVC alloc] initWithNibName:@"UserLoginVC" bundle:nil];
    navigaationController = [[UINavigationController alloc] initWithRootViewController:ulVC];
    [self presentViewController:navigaationController animated:YES completion:NULL];
}

- (IBAction)showMemberIntegral:(id)sender
{
    
}
- (IBAction)activeForIntegral:(id)sender
{
    
}
- (IBAction)integralExchange:(id)sender
{
    
}
- (IBAction)explainForMemeberIntegral:(id)sender
{
}

- (IBAction)modifyUserNickname:(id)sender
{
    
}

- (IBAction)modifyUserPassword:(id)sender
{
    
}

- (IBAction)modifyBindMobliePhoneNumber:(id)sender
{
    
}

- (IBAction)modifyUserAddress:(id)sender
{
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FoodCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FoodCell"];
    return cell;
}
@end
