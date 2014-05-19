//
//  WSUserService.m
//  ZHG
//
//  Created by lihong on 14-5-7.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import "WSUserService.h"
#import "MUser.h"
#import "MWSResponse.h"

@implementation WSUserService


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


+ (void) getTopManUserType:(NSString *)type
                     order:(NSString *)order
                     index:(NSString *)index
                      size:(NSString *)size
               onCompleted:(JSONModelObjectBlock)block
{
    NSDictionary *dict = @{@"UserType":type,@"order":order,@"pindex":index,@"psize":size};
    [SOAPClient requestFromURL:SOAPService(@"user/UserService.asmx")
                    soapAction:SOAPAction(@"getTopMan")
                        params:dict
                    completion:^(NSString *jsonString, JSONModelError *err) {
                        //NSLog(@"%@ %@", jsonString, err);
                    }];
}

+ (void)getTopManClassWithParentId:(NSString *)parentId
                       onCompleted:(JSONModelObjectBlock)block
{
    NSDictionary *dict = @{@"parentid":parentId};
    [SOAPClient requestFromURL:SOAPService(@"user/UserConterService.asmx")
                    soapAction:@"http://tempuri.org/GetTopmanClass"
                        params:dict
                    completion:^(NSString *jsonString, JSONModelError *err) {
                        NSLog(@"---%@",jsonString);
    }];
}

+ (void)getUserScoreWithUsersn:(NSString *)usersn
                   onCompleted:(JSONModelObjectBlock)block
{
    NSDictionary *dict = @{@"usersn":usersn};
    [SOAPClient requestFromURL:SOAPService(@"user/UserService.asmx")
                    soapAction:SOAPAction(@"GetUserScoue")
                        params:dict
                    completion:^(NSString *jsonString, JSONModelError *err) {
        
    }];
}


// 个人中心.地址信息
+ (void)getBuyerAddress:(NSString *)account
            onCompleted:(JSONModelObjectBlock)block
{
    NSDictionary *dict = @{@"account":account};
    [SOAPClient requestFromURL:SOAPService(@"user/UserService.asmx")
                    soapAction:SOAPAction(@"getBuyerAddress")
                        params:dict
                    completion:^(NSString *jsonString, JSONModelError *err) {
                        
    }];
}

// 个人中心.修改地址
+ (void)SOUBuyerAddress:(NSString *)address
            onCompleted:(JSONModelObjectBlock)block
{
    NSDictionary *dict = @{@"SOUBuyerAddressResult":address};
    [SOAPClient requestFromURL:SOAPService(@"user/UserService.asmx")
                    soapAction:SOAPAction(@"SOUBuyerAddress")
                        params:dict
                    completion:^(NSString *jsonString, JSONModelError *err) {
                        
    }];
}
@end

