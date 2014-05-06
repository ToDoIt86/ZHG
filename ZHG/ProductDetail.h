//
//  ProductDetail.h
//  ZHG
//
//  Created by lihong on 14-5-3.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import "JSONModel.h"
#import "Product.h"
#import "MWSResponse.h"

//GetItem,GetItemBasicProperty,GetClassItem,GetRecommend,GetActivities_info接口返回的数据模型
@interface ProductDetail : JSONModel
@property(nonatomic, strong) NSString<Optional>
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
*click,
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

@interface ProductDetailResponse : MWSResponse
@property (nonatomic, strong) ProductDetail *Datas;
@end