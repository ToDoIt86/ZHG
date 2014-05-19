//
//  WSUserService.h
//  ZHG
//
//  Created by lihong on 14-5-7.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import "SOAPClient.h"

@class MUser;

@interface WSUserService : NSObject

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

// 首页.推荐达人. type的值由getTopman方法返回
+ (void) getTopManUserType:(NSString *)type
                     order:(NSString *)order
                     index:(NSString *)index
                      size:(NSString *)size
               onCompleted:(JSONModelObjectBlock)block;

// 获取达人类型
+ (void)getTopManClassWithParentId:(NSString *)parentId
                       onCompleted:(JSONModelObjectBlock)block;

// 个人中心.用户积分
+ (void)getUserScoreWithUsersn:(NSString *)usersn
                   onCompleted:(JSONModelObjectBlock)block;

// 个人中心.修改用户信息. userInfo为getUserInfo接口返回的用户对象
+ (void)updateUserInfo:(NSString *)userInfo
           onCompleted:(JSONModelObjectBlock)block;


// 个人中心.地址信息
+ (void)getBuyerAddress:(NSString *)account
            onCompleted:(JSONModelObjectBlock)block;

// 个人中心.修改地址
+ (void)SOUBuyerAddress:(NSString *)address
            onCompleted:(JSONModelObjectBlock)block;

@end
