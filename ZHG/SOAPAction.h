//
//  SOAPAction.h
//  ZHG
//
//  Created by lihong on 14-4-12.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SOAPAction : NSObject

+ (SOAPAction *)shared;

@property (nonatomic, readonly) NSString *userLogin;
@end
