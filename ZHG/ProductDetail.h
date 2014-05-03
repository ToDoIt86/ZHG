//
//  ProductDetail.h
//  ZHG
//
//  Created by lihong on 14-5-3.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import "JSONModel.h"
#import "Product.h"

//GetItem,GetItemBasicProperty,GetClassItem,GetRecommend,GetActivities_info接口返回的数据模型
@interface ProductDetail : Product
@property(nonatomic, strong) NSString
*Recommend,
*Indiscount,
*Filmarea,
*Screenwriter,
*Actors,
*Category,
*Releasetime,
*Filmtime,
*Purchasenotes;
@end
