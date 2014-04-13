//
//  MWSResponse.m
//  ZHG
//
//  Created by lihong on 14-4-8.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import "MWSResponse.h"

@implementation MWSResponse


+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
            @"Success":@"success",
            @"Message":@"message",
            @"Datas"  :@"datas"
    }];
}
@end
