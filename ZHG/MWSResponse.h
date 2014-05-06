//
//  MWSResponse.h
//  ZHG
//
//  Created by lihong on 14-4-8.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import "JSONModel.h"

@interface MWSResponse : JSONModel

@property (nonatomic, assign) BOOL success;
@property (nonatomic, strong) NSString *message;
//@property (nonatomic, strong) NSArray *datas;
@end
