//
//  ProductDetailTemplate.h
//  ZHG
//
//  Created by lihong on 14-5-8.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import "JSONModel.h"
#import "MWSResponse.h"

@interface ProductDetailTemplate : JSONModel
@property (nonatomic, strong) NSString<Optional>
*Contentid,
*Itemsn,
*Itemcontent,
*Itemsort,
*Contentmodel,
*Times,
*Author;

- (NSArray *)getTemplateData;
@end


@protocol ProductDetailTemplate
@end

@interface ProductDetailTemplateResponse : MWSResponse
@property (nonatomic, strong) NSArray<ProductDetailTemplate> *Datas;
@end