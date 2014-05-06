//
//  HUD.h
//  ZHG
//
//  Created by lihong on 14-4-16.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import "MBProgressHUD.h"

@interface HUD : NSObject  
+ (void)showHUDInView:(UIView *)view title:(NSString *)title;
+ (void)hideHUDForView:(UIView *)view;
@end
