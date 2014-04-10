//
//  SOAPClient.m
//  ZHG
//
//  Created by lihong on 14-4-10.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import "SOAPClient.h"

static dispatch_queue_t soapRequestQueue;

@implementation SOAPClient

+ (void) initialize
{
    soapRequestQueue = dispatch_queue_create("www.hmwj.com", DISPATCH_QUEUE_CONCURRENT);
    
}

+ (void)requestFromURL:(NSString *)url soapAction:(NSString *)soapAction params:(NSDictionary*)params completion:(JSONObjectBlock)completeBlock
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
        
        NSURL *soapActionURL = [NSURL URLWithString:soapAction];
        NSString *soapMethod = [[soapActionURL pathComponents] lastObject];
        
        JSONModelError* error = nil;
        NSData *responseData  = nil;
        NSURL *requstURL      = [NSURL URLWithString:url];
        NSDictionary *header  = @{@"SOAPAction":[soapAction copy]};
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
            error = [JSONModelError errorBadResponse];
        }
    
        if(responseData == nil || error)  error = [JSONModelError errorBadResponse];
        
        NSString *xmlString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        NSString *jsonString = nil;
       
        if(xmlString){
            
            NSString *separator = [NSString stringWithFormat:@"<%@Result>",soapMethod];
            NSArray *component = [xmlString componentsSeparatedByString:separator];
            if(component.count == 0) goto GetJSONFail;
            
            separator = [NSString stringWithFormat:@"</%@Result>",soapMethod];
            xmlString = [component lastObject];
            component = [xmlString componentsSeparatedByString:@"<"];
            if(component.count == 0) goto GetJSONFail;
            
            jsonString = [component firstObject];
            if(completeBlock) completeBlock(jsonString, error);
            return;
        }
        
        GetJSONFail:
        if(completeBlock) completeBlock(jsonString, error);
    });
}
@end
