//
//  WSAreaService.h
//  ZHG
//
//  Created by lihong on 14-5-10.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import "SOAPClient.h"

@interface WSAreaService : SOAPClient
+(void)getChildAraeByCodeOnCompleted:(JSONModelObjectBlock)block;
@end
