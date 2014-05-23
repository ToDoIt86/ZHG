//
//  UserRegisterVC.m
//  ZHG
//
//  Created by lihong on 14-4-16.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import "UserRegisterVC.h"
#import "WSUserService.h"
#import "AlertView.h"
#import "HUD.h"
#import "MWSResponse.h"
#import "HomeVC.h"
#import "UserManager.h"

@interface UserRegisterVC ()
@property (weak, nonatomic) IBOutlet UITextField *nicknameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *repeatPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *verificationCodeTextField;
@end

@implementation UserRegisterVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       self.title = @"用户注册";
    }
    return self;
}

- (IBAction)getVerificationCode:(UIButton *)sender
{
    
}

- (IBAction)userRegister:(UIButton *)sender
{
    NSString *nickName = self.nicknameTextField.text;
    NSString *phoneNumber = self.phoneNumberTextField.text;
    NSString *password = self.passwordTextField.text;
    NSString *rPassword = self.repeatPasswordTextField.text;
    
    if(phoneNumber.length == 0)
    {
        [AlertView showWithMessage:@"请输入电话号码"];
        return;
    }
    
    if(password.length == 0)
    {
        [AlertView showWithMessage:@"请输入密码"];
        return;
    }
    
    if(rPassword.length == 0)
    {
        [AlertView showWithMessage:@"请重复输入密码"];
        return;
    }
    
    if([rPassword isEqualToString:password] == NO)
    {
        [AlertView showWithMessage:@"两次输入密码不一致!"];
        return;
    }
    
//    if(self.verificationCodeTextField.text.length == 0)
//    {
//        [AlertView showWithMessage:@"请输入验证码"];
//        return;
//    }
    
    [self.view endEditing:YES];
    [HUD showHUDInView:self.view title:@"请稍后"];
    
    [WSUserService registerWithUserName:phoneNumber
                            andPassword:password
                            phoneNumber:phoneNumber
                               nickname:nickName
                            onCompleted:^(JSONModel *model, JSONModelError *err) {
           
         [HUD hideHUDForView:self.view];
                         
         MWSResponse *response = (MWSResponse *)model;
         if(response.success)
         {
             [UserManager storeUserName:phoneNumber andPassword:password];
         }
         else
         {
             NSString *message = [NSString stringWithFormat:@"注册失败,%@",response.message];
             [AlertView showWithMessage:message];
         }
    }];
}


@end
