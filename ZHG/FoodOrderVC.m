//
//  FoodOrderVC.m
//  ZHG
//
//  Created by lihong on 14-5-7.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import "FoodOrderVC.h"
#import "TabBar.h"
#import "HUD.h"
#import "AlertView.h"
#import "FoodOrder.h"
#import "WSOrderService.h"

@interface FoodOrderVC ()
@property (weak, nonatomic) IBOutlet UIImageView *orderInfoBackgroundView;
@property (weak, nonatomic) IBOutlet UIImageView *phoneNumberInfoBackgroundView;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;
@property (weak, nonatomic) IBOutlet UIButton *submitOrderButton;

@end

@implementation FoodOrderVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"提交订单";
        self.edgesForExtendedLayout = UIRectEdgeLeft|UIRectEdgeRight;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImage *image = [[UIImage imageNamed:@"order_info_background"]
                      resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    [self.orderInfoBackgroundView setImage:image];
    [self.phoneNumberInfoBackgroundView setImage:image];
    
    image = [[UIImage imageNamed:@"order_submit_button"]
             resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    [self.submitOrderButton setBackgroundImage:image forState:UIControlStateNormal];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleTextFieldTextDidBeginEditingNotification)
                                                 name:UITextFieldTextDidBeginEditingNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleTextFieldTextDidEndEditingNotification)
                                                 name:UITextFieldTextDidEndEditingNotification
                                               object:nil];
    
}

- (void)handleTextFieldTextDidBeginEditingNotification
{
    [TabBar hide];
}

- (void)handleTextFieldTextDidEndEditingNotification
{
    [TabBar show];
}

- (IBAction)submitOrder:(UIButton *)sender
{
    [HUD showHUDInView:self.view title:@"请稍后"];
    [WSOrderService createOrder:@"{\"b\":2}" onCompleted:^(JSONModel *model, JSONModelError *err) {
        [HUD hideHUDForView:self.view];
        
        FoodOrderResponse *response = (FoodOrderResponse *)model;
        if(err || model == nil) [AlertView showWithMessage:@"提交失败"];
        else if(response.success == NO) [AlertView showWithMessage:response.message];
        else
        {
            
        }
    }];
}

@end
