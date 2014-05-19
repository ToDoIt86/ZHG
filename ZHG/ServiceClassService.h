//
//  WSProductCategory.h
//  ZHG
//
//  Created by lihong on 14-4-28.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import "SOAPClient.h"

@interface ServiceClassService : NSObject
+ (void)getCategoryIdWithParentId:(NSInteger)parentId onCompleted:(JSONModelObjectBlock)block;
@end
