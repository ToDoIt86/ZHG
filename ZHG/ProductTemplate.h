//
//  ProductTemplate.h
//  ZHG
//
//  Created by lihong on 14-5-3.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import "JSONModel.h"

// GetItemContents 接口返回的数据模型
@interface ProductTemplate : JSONModel
@property (nonatomic, strong) NSString
*Contentid,
*Itemsn,
*Itemcontent,
*Itemsort,
*Contentmodel,
*Times,
*Author;
@end
