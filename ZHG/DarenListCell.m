//
//  DarenListCell.m
//  ZHG
//
//  Created by lihong on 14-5-27.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import "DarenListCell.h"

@implementation DarenListCell

- (void)awakeFromNib
{
    self.avatarImageView.layer.cornerRadius = self.avatarImageView.bounds.size.height/2.0;
    self.avatarImageView.layer.borderWidth = 2.0;
    self.avatarImageView.layer.borderColor = [UIColor grayColor].CGColor;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
