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
#import "UIColor+RGB.h"
#import "FoodShopDetailVC.h"
#import "WSFoodShops.h"
#import "LHLocationManager.h"

static NSString *const kFoodShopsCellReusedId = @"FoodShopsCell";

@interface FoodShopsListVC ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *foodShopListTableView;
@property (strong, nonatomic) UITableView *dropView1,*dropView2,*dropView3,*dropView4;
@property (strong, nonatomic) NSArray *dropView1Items,*dropView2Items,*dropView3Items;
@property (strong, nonatomic) UIView *selectedCellBackgroundView1;
@property (strong, nonatomic) UIImageView *selectedCellBackgroundView2;
@property (strong, nonatomic) UIView *maskView;
@end

@implementation FoodShopsListVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"美食妙饮";
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
    
    SegmentedControl *firstSegmentedControl = [[SegmentedControl alloc] initWithItems:@[@"探店淘美食",@"人气美食"]];
    [firstSegmentedControl addTarget:self action:@selector(didSelectedSegmentedControl:) forControlEvents:UIControlEventValueChanged];
    [firstSegmentedControl setSCFrame:CGRectMake(0, 0, 320, 40)];
    [firstSegmentedControl removeAllIndicator];
    [self.view addSubview:firstSegmentedControl];
    
    SegmentedControl *secondSegmentedControl = [[SegmentedControl alloc] initWithItems:@[@"排序",@"附近",@"筛选"]];
    [secondSegmentedControl addTarget:self action:@selector(didSelectedSecondSegmentedControl:) forControlEvents:UIControlEventValueChanged];
    CGRect newRect = firstSegmentedControl.frame;
    newRect.origin.y += newRect.size.height;
    newRect.size.height *= 0.6;
    [secondSegmentedControl setSCFrame:newRect];
    [secondSegmentedControl hideIndicatorView:YES];
    [secondSegmentedControl setItemTitleFont:[UIFont systemFontOfSize:15]];
    [secondSegmentedControl setItemTitleColor:[UIColor blackColor]];
    //[secondSegmentedControl removeIndicatorAtIndex:0];
    [self.view addSubview:secondSegmentedControl];
    
    self.dropView1Items = @[@"离我最近",@"销量最好"];
    self.dropView2Items = @[@"附近",@"全贵阳",@"云岩区",@"南明区",@"白云区",@"花溪区"];
    self.dropView3Items = @[@"0.5km",@"1km",@"2km",@"3km",@"5km",@"10km"];
    CGFloat rowHeight = 30.0;
    
    newRect.origin.y+=newRect.size.height;
    newRect.size.width = newRect.size.width/3;
    newRect.size.height = rowHeight *self.dropView1Items.count + 30;
    self.dropView1 = [[UITableView alloc] initWithFrame:newRect];
    self.dropView1.rowHeight = rowHeight;
    self.dropView1.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.dropView1.backgroundColor = [UIColor r:242 g:242 b:242];
    self.dropView1.hidden = YES;
    self.dropView1.delegate = self;
    self.dropView1.dataSource = self;
    
    newRect.origin.x += newRect.size.width;
    newRect.size.height = rowHeight * self.dropView2Items.count + 10;
    self.dropView2 = [[UITableView alloc] initWithFrame:newRect];
    self.dropView2.rowHeight = rowHeight;
    self.dropView2.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.dropView2.backgroundColor = [UIColor r:250 g:250 b:250];
    self.dropView2.hidden = YES;
    self.dropView2.delegate = self;
    self.dropView2.dataSource = self;

    
    newRect.origin.x += newRect.size.width;
    newRect.size.height = rowHeight * self.dropView3Items.count + 10;
    self.dropView3 = [[UITableView alloc] initWithFrame:newRect];
    self.dropView3.rowHeight = rowHeight;
    self.dropView3.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.dropView3.backgroundColor = [UIColor r:242 g:242 b:242];
    self.dropView3.hidden = YES;
    self.dropView3.delegate = self;
    self.dropView3.dataSource = self;
    
    [self.view addSubview:self.dropView1];
    [self.view addSubview:self.dropView2];
    [self.view addSubview:self.dropView3];
    
    self.selectedCellBackgroundView1 = [UIView new];
    self.selectedCellBackgroundView1.backgroundColor = [UIColor r:232 g:93 b:80 a:0.8];
    self.selectedCellBackgroundView1.layer.cornerRadius = 13;
    
    UIImage *backgoundImage = [UIImage imageNamed:@"drop_view_cell_backgound"];
    backgoundImage = [backgoundImage resizableImageWithCapInsets:UIEdgeInsetsMake(8, 18, 8, 8)];
    self.selectedCellBackgroundView2 = [[UIImageView alloc] initWithImage:backgoundImage];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnMaskView)];
    self.maskView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.maskView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
    self.maskView.gestureRecognizers = @[tap];
    self.maskView.hidden = YES;
    [self.view insertSubview:self.maskView aboveSubview:self.foodShopListTableView];
    

    [WSFoodShops getGroupByClassid:20 pageIndex:0 coordinate:[LHLocationManager sharedInstance].coordinate order:@"全贵阳" onCompleted:NULL];
    
    [WSFoodShops getGroupByAreaId:@"全贵阳" pageSize:20 pageIndex:0 coordinate:[LHLocationManager sharedInstance].coordinate order:@"全贵阳" onCompleted:NULL];
    
    [WSFoodShops getGroupByDiscount:20 pageIndex:1 coordinate:[LHLocationManager sharedInstance].coordinate  onCompleted:NULL];
    
    [WSFoodShops getGroupBySales:20 pageIndex:0 coordinate:[LHLocationManager sharedInstance].coordinate  onCompleted:NULL];
    
    [WSFoodShops getNearGroupByDistance:20 pageIndex:0 coordinate:[LHLocationManager sharedInstance].coordinate  distance:100 onCompleted:NULL];
}

#pragma mark - Action
- (void)didSelectedSegmentedControl:(SegmentedControl *)segmentedControl
{
    
}

- (void)didSelectedSecondSegmentedControl:(SegmentedControl *)segmentedControl
{
    self.maskView.hidden = NO;
    
    if(segmentedControl.selectedIndex == 0)
    {
        self.dropView1.hidden = NO;
        self.dropView2.hidden = YES;
        self.dropView3.hidden = YES;
    }
    else if(segmentedControl.selectedIndex == 1)
    {
        self.dropView1.hidden = YES;
        self.dropView2.hidden = NO;
    }
    else
    {
        self.dropView1.hidden = YES;
        self.dropView2.hidden = YES;
        self.dropView3.hidden = YES;
    }
}

- (void)tapOnMaskView
{
    self.dropView2.hidden = YES;
    self.dropView1.hidden = YES;
    self.dropView3.hidden = YES;
    self.maskView.hidden  = YES;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == self.dropView1) return self.dropView1Items.count;
    if(tableView == self.dropView2) return self.dropView2Items.count;
    if(tableView == self.dropView3) return self.dropView3Items.count;
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    if(tableView == self.foodShopListTableView)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:kFoodShopsCellReusedId];
        return cell;
    }
    
    if(tableView == self.dropView1)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"DV1CID"];
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DV1CID"];
            cell.backgroundColor = [UIColor clearColor];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            cell.selectedBackgroundView = self.selectedCellBackgroundView1;
        }
        
        cell.textLabel.text = self.dropView1Items[indexPath.row];
        
        if(indexPath.row == 0) cell.selected = YES;
        
        return cell;
    }
    
    if(tableView == self.dropView2)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"DV2CID"];
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DV2CID"];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            cell.backgroundColor = [UIColor clearColor];
            cell.selectedBackgroundView = self.selectedCellBackgroundView2;
        }
        
        if(indexPath.row == 0) cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        cell.textLabel.text = self.dropView2Items[indexPath.row];
        
        if(indexPath.row == 0) cell.selected = YES;

        return cell;
    }
    
    if(tableView == self.dropView3)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"DV3CID"];
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DV3CID"];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            cell.backgroundColor = [UIColor clearColor];
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            cell.selectedBackgroundView = self.selectedCellBackgroundView1;
        }
        
        cell.textLabel.text = self.dropView3Items[indexPath.row];
        
        if(indexPath.row == 0) cell.selected = YES;

        return cell;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.foodShopListTableView)
    {
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
        FoodShopDetailVC *foodShopDetailVC = [[FoodShopDetailVC alloc] initWithNibName:@"FoodShopDetailVC" bundle:nil];
        [self.navigationController pushViewController:foodShopDetailVC animated:YES];
        return;
    }
    
    // 延迟0.2秒执行是为了看见下拉菜单被选中的效果
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if(tableView == self.dropView1)
        {
            self.dropView1.hidden = YES;
            self.maskView.hidden = YES;
            return;
        }
        
        if(tableView == self.dropView2)
        {
            if(indexPath.row == 0)
            {
                self.dropView3.hidden = NO;
            }
            else
            {
                self.dropView2.hidden = YES;
                self.dropView3.hidden = YES;
                self.maskView.hidden = YES;
            }
            return;
        }
        
        if(tableView == self.dropView3)
        {
            self.dropView2.hidden = YES;
            self.dropView3.hidden = YES;
            self.maskView.hidden = YES;
            
            return;
        }
    });
}
@end
