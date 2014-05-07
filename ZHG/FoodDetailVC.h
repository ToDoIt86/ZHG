//
//  FoodShopDetailVC.h
//  ZHG
//
//  Created by lihong on 14-4-29.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import "BaseVC.h"

@class Product;
@interface FoodDetailVC : BaseVC

- (id)initWithNibName:(NSString *)nibNameOrNil productNumber:(Product *)product;
@end
