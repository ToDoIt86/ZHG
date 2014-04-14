//
//  SOAPClient.h
//  ZHG
//
//  Created by lihong on 14-4-10.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import "JSONHTTPClient.h"

#define SOAPService(servicePath)\
[NSString stringWithFormat:@"http://hyxx.nat123.net/HMWJservices/%@",servicePath]

#define SOAPAction(method)\
[NSString stringWithFormat:@"http://hmwj.com/%@",method]


typedef void (^JSONModelObjectBlock)(id jsonString, JSONModelError* err);

@interface SOAPClient : JSONHTTPClient

+ (void)requestFromURL:(NSString *)url soapAction:(NSString *)soapAction params:(NSDictionary*)params completion:(JSONModelObjectBlock)completeBlock;

@end
