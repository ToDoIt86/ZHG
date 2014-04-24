//
//  FoodShopsListVC.m
//  ZHG
//
//  Created by lihong on 14-4-11.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import "FoodShopsListVC.h"
#import "WSFoodShops.h"
#import "FoodShopsCell.h"

static NSString *const kFoodShopsCellReusedId = @"FoodShopsCell";

@interface FoodShopsListVC ()
// TopSegmentedControl, 简称 TCS.
@property (weak, nonatomic) IBOutlet UIView  *TSCBottomLine;
@property (weak, nonatomic) IBOutlet UILabel *TSCFirstItemLabel;
@property (weak, nonatomic) IBOutlet UILabel *TSCSecondItemLabel;
@property (weak, nonatomic) IBOutlet UIView  *TopSegmentedControl;
@property (strong, nonatomic) UIColor *TSCSelectedColor,*TSCNormalColor;
@property (assign, nonatomic) CGFloat TSCAnimationDuration;

@property (weak, nonatomic) IBOutlet UITableView *foodShopListTableView;

@end

@implementation FoodShopsListVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.TSCAnimationDuration = 0.15;
    self.TSCSelectedColor = self.TSCFirstItemLabel.textColor;
    self.TSCNormalColor   = self.TSCSecondItemLabel.textColor;
    
    
    [self.foodShopListTableView registerNib:[UINib nibWithNibName:@"FoodShopsCell" bundle:nil]
                     forCellReuseIdentifier:kFoodShopsCellReusedId];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - TopSegmentedControl

- (IBAction)selectedTSCFirstItem:(UIButton *)sender
{
    self.TSCFirstItemLabel.textColor   = self.TSCSelectedColor;
    self.TSCSecondItemLabel.textColor = self.TSCNormalColor;
    
    [UIView animateWithDuration:self.TSCAnimationDuration animations:^{
        CGFloat leftCenter = self.TopSegmentedControl.bounds.size.width/4;
        self.TSCBottomLine.center = CGPointMake(leftCenter, self.TSCBottomLine.center.y);
    }];
}

- (IBAction)selectedTSCSecondItem:(UIButton *)sender
{
    self.TSCFirstItemLabel.textColor   = self.TSCNormalColor;
    self.TSCSecondItemLabel.textColor = self.TSCSelectedColor;
    
    [UIView animateWithDuration:self.TSCAnimationDuration animations:^{
        CGFloat rightCenter = (self.TopSegmentedControl.bounds.size.width/4)*3;
        self.TSCBottomLine.center = CGPointMake(rightCenter, self.TSCBottomLine.center.y);
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FoodShopsCell *cell = [tableView dequeueReusableCellWithIdentifier:kFoodShopsCellReusedId];
    return cell;
}
@end
