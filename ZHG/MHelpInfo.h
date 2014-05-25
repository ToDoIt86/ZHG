//
//  MHelpInfo.h
//  ZHG
//
//  Created by lihong on 14-5-25.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import "JSONModel.h"
#import "MWSResponse.h"

@interface MHelpInfo : JSONModel
@property (nonatomic, strong) NSString<Optional>
*Helpid,
*Hcolumncode,
*Htitle,
*Hauthor,
*Htimes,
*Hcontent,
*Hflag,
*Authorname;
@end

@protocol MHelpInfo
@end

@interface MHelpInfoResponse : MWSResponse
@property (nonatomic, strong) NSArray<MHelpInfo> *Datas;
@end