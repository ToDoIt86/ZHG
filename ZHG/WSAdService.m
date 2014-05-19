//
//  WSAdService.m
//  ZHG
//
//  Created by lihong on 14-5-19.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import "WSAdService.h"

@implementation WSAdService

+ (void) getIndexAdOnCompleted:(JSONModelObjectBlock)block
{
    [SOAPClient requestFromURL:SOAPService(@"￼￼￼￼￼ecommerce/AdService.asmx")
                    soapAction:SOAPAction(@"getIndexAd")
                        params:nil
                    completion:^(NSString *jsonString, JSONModelError *err) {
        
    }];
}

+ (void)getIndexBottomAdOnCompleted:(JSONModelObjectBlock)block
{
    [SOAPClient requestFromURL:SOAPService(@"￼￼￼￼￼ecommerce/AdService.asmx")
                    soapAction:SOAPAction(@"getIndexBottomAD")
                        params:nil
                    completion:^(NSString *jsonString, JSONModelError *err) {
        
    }];
}
@end
