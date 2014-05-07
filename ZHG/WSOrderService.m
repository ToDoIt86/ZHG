//
//  WSOrderService.m
//  ZHG
//
//  Created by lihong on 14-5-7.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import "WSOrderService.h"
#import "FoodOrder.h"

@implementation WSOrderService

+ (void)createOrder:(NSString *)orderJsonString onCompleted:(JSONModelObjectBlock)block
{
    NSDictionary *dict = @{@"orderJsonStr":orderJsonString};
    [SOAPClient requestFromURL:SOAPService(@"ecommerce/OrderService.asmx") soapAction:SOAPAction(@"CreateOrder") params:dict completion:^(NSString *jsonString, JSONModelError *err) {
        FoodOrderResponse *response = [[FoodOrderResponse alloc] initWithString:jsonString error:nil];
        block(response, err);
    }];
}
@end
