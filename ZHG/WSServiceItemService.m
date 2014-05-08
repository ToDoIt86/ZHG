//
//  WSFood.m
//  ZHG
//
//  Created by lihong on 14-5-1.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import "WSServiceItemService.h"
#import "Product.h"
#import "ProductDetail.h"
#import "ProductDetailTemplate.h"

static NSUInteger classId = 2;

@implementation WSServiceItemService

+ (void)indexTopis:(NSInteger)count
       onCompleted:(JSONModelObjectBlock)block
{
    NSDictionary *dict =@{@"count":@(count)};
    
    [SOAPClient requestFromURL:SOAPService(@"Ecommerce/ServiceItemService.asmx") soapAction:SOAPAction(@"IndexTopis") params:dict completion:^(NSString *jsonString, JSONModelError *err) {
        NSLog(@"%@",jsonString);
    }];
}

+ (void)getItemByCId:(NSUInteger)pageSize
           pageIndex:(NSUInteger)pageIndex
         onCompleted:(JSONModelObjectBlock)block
{
    NSDictionary *dict =@{@"classid"  :@(classId),
                          @"pagesize" :@(pageSize),
                          @"pageindex":@(pageIndex)};
    
    [SOAPClient requestFromURL:SOAPService(@"Ecommerce/ServiceItemService.asmx") soapAction:SOAPAction(@"GetItemByCId") params:dict completion:^(NSString *jsonString, JSONModelError *err) {
        ProductResponse *product = [[ProductResponse alloc] initWithString:jsonString error:nil];
        block(product, err);
    }];
}

+ (void)getItemByKey:(NSString *)keyWord
            pageSize:(NSUInteger)pageSize
           pageIndex:(NSUInteger)pageIndex
         onCompleted:(JSONModelObjectBlock)block
{
    NSDictionary *dict =@{@"keyword"  :keyWord,
                          @"pagesize" :@(pageSize),
                          @"pageindex":@(pageIndex)};
    
    [SOAPClient requestFromURL:SOAPService(@"Ecommerce/ServiceItemService.asmx") soapAction:SOAPAction(@"GetItemByKey") params:dict completion:^(NSString *jsonString, JSONModelError *err) {
        NSLog(@"%@",jsonString);
    }];
}

+ (void)getItem:(NSString *)itemsn
    onCompleted:(JSONModelObjectBlock)block
{
    NSDictionary *dict =@{@"itemsn":itemsn};
    
    [SOAPClient requestFromURL:SOAPService(@"Ecommerce/ServiceItemService.asmx") soapAction:SOAPAction(@"GetItem") params:dict completion:^(NSString *jsonString, JSONModelError *err) {
        ProductDetailResponse *response = [[ProductDetailResponse alloc] initWithString:jsonString error:nil];
        block(response, err);
    }];
}

+ (void)getItemBasicProperty:(NSString *)itemsn
                      usersn:(NSString *)usersn
                     groupsn:(NSString *)groupsn
                 onCompleted:(JSONModelObjectBlock)block
{
    NSDictionary *dict =@{@"itemsn":itemsn,@"usersn":usersn,@"groupsn":groupsn};
    
    [SOAPClient requestFromURL:SOAPService(@"Ecommerce/ServiceItemService.asmx") soapAction:SOAPAction(@"GetItemBasicProperty") params:dict completion:^(NSString *jsonString, JSONModelError *err) {
        ProductDetailResponse *response = [[ProductDetailResponse alloc] initWithString:jsonString error:nil];
        block(response, err);
    }];
}


+(void)getItemContents:(NSString *)itemsn
           onCompleted:(JSONModelObjectBlock)block
{
    NSDictionary *dict =@{@"itemsn":itemsn};
    
    [SOAPClient requestFromURL:SOAPService(@"Ecommerce/ServiceItemService.asmx") soapAction:SOAPAction(@"GetItemContents") params:dict completion:^(NSString *jsonString, JSONModelError *err) {
        ProductDetailTemplateResponse *response =
        [[ProductDetailTemplateResponse alloc] initWithString:jsonString error:nil];
        block(response, err);
    }];
}

+ (void)getItemProperties:(NSString *)itemsn
              onCompleted:(JSONModelObjectBlock)block
{
    
    NSDictionary *dict =@{@"itemsn":itemsn};
    
    [SOAPClient requestFromURL:SOAPService(@"Ecommerce/ServiceItemService.asmx") soapAction:SOAPAction(@"GetItemProperties") params:dict completion:^(NSString *jsonString, JSONModelError *err) {
        NSLog(@"%@",jsonString);
    }];
}

+ (void)getClassItem:(NSString *)order
            pageSize:(NSUInteger)pageSize
           pageIndex:(NSUInteger)pageIndex
         onCompleted:(JSONModelObjectBlock)block
{
    NSDictionary *dict =@{@"classid"  :@(classId),
                          @"order"    :order,
                          @"pagesize" :@(pageSize),
                          @"pageindex":@(pageIndex)};
    
    [SOAPClient requestFromURL:SOAPService(@"Ecommerce/ServiceItemService.asmx") soapAction:SOAPAction(@"GetClassItem") params:dict completion:^(NSString *jsonString, JSONModelError *err) {
        NSLog(@"%@",jsonString);
    }];
}

+ (void)addCollection:(NSString *)itemsn
          onCompleted:(JSONModelObjectBlock)block
{
    NSDictionary *dict = @{@"itemsn":itemsn};
    [SOAPClient requestFromURL:SOAPService(@"Ecommerce/ServiceItemService.asmx") soapAction:SOAPAction(@"AddCollection") params:dict completion:^(NSString *jsonString, JSONModelError *err) {
        MWSResponse *response = [[MWSResponse alloc] initWithString:jsonString error:nil];
        block(response, err);
    }];
}

+ (void)addShare:(NSString *)itemsn
     onCompleted:(JSONModelObjectBlock)block
{
    NSDictionary *dict = @{@"itemsn":itemsn};
    [SOAPClient requestFromURL:SOAPService(@"Ecommerce/ServiceItemService.asmx") soapAction:SOAPAction(@"AddShare") params:dict completion:^(NSString *jsonString, JSONModelError *err) {
        NSLog(@"%@",jsonString);
    }];
}

+ (void)getRecommend:(NSString *)groupsn
             classId:(NSString *)cID
         onCompleted:(JSONModelObjectBlock)block
{
    NSDictionary *dict = @{@"groupsn":groupsn,@"ClassID":cID,@"pageindex":@(1),@"pagesize":@(1000)};
    [SOAPClient requestFromURL:SOAPService(@"Ecommerce/ServiceItemService.asmx") soapAction:SOAPAction(@"GetRecommend") params:dict completion:^(NSString *jsonString, JSONModelError *err) {
        NSLog(@"%@",jsonString);
    }];
}

+ (void)getActivities_info:(NSString *)groupsn
               onCompleted:(JSONModelObjectBlock)block
{
    NSDictionary *dict = @{@"groupsn":groupsn,@"pageindex":@(1),@"pagesize":@(1000)};
    [SOAPClient requestFromURL:SOAPService(@"Ecommerce/ServiceItemService.asmx") soapAction:SOAPAction(@"GetActivities_info") params:dict completion:^(NSString *jsonString, JSONModelError *err) {
        NSLog(@"%@",jsonString);
    }];
}
@end
