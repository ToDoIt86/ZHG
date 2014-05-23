//
//  UserManager.h
//  ZHG
//
//  Created by lihong on 14-5-22.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserManager : NSObject

+ (NSString *)getUserName;
+ (NSString *)getUserPassword;

+ (void)storeUserName:(NSString *)userName andPassword:(NSString *)password;
+ (void)logoutFromLocal;
+ (BOOL)isUserLogin;

@end
