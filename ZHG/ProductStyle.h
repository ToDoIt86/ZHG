//
//  ProductStyle.h
//  ZHG
//
//  Created by lihong on 14-5-3.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import "JSONModel.h"

// GetItemProperties接口返回的数据模型
@interface ProductStyle : JSONModel
@property (nonatomic, strong) NSString
*Proid,
*Prosn,
*Itemsn,
*Colors,
*Sizes,
*Price;
@end
