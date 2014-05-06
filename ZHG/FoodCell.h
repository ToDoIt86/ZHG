//
//  FoodShopsCell.h
//  ZHG
//
//  Created by lihong on 14-4-14.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *previewImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfBuyerLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfCollectionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *wifiIconImageView;
@property (weak, nonatomic) IBOutlet UIImageView *parkingIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end
