//
//  WSAdService.h
//  ZHG
//
//  Created by lihong on 14-5-19.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import "SOAPClient.h"

@interface WSAdService : NSObject


+ (void) getIndexAdOnCompleted:(JSONModelObjectBlock)block;

+ (void) getIndexBottomAdOnCompleted:(JSONModelObjectBlock)block;

@end
