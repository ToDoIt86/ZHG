//
//  WSHelpCenter.h
//  ZHG
//
//  Created by lihong on 14-5-20.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SOAPClient.h"

@interface WSHelpCenter : NSObject

// 帮助中心
+ (void)GetHelpObj:(NSString *)helpid
       OnCompleted:(JSONModelObjectBlock)block;

@end
