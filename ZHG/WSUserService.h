//
//  WSUserService.h
//  ZHG
//
//  Created by lihong on 14-5-7.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import "SOAPClient.h"

@class MUser;

@interface WSUserService : SOAPClient

+ (void) registerWithUserName:(NSString *)userName
                  andPassword:(NSString *)password
                  phoneNumber:(NSString *)phoneNumber
                     nickname:(NSString *)nickname
                  onCompleted:(JSONModelObjectBlock)block;

+ (void) loginWithUserName:(NSString *)userName
               andPassword:(NSString *)password
               onCompleted:(JSONModelObjectBlock)block;

+ (void) getUserInfoWithUserName:(NSString *)userName
                     andPassword:(NSString *)password
                     onCompleted:(JSONModelObjectBlock)block;

@end
