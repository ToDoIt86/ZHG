//
//  WSUser.h
//  ZHG
//
//  Created by lihong on 14-4-11.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import "SOAPClient.h"
#import "MWSResponse.h"

@class MUser;

@interface WSUser : SOAPClient

+ (void) registerWithUserName:(NSString *)userName
                  andPassword:(NSString *)password
                  phoneNumber:(NSString *)phoneNumber
                     nickname:(NSString *)nickname
                  onCompleted:(JSONModelObjectBlock)block;

+ (void) loginWithUserName:(NSString *)userName
               andPassword:(NSString *)password
               onCompleted:(JSONModelObjectBlock)block;

+ (void) userInfoWithUserName:(NSString *)userName
                  andPassword:(NSString *)password
                  onCompleted:(JSONModelObjectBlock)block;
@end
