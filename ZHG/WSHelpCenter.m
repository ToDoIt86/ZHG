//
//  WSHelpCenter.m
//  ZHG
//
//  Created by lihong on 14-5-20.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import "WSHelpCenter.h"
#import "SOAPClient.h"
#import "MHelpInfo.h"

@implementation WSHelpCenter

+ (void)GetHelpObj:(NSString *)helpid
       OnCompleted:(JSONModelObjectBlock)block
{
    NSDictionary *dict = @{@"helpid":helpid};
    
    [SOAPClient requestFromURL:SOAPService(@"basic/HelpCenterService.asmx") soapAction:SOAPAction(@"GetHelpObj") params:dict completion:^(NSString *jsonString, JSONModelError *err) {
        MHelpInfoResponse *r = [[MHelpInfoResponse alloc] initWithString:jsonString error:nil];
        block(r,err);
    }];
}
@end
