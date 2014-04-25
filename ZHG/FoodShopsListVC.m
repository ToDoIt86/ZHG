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
#import "SegmentedControl.h"

static NSString *const kFoodShopsCellReusedId = @"FoodShopsCell";

@interface FoodShopsListVC ()

@property (weak, nonatomic) IBOutlet UITableView *foodShopListTableView;

@end

@implementation FoodShopsListVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.edgesForExtendedLayout = UIRectEdgeLeft|UIRectEdgeRight;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.foodShopListTableView registerNib:[UINib nibWithNibName:@"FoodShopsCell" bundle:nil]
                     forCellReuseIdentifier:kFoodShopsCellReusedId];
    
    SegmentedControl *segmentedControl = [[SegmentedControl alloc] initWithItems:@[@"影讯VS",@"小资生活馆",@"休闲娱乐"]];
    [segmentedControl addTarget:self action:@selector(test:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentedControl];
}

- (void)test:(SegmentedControl *)s
{
    NSLog(@"Index:%d",s.selectedIndex);
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
