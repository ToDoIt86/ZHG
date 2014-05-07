//
//  WSOrderService.h
//  ZHG
//
//  Created by lihong on 14-5-7.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import "SOAPClient.h"

@interface WSOrderService : SOAPClient
+ (void)createOrder:(NSString *)orderJsonString onCompleted:(JSONModelObjectBlock)block;
@end
