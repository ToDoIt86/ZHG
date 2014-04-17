//
//  UserRegisterVC.m
//  ZHG
//
//  Created by lihong on 14-4-16.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import "UserRegisterVC.h"
#import "WSUser.h"
#import "AlertView.h"
#import "HUD.h"

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

- (IBAction)getVerificationCode:(UIButton *)sender
{
    
}

- (IBAction)userRegister:(UIButton *)sender
{
    if(self.phoneNumberTextField.text.length == 0)
    {
        [AlertView showWithMessage:@"请输入电话号码"];
        return;
    }
    
    if(self.passwordTextField.text.length == 0)
    {
        [AlertView showWithMessage:@"请输入密码"];
        return;
    }
    
    if(self.repeatPasswordTextField.text == 0)
    {
        [AlertView showWithMessage:@"请重复输入密码"];
        return;
    }
    
    if([self.repeatPasswordTextField.text isEqualToString:self.passwordTextField.text] == NO)
    {
        [AlertView showWithMessage:@"两次输入密码不一致!"];
        return;
    }
    
    if(self.verificationCodeTextField.text.length == 0)
    {
        [AlertView showWithMessage:@"请输入验证码"];
        return;
    }
    
    [HUD showHUDAddedTo:self.view animated:YES];
    
    [WSUser registerWithUserName:self.phoneNumberTextField.text
                     andPassword:self.passwordTextField.text
                     phoneNumber:self.phoneNumberTextField.text
                        nickname:self.nicknameTextField.text
                     onCompleted:^(JSONModel *model, JSONModelError *err) {
           
                         [HUD hideHUDForView:self.view animated:YES];
                         
                         MWSResponse *response = (MWSResponse *)model;
                         if(response.success == NO)
                         {
                             NSString *message = [NSString stringWithFormat:@"注册失败,%@",response.message];
                             [AlertView showWithMessage:message];
                         }
                         else
                         {
                             
                         }
    }];
}


@end
