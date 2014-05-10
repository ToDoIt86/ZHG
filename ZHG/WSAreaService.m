//
//  WSAreaService.m
//  ZHG
//
//  Created by lihong on 14-5-10.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import "WSAreaService.h"

@implementation WSAreaService
+ (void)getChildAraeByCodeOnCompleted:(JSONModelObjectBlock)block
{
    NSDictionary *dict = @{@"areaCode":@(520000)};
    [SOAPClient requestFromURL:SOAPService(@"basic/AreaService.asmx") soapAction:SOAPAction(@"GetChildAraeByCode") params:dict completion:^(NSString *jsonString, JSONModelError *err) {
        
    }];
}
@end
