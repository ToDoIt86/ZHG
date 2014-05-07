//
//  FoodOrder.h
//  ZHG
//
//  Created by lihong on 14-5-7.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import "JSONModel.h"

@interface FoodOrder : JSONModel
@property (nonatomic, strong) NSString<Optional>
*Orderid,
*Ordersn,
*Chkcode,
*Isused,
*Groupsn,
*Itemsn,
*Counts,
*Buyersn,
*Ordertimes,
*Paytimes,
*Ispay,
*Orderstatus,
*Prosn,
*Addrsn,
*Clienttype,
*Exinfo,
*Remarke,
*Serviceitem,
*Orderforusername,
*Itemimage,
*Itemintro,
*Discountprice,
*Itemcontent,
*Serviceitemname,
*Discount,
*Groupname;
@end

#import "MWSResponse.h"

@protocol FoodOrder
@end

@interface FoodOrderResponse : MWSResponse
@property (nonatomic, strong) NSArray<FoodOrder> *Datas;
@end
