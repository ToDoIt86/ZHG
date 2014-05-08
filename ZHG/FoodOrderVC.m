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
@property (weak, nonatomic) IBOutlet UITextField *amountTextField;
@property (weak, nonatomic) IBOutlet UIButton *subButton;
@property (weak, nonatomic) IBOutlet UIButton *addButton;



@property (strong, nonatomic) Product *productEntity;
@end

@implementation FoodOrderVC

- (id)initWithNibName:(NSString *)nibNameOrNil product:(Product *)product
{
    self = [super initWithNibName:nibNameOrNil bundle:nil];
    if (self)
    {
        self.title = @"提交订单";
        self.productEntity = product;
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
    if(self.amountTextField.text.integerValue == 0)
        self.amountTextField.text = @(1).description;
    
    [HUD showHUDInView:self.view title:@"请稍后"];
    
    NSString *orderJosnString = [NSString stringWithFormat:@"{\"itemsn\":\"%@\"}",self.productEntity.Itemsn];
    [WSOrderService createOrder:orderJosnString onCompleted:^(JSONModel *model, JSONModelError *err) {
        [HUD hideHUDForView:self.view];
        
        FoodOrderResponse *response = (FoodOrderResponse *)model;
        if(err || model == nil) [AlertView showWithMessage:@"提交失败"];
        else if(response.success == NO) [AlertView showWithMessage:response.message];
        else
        {
            [AlertView showWithMessage:@"提交成功" block:^(NSInteger buttonIndex) {
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }
    }];
}


- (IBAction)sub:(id)sender
{
    NSInteger value = self.amountTextField.text.integerValue;
    if(value == 1) return;
    self.amountTextField.text = @(--value).description;
}

- (IBAction)add:(id)sender
{
    self.amountTextField.enabled = YES;
    NSInteger value = self.amountTextField.text.integerValue;
    self.amountTextField.text = @(++value).description;
}

@end
