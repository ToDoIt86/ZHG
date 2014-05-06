//
//  FoodShop.h
//  ZHG
//
//  Created by lihong on 14-5-3.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import "JSONModel.h"
#import "MWSResponse.h"

// 
@interface FoodShop : JSONModel
@property (nonatomic, strong) NSString<Optional>
*Columnid,
*Groupsn,
*Groupname,
*Grouptype,
*Shortname,
*Status,
*Sort,
*Tvshow,
*Mbshow,
*Showindex,
*Skin,
*Groupno,
*Areacode,
*Address,
*Legalperson,
*Linkman,
*Telephone,
*Groupico,
*Email,
*Fax,
*Times,
*Intro,
*Longitude,
*Latitude,
*Issmscode,
*Smsnumber,
*Grouptypename,
*Distance,
*company_type,
*Discountinfo,
*Activities_info,
*Collection,
*Share,
*Wireless,
*Parking;
@end

@protocol FoodShop
@end

@interface FoodShopResponse: MWSResponse
@property (nonatomic, strong) NSArray<FoodShop> *Datas;
@end
