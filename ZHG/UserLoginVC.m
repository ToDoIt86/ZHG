//
//  UserLoginVC.m
//  ZHG
//
//  Created by lihong on 14-4-16.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import "UserLoginVC.h"
#import "AlertView.h"
#import "WSUserService.h"
#import "HUD.h"
#import "UserRegisterVC.h"
#import "MWSResponse.h"
#import "HomeVC.h"
#import "UserManager.h"
#import "UIColor+RGB.h"
#import "AppDelegate.h"
#import "MUser.h"

@interface UserLoginVC ()
@property (weak, nonatomic) IBOutlet UITextField *userAccountTF;
@property (weak, nonatomic) IBOutlet UITextField *userPasswordTF;
@end

@implementation UserLoginVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"UserLoginVC" bundle:nil];
    if (self) {
        self.title = @"用户登录";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"找回密码" forState:UIControlStateNormal];
    [button setFrame:CGRectMake(0, 0, 100, 40)];
    [button setFont:[UIFont systemFontOfSize:13]];
    [button addTarget:self action:@selector(pushRetrieveUserPassworController) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

#pragma mark -Action

- (IBAction)userLogin:(UIButton *)sender
{
    NSString *userName = self.userAccountTF.text;
    NSString *password = self.userPasswordTF.text;
    
    if(userName.length == 0)
    {
        [AlertView showWithMessage:@"请输入账号。"];
        return;
    }
    
    if(password.length == 0)
    {
        [AlertView showWithMessage:@"请输入密码。"];
        return;
    }
    
    [self.view endEditing:YES];
    [HUD showHUDInView:self.view title:@"请稍后.."];
    
    [WSUserService loginWithUserName:userName
                  andPassword:password
                  onCompleted:^(JSONModel *model, JSONModelError* err){
         
      [HUD hideHUDForView:self.view];
                      
      UserLoginResponse *response = (UserLoginResponse *)model;
      if(response.success == YES)
      {
          [UserManager setLoginedUser:response.Datas];
          [UserManager storeUserName:userName andPassword:password];
          [self dismissSelf];
      }
      else
      {
          NSString *message = [NSString stringWithFormat:@"登录失败!请检查用户名、密码是否正确,网络连接是否正常?"];
          [AlertView showWithMessage:message];
      }
  }];
}

- (IBAction)pushUserRegisterController:(id)sender
{
    UserRegisterVC *vc = [[UserRegisterVC alloc] initWithNibName:@"UserRegisterVC" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)pushRetrieveUserPassworController
{
    
}

- (void)dismissSelf
{
    if(self.navigationController)
    {
        if([[self.navigationController.viewControllers[0] class] isSubclassOfClass:[self class]])
        {
            [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
        }
        else
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else
    {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}
@end
