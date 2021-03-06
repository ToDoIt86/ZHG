//
//  ProductDetailTemplate.m
//  ZHG
//
//  Created by lihong on 14-5-8.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import "ProductDetailTemplate.h"

@implementation ProductDetailTemplate
- (NSArray *)getTemplateData
{
    NSArray *array = [self.Itemcontent componentsSeparatedByString:@"{$|$}"];
    NSMutableArray *newArray = [NSMutableArray arrayWithCapacity:array.count];
    
    for(NSUInteger i = 0; i < array.count;i++)
    {
        if(([self.Contentmodel isEqualToString:@"model4"] ||
            [self.Contentmodel isEqualToString:@"model5"] ||
            [self.Contentmodel isEqualToString:@"model6"] )&&
            i == array.count -1)
        {
            [newArray addObject:array[i]];
        }
        else
        {
            NSString *str =
            [NSString stringWithFormat:@"http://hyxx.nat123.net%@",array[i]];
            [newArray addObject:str];
        }
    }
   
    return newArray;
}
@end

@implementation ProductDetailTemplateResponse
@end