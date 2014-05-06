//
//  Product.h
//  ZHG
//
//  Created by lihong on 14-5-3.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import "JSONModel.h"
#import "MWSResponse.h"

// IndexTopis,GetItemByCId,GetItemByKey接口返回的数据模型
@interface Product : JSONModel
@property (nonatomic, strong) NSString<Optional>
*Serviceitemid,
*Itemsn,
*Groupsn,
*Userid,
*Classid,
*Serviceitem,
*Itemimage,
*Itemintro,
*Itemcontent,
*Activities_info,
*Standardprice,
*Discountprice,
*Discount,
*Times,
*Iscommon,
*Isused,
*Remark,
*Areacode,
*Groupname,
*Address,
*Telephone,
*Longitude,
*Latitude,
*Collection,
*Share,
*Sales,
*click;

@end

@protocol Product
@end

@interface ProductResponse: MWSResponse
@property (nonatomic, strong) NSArray<Product> *Datas;
@end
