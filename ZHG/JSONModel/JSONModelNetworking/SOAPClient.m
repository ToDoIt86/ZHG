//
//  SOAPClient.m
//  ZHG
//
//  Created by lihong on 14-4-10.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import "SOAPClient.h"
#import "MWSResponse.h"

#define SOAPClientLog(message,url,action)\
{\
    NSString *msg = [NSString stringWithFormat:@"{\n\t\t%@ \n\t\tRequestURL:%@ \n\t\tSOAPAction:%@\n\t}",message,url,action];\
    LOG(msg);\
}


static dispatch_queue_t soapRequestQueue;

@implementation SOAPClient


+ (void) initialize
{
    soapRequestQueue = dispatch_queue_create("www.hmwj.com", DISPATCH_QUEUE_CONCURRENT);
    
}

+ (void)requestFromURL:(NSString *)url soapAction:(NSString *)soapAction params:(NSDictionary*)params completion:(SOAPRequestCallback)completeBlock
{
    dispatch_async(soapRequestQueue, ^{
        
        
        NSString *start = @"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\" ><soap:Header><HMWJSoapHeader xmlns=\"http://hmwj.com/\"><Uname>ANDROID</Uname><Password>e0cb3504743ab84bf4cb9aec60227907</Password></HMWJSoapHeader></soap:Header><soap:Body>";
        
        NSString *end = @"</soap:Body></soap:Envelope>";
        
        NSMutableString *middle = [NSMutableString new];
        NSArray *allKeys        = [params allKeys];
        
        for(NSString *key in allKeys){
            NSString *l       = [NSString stringWithFormat:@"<%@>",key];
            NSString *r       = [NSString stringWithFormat:@"</%@>",key];
            NSString *xmlNode = [NSString stringWithFormat:@"%@%@%@",l,[params objectForKey:key],r];
            [middle appendString:xmlNode];
        }
        
        JSONModelError* error = nil;
        NSData *responseData  = nil;
        NSURL *requstURL      = [NSURL URLWithString:url];
        NSDictionary *header  = @{@"SOAPAction":[soapAction copy]};
        NSString *soapMethod  = [[[NSURL URLWithString:soapAction] pathComponents] lastObject];
        NSString *soapMessage = [NSString stringWithFormat:@"%@<%@ xmlns=\"http://hmwj.com/\">%@</%@>%@",start,soapMethod,middle,soapMethod,end];
        NSData *soapMessageData = [soapMessage dataUsingEncoding:NSUTF8StringEncoding];
        
        @try {
            responseData =
            [JSONHTTPClient syncRequestDataFromURL:requstURL
                                            method:kHTTPMethodPOST
                                       requestBody:soapMessageData
                                           headers:header
                                              etag:nil
                                             error:&error];
        }
        @catch (NSException *exception) {
            SOAPClientLog(@"JSONHTTPClient 请求异常", url, soapAction);
            error = [JSONModelError errorBadResponse];
        }
    
        if(responseData && error == nil)
        {
            
            NSString *xmlString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
            NSString *jsonString = nil;
            if(xmlString == nil){
                SOAPClientLog(@"不能将服务器返回的数据转换为字符串", url, soapAction);
                goto GetJSONFail;
            }
            
            NSString *separator = [NSString stringWithFormat:@"<%@Result>",soapMethod];
            NSArray *component = [xmlString componentsSeparatedByString:separator];
            if(component.count == 0){
                SOAPClientLog(@"从xml字符串中查找json字符串时出错(1)", url, soapAction);
                goto GetJSONFail;
            }
            
            separator = [NSString stringWithFormat:@"</%@Result>",soapMethod];
            xmlString = [component lastObject];
            component = [xmlString componentsSeparatedByString:separator];
            if(component.count == 0){
                SOAPClientLog(@"从xml字符串中查找json字符串时出错(2)", url, soapAction);
                goto GetJSONFail;
            }
            
            jsonString = [component firstObject];
            component = [jsonString componentsSeparatedByString:@"Datas"];
            NSString *datas = [component objectAtIndex:1];
            if([datas isEqualToString:@"\":null}"]){
                jsonString = [NSString stringWithFormat:@"%@Datas\":%@",component[0],@"[]}"];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if(completeBlock){
                    completeBlock(jsonString, nil);
                }
            });
            
            return;
            
        }else{
            SOAPClientLog(@"不能从服务器获取数据", url, soapAction);
            error = [JSONModelError errorBadResponse];
        }

        GetJSONFail:
        dispatch_async(dispatch_get_main_queue(), ^{
            if(completeBlock){
                completeBlock(nil, error);
            }
        });
    });
}
@end
