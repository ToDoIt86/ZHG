//
//  UserManager.m
//  ZHG
//
//  Created by lihong on 14-5-22.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import "UserManager.h"

static NSString *kUserName = @"kUserName";
static NSString *kUserPassword = @"kUserPassword";
static NSString *kUserObject = @"kUserObject";

static MUser *loginedUser = nil;

@implementation UserManager

+ (NSString *)getUserName
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kUserName];
}

+ (NSString *)getUserPassword
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kUserPassword];
}

+ (void)storeUserName:(NSString *)userName andPassword:(NSString *)password
{
    [[NSUserDefaults standardUserDefaults] setObject:userName forKey:kUserName];
    [[NSUserDefaults standardUserDefaults] setObject:password forKey:kUserPassword];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)logoutFromLocal
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserName];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserPassword];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)isUserLogin
{
    NSString *userName = [[NSUserDefaults standardUserDefaults] objectForKey:kUserName];
    NSString *userPassword = [[NSUserDefaults standardUserDefaults] objectForKey:kUserPassword];
    return userName && userPassword;
}

+ (MUser *)getLoginedUser
{
    if(loginedUser)return loginedUser;
    
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:kUserObject];
    loginedUser = [[MUser alloc] initWithDict:dict];
    return loginedUser;
}

+ (void)setLoginedUser:(MUser *)user
{
    loginedUser = user;
    [[NSUserDefaults standardUserDefaults] setObject:[user toDict] forKey:kUserObject];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
