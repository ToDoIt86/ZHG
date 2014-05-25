//
//  WSOrderService.h
//  ZHG
//
//  Created by lihong on 14-5-7.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import "SOAPClient.h"

@interface WSOrderService : NSObject
+ (void)createOrder:(NSString *)orderJsonString onCompleted:(JSONModelObjectBlock)block;

// 获取 个人中心.购物历史
+ (void)getOrdersByBuyerSn:(NSString *)buyersn
                     index:(NSString *)index
                      size:(NSString *)size
               onCompleted:(JSONModelObjectBlock)block;
@end
