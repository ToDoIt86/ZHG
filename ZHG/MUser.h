//
//  MUser.h
//  ZHG
//
//  Created by lihong on 14-4-8.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import "JSONModel.h"
#import "MWSResponse.h"

@interface MUser : JSONModel
@property (nonatomic, strong) NSString <Optional>
*Infoid,
*Email,
*Phonenumber,
*Sex,
*Birthdate,
*Nickname,
*Concern,
*Praise,
*Lognum,
*Collection,
*Usertype,
*Istopman,
*Headpic,
*Jointime,
*Grade,
*Signature,
*Photo,
*Buyerid,
*Buyersn,
*Account,
*Pwd,
*Status,
*Regtime,
*QQ,
*Weixin,
*Sina_weibao,
*Baidu;
@end

@protocol  User
@end

@interface UserLoginResponse : MWSResponse
@property (nonatomic, strong) MUser *Datas;
@end

