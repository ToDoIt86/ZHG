//
//  WSUser.m
//  ZHG
//
//  Created by lihong on 14-4-11.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import "WSUser.h"
#import "MUser.h"

@implementation WSUser

+ (void) registerWithUserName:(NSString *)userName
                  andPassword:(NSString *)password
                  phoneNumber:(NSString *)phoneNumber
                     nickname:(NSString *)nickname
                  onCompleted:(JSONModelObjectBlock)block
{
    [SOAPClient requestFromURL:SOAPService(@"user/userservice.asmx")
                    soapAction:SOAPAction(@"Mobileregister")
                        params:@{@"account":userName,@"pwd":password,@"phone":phoneNumber,@"nickname":nickname}
                    completion:^(id jsonString, JSONModelError *err) {
                        
                        if(block){
                            JSONModelError *err = nil;
                            MWSResponse *response = [[MWSResponse alloc] initWithString:jsonString error:&err];
                            block(response,err);
                        }
                    }];
}

+ (void) loginWithUserName:(NSString *)userName
               andPassword:(NSString *)password
               onCompleted:(JSONModelObjectBlock)block
{
    [SOAPClient requestFromURL:SOAPService(@"user/UserService.asmx")
                    soapAction:SOAPAction(@"chkLogin")
                        params:@{@"account":userName,@"pwd":password}
                    completion:^(id jsonString, JSONModelError *err) {
                        
                        if(block){
                            JSONModelError *err = nil;
                            MWSResponse *response = [[MWSResponse alloc] initWithString:jsonString error:&err];
                            if(block)
                            {
                                block(response,err);
                            }
                        }
                    }];
}

+ (void) getUserInfoWithUserName:(NSString *)userName
                  andPassword:(NSString *)password
                  onCompleted:(JSONModelObjectBlock)block
{
    [SOAPClient requestFromURL:SOAPService(@"user/UserService.asmx")
                    soapAction:SOAPAction(@"chkLogin")
                        params:@{@"account":userName,@"Password":password,@"Usersn":@"1"}
                    completion:^(id jsonString, JSONModelError *err) {
                        
                        if(block){
                            JSONModelError *err = nil;
                        }
                    }];
}
@end
