//
//  SOAPClient.h
//  ZHG
//
//  Created by lihong on 14-4-10.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import "JSONHTTPClient.h"



@interface SOAPClient : JSONHTTPClient

+ (void)requestFromURL:(NSString *)url soapAction:(NSString *)soapAction params:(NSDictionary*)params completion:(JSONObjectBlock)completeBlock;

@end
