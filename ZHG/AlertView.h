//
//  AlertView.h
//  ZHG
//
//  Created by lihong on 14-4-16.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^AlertViewBlock)(NSInteger buttonIndex);

@interface AlertView : UIAlertView<UIAlertViewDelegate>

+ (void)showWithMessage:(NSString *)message;

+ (void)showWithMessage:(NSString *)message block:(AlertViewBlock)block;

+ (void)showWithTitle:(NSString *)title
              message:(NSString *)message
              buttons:(NSArray *)titles
                block:(AlertViewBlock)block;

@end
