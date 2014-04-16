//
//  UserLoginVC.m
//  ZHG
//
//  Created by lihong on 14-4-16.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import "UserLoginVC.h"
#import "AlertView.h"
#import "WSUser.h"
#import "HUD.h"

@interface UserLoginVC ()

@property (weak, nonatomic) IBOutlet UITextField *userAccountTF;
@property (weak, nonatomic) IBOutlet UITextField *userPasswordTF;

@end

@implementation UserLoginVC

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)userLogin:(UIButton *)sender
{
    if(self.userAccountTF.text.length == 0)
    {
        [AlertView showWithMessage:@"请输入账号。"];
        return;
    }
    
    if(self.userPasswordTF.text.length == 0)
    {
        [AlertView showWithMessage:@"请输入密码。"];
        return;
    }
    
    [self.view endEditing:YES];
    [HUD showHUDAddedTo:self.view animated:YES];
    
    [WSUser loginWithUserName:self.userPasswordTF.text
                  andPassword:self.userPasswordTF.text
                  onCompleted:^(JSONModel *model, JSONModelError* err){
                      
      [HUD hideAllHUDsForView:self.view animated:YES];
      
      MWSResponse *response = (MWSResponse *)model;
      if(response.success)
      {
          
      }
      else
      {
          NSString *message = [NSString stringWithFormat:@"登录失败。%@",response.message];
          [AlertView showWithMessage:message];
      }
  }];
}

@end