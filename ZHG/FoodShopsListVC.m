//
//  FoodShopsListVC.m
//  ZHG
//
//  Created by lihong on 14-4-11.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import "FoodShopsListVC.h"
#import "FoodShopsCell.h"
#import "SegmentedControl.h"
#import "UIColor+RGB.h"
#import "FoodShopDetailVC.h"
#import "WSGroupService.h"
#import "WSServiceItemService.h"
#import "LHLocationManager.h"
#import "FoodDetailVC.h"
#import "HUD.h"
#import "FoodShop.h"
#import "AlertView.h"
#import "UIImageView+WebCache.h"
#import "FoodCell.h"
#import "Product.h"
#import "SVPullToRefresh.h"

#define kDefualtPageSize 5

@interface FoodShopsListVC ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *foodShopListTableView;
@property (strong, nonatomic) UITableView *dropView1,*dropView2,*dropView3,*dropView4;
@property (strong, nonatomic) NSArray *dropView1Items,*dropView2Items,*dropView3Items;
@property (strong, nonatomic) UIView *selectedCellBackgroundView1;
@property (strong, nonatomic) UIImageView *selectedCellBackgroundView2;
@property (strong, nonatomic) UIView *maskView;
@property (assign, nonatomic) NSInteger firstSegmentedControlSelectedIndex;
@property (strong, nonatomic) FoodShopResponse *foodShopDataModel;
@property (strong, nonatomic) ProductResponse *productDataModel;
@property (assign, nonatomic) NSInteger pageSize;
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
    self.pageSize = kDefualtPageSize;
    
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
    CGFloat rowHeight = 44.0;
    
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
    
    newRect.origin.x -= newRect.size.width;
    newRect.size.width *= 2;
    self.dropView4 = [[UITableView alloc] initWithFrame:newRect];
    self.dropView4.rowHeight = rowHeight;
    self.dropView4.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.dropView4.backgroundColor = [UIColor r:242 g:242 b:242];
    self.dropView4.hidden = YES;
    self.dropView4.delegate = self;
    self.dropView4.dataSource = self;
    
    [self.view addSubview:self.dropView1];
    [self.view addSubview:self.dropView2];
    [self.view addSubview:self.dropView3];
    [self.view addSubview:self.dropView4];
    
    self.selectedCellBackgroundView1 = [UIView new];
    self.selectedCellBackgroundView1.backgroundColor = [UIColor clearColor];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(5, 8, self.dropView1.bounds.size.width-10, rowHeight-16)];
    view.backgroundColor = [UIColor r:232 g:93 b:80 a:0.8];
    view.layer.cornerRadius = view.bounds.size.height/2.0;
    [self.selectedCellBackgroundView1 addSubview:view];
    
    UIImage *backgoundImage = [UIImage imageNamed:@"drop_view_cell_backgound"];
    backgoundImage = [backgoundImage resizableImageWithCapInsets:UIEdgeInsetsMake(8, 18, 8, 8)];
    self.selectedCellBackgroundView2 = [[UIImageView alloc] initWithImage:backgoundImage];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnMaskView)];
    self.maskView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.maskView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
    self.maskView.gestureRecognizers = @[tap];
    self.maskView.hidden = YES;
    [self.view insertSubview:self.maskView aboveSubview:self.foodShopListTableView];
    
    [self refreshFoodShopsList];
    
    [self.foodShopListTableView addPullToRefreshWithActionHandler:^{
        _firstSegmentedControlSelectedIndex == 0 ? [self refreshFoodShopsList] : [self refreshFoodList];
    } position:SVPullToRefreshPositionBottom];
}

#pragma mark - Action
- (void)didSelectedSegmentedControl:(SegmentedControl *)segmentedControl
{
    [self tapOnMaskView];
    self.pageSize = kDefualtPageSize;
    self.firstSegmentedControlSelectedIndex = segmentedControl.selectedIndex;

    if(segmentedControl.selectedIndex == 0) [self refreshFoodShopsList];
    else [self refreshFoodList];
}

- (void)didSelectedSecondSegmentedControl:(SegmentedControl *)segmentedControl
{
    self.maskView.hidden = NO;
    
    if(segmentedControl.selectedIndex == 0)
    {
        self.dropView1.hidden = NO;
        self.dropView2.hidden = YES;
        self.dropView3.hidden = YES;
        self.dropView4.hidden = YES;
    }
    else if(segmentedControl.selectedIndex == 1)
    {
        self.dropView2.hidden = NO;
        self.dropView1.hidden = YES;
        self.dropView4.hidden = YES;
    }else if(segmentedControl.selectedIndex == 2)
    {
        self.dropView4.hidden = NO;
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
    self.dropView4.hidden = YES;
    self.maskView.hidden  = YES;
}

- (void)switchControlValueChanged:(UISwitch *)sender
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self tapOnMaskView];
    });
    
    if(sender.on)
    {
        if(self.firstSegmentedControlSelectedIndex == 0) [self loadFoodShopByDiscount];
    }
    else
    {
        if(self.firstSegmentedControlSelectedIndex == 0) [self refreshFoodShopsList];
        else [self refreshFoodList];
    }
}
#pragma mark -  获取数据

- (void)refreshFoodShopsList
{
    [HUD showHUDInView:self.view title:@"加载中.."];
    
    [WSGroupService getGroupByClassid:self.pageSize pageIndex:1 coordinate:[LHLocationManager sharedInstance].coordinate order:@"groupid" onCompleted:^(JSONModel *model, JSONModelError* err){
        [HUD hideHUDForView:self.view];
        [self.foodShopListTableView.pullToRefreshView stopAnimating];

        self.foodShopDataModel  = (FoodShopResponse *)model;
        if(err || model == nil) [AlertView showWithMessage:@"加载数据失败"];
        else if(self.foodShopDataModel.success == NO) [AlertView showWithMessage:self.foodShopDataModel.message];
        else
        {
            self.pageSize *= 2;
            [self.foodShopListTableView reloadData];
        }
    }];
}

- (void)refreshFoodList
{
    [HUD showHUDInView:self.view title:@"加载中.."];
    
    [WSServiceItemService getItemByCId:self.pageSize pageIndex:1 onCompleted:^(JSONModel *model, JSONModelError *err) {
        [HUD hideHUDForView:self.view];
        [self.foodShopListTableView.pullToRefreshView stopAnimating];

        self.productDataModel = (ProductResponse *)model;
        if(err || model == nil) [AlertView showWithMessage:@"获取数据失败"];
        else if(self.productDataModel.success == NO) [AlertView showWithMessage:self.productDataModel.message];
        else
        {
            self.pageSize *= 2;
            [self.foodShopListTableView reloadData];
        }
    }];
}

// 离我最近商家
- (void)loadNearbyFoodShop
{
    [HUD showHUDInView:self.view title:@"加载中.."];
    [WSGroupService getNearGroupByClassid:100 pageIndex:1 coordinate:[LHLocationManager sharedInstance].coordinate onCompleted:^(JSONModel *model, JSONModelError *err) {
        [HUD hideHUDForView:self.view];
        self.foodShopDataModel  = (FoodShopResponse *)model;
        
        if(err || model == nil) [AlertView showWithMessage:@"加载数据失败"];
        else if(self.foodShopDataModel.success == NO) [AlertView showWithMessage:self.foodShopDataModel.message];
        else [self.foodShopListTableView reloadData];
    }];
}

// 销量最好商家
- (void)loadBestSalesFoodShop
{
    [HUD showHUDInView:self.view title:@"加载中.."];
    [WSGroupService getGroupBySales:100 pageIndex:1 coordinate:[LHLocationManager sharedInstance].coordinate onCompleted:^(JSONModel *model, JSONModelError *err) {
        [HUD hideHUDForView:self.view];
        self.foodShopDataModel  = (FoodShopResponse *)model;
        
        if(err || model == nil) [AlertView showWithMessage:@"加载数据失败"];
        else if(self.foodShopDataModel.success == NO) [AlertView showWithMessage:self.foodShopDataModel.message];
        else [self.foodShopListTableView reloadData];
    }];
}

- (void)loadFoodShopByAreaWithIndex:(NSIndexPath *)indexPath
{
    [HUD showHUDInView:self.view title:@"加载中.."];
    //520104是乌当区得编号，这里但白云区使用。因为接口(WSAreaService)没有返回白云区的数据
    NSInteger areaCodes[5] = {520100,520103,520102,520104,520105};
    NSInteger areaCode = areaCodes[indexPath.row];
    [WSGroupService getGroupByAreaId:@(areaCode) pageSize:100 pageIndex:1 coordinate:[LHLocationManager sharedInstance].coordinate order:@"groupid" onCompleted:^(JSONModel *model, JSONModelError *err) {
         [HUD hideHUDForView:self.view];
         self.foodShopDataModel  = (FoodShopResponse *)model;
        
         if(err || model == nil) [AlertView showWithMessage:@"加载数据失败"];
         else if(self.foodShopDataModel.success == NO) [AlertView showWithMessage:self.foodShopDataModel.message];
         else [self.foodShopListTableView reloadData];
    }];

}

- (void)loadFoodShopByDistanceWithIndex:(NSIndexPath *)indexPath
{
    [HUD showHUDInView:self.view title:@"加载中.."];
    CGFloat distanceArgs[] = {0.5,1,2,3,5,10};
    
    [WSGroupService getNearGroupByDistance:100 pageIndex:1 coordinate:[LHLocationManager sharedInstance].coordinate distance:distanceArgs[indexPath.row] onCompleted:^(JSONModel *model, JSONModelError *err) {
       [HUD hideHUDForView:self.view];
       self.foodShopDataModel  = (FoodShopResponse *)model;
        
       if(err || model == nil) [AlertView showWithMessage:@"加载数据失败"];
       else if(self.foodShopDataModel.success == NO) [AlertView showWithMessage:self.foodShopDataModel.message];
       else [self.foodShopListTableView reloadData];
   }];

}

- (void)loadFoodShopByDiscount
{
    
    [HUD showHUDInView:self.view title:@"加载中.."];
    [WSGroupService getGroupByDiscount:100 pageIndex:1 coordinate:[LHLocationManager sharedInstance].coordinate onCompleted:^(JSONModel *model, JSONModelError *err) {
        [HUD hideHUDForView:self.view];
        self.productDataModel = (ProductResponse *)model;
        
        if(err || model == nil) [AlertView showWithMessage:@"获取数据失败"];
        else if(self.productDataModel.success == NO) [AlertView showWithMessage:self.productDataModel.message];
        else [self.foodShopListTableView reloadData];
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == self.dropView1) return self.dropView1Items.count;
    if(tableView == self.dropView2) return self.dropView2Items.count;
    if(tableView == self.dropView3) return self.dropView3Items.count;
    if(tableView == self.dropView4) return 1;
    
    if(self.firstSegmentedControlSelectedIndex == 0) return self.foodShopDataModel.Datas.count;
    if(self.firstSegmentedControlSelectedIndex == 1) return self.productDataModel.Datas.count;
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    if(tableView == self.foodShopListTableView)
    {
        if(self.firstSegmentedControlSelectedIndex == 0)
        {
            FoodShopsCell *shopCell = [tableView dequeueReusableCellWithIdentifier:@"FoodShopsCell"];
            if(shopCell == nil)
            {
                UINib *nib = [UINib nibWithNibName:@"FoodShopsCell" bundle:nil];
                shopCell = [[nib instantiateWithOwner:nil options:nil] objectAtIndex:0];
            }
            
            FoodShop *shopEntity = nil;
            @try {
                shopEntity = self.foodShopDataModel.Datas[indexPath.row];
            }
            @catch (NSException *exception) {
                NSLog(@"%@",exception.description);
            }
         
            shopCell.nameLabel.text = shopEntity.Groupname;
            shopCell.wifiIconImageView.hidden = !shopEntity.Wireless.boolValue;
            shopCell.parkingIconImageView.hidden = !shopEntity.Parking.boolValue;
            shopCell.numberOfCollectionLabel.hidden = !shopEntity.Collection.boolValue;
            shopCell.addressLabel.text = shopEntity.Address;
            shopCell.numberOfCollectionLabel.text =
            [NSString stringWithFormat:@"%d人已收藏",shopEntity.Collection.intValue];
            [shopCell.previewImageView setImageWithURL:[NSURL URLWithString:shopEntity.Groupico] placeholderImage:[UIImage imageNamed:@"ad0.jpg"]];
            
            return shopCell;
        }
        
        else if(self.firstSegmentedControlSelectedIndex == 1)
        {
            FoodCell *foodCell = [tableView dequeueReusableCellWithIdentifier:@"FoodCell"];
            if(foodCell == nil)
            {
                UINib *nib = [UINib nibWithNibName:@"FoodCell" bundle:nil];
                foodCell = [[nib instantiateWithOwner:nil options:nil] objectAtIndex:0];
            }
            
            Product *productEntity = nil;
            @try {
              productEntity  = self.productDataModel.Datas[indexPath.row];
            }
            @catch (NSException *exception) {
                NSLog(@"%@",exception.description);
            }
            
            foodCell.nameLabel.text = productEntity.Serviceitem;
           // [foodCell.previewImageView setImageWithURL:[NSURL URLWithString:productEntity.Itemimage] placeholderImage:nil];
            //foodCell.addressLabel.text = productEntity.Address;
            
            return foodCell;
        }
        
        return nil;
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
    
    if(tableView == self.dropView4)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"DV4CID"];
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DV4CID"];
            cell.textLabel.text = @"支持优惠券";
            cell.backgroundColor = [UIColor clearColor];
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            
            UISwitch *switchControl = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
            [switchControl addTarget:self action:@selector(switchControlValueChanged:) forControlEvents:UIControlEventValueChanged];
            switchControl.onTintColor = [UIColor r:232 g:92 b:82 a:1];
            cell.accessoryView = switchControl;
        }
        
        return cell;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.foodShopListTableView)
    {
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
        UIViewController *controller = nil;
        if(self.firstSegmentedControlSelectedIndex == 0)
        {
            FoodShop *foodShop = self.foodShopDataModel.Datas[indexPath.row];
            controller = [[FoodShopDetailVC alloc] initWithNibName:@"FoodShopDetailVC" FoodShopEntity:foodShop];
        }
        else
        {
            Product *product = self.productDataModel.Datas[indexPath.row];
            controller = [[FoodDetailVC alloc] initWithNibName:@"FoodDetailVC" productNumber:product];
        }
        
        [self.navigationController pushViewController:controller animated:YES];
        return;
    }
    
    // 延迟0.2秒执行是为了看见下拉菜单被选中的效果
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if(tableView == self.dropView1)
        {
            self.dropView1.hidden = YES;
            self.maskView.hidden = YES;
            
            if(self.firstSegmentedControlSelectedIndex == 0)
            {
                if(indexPath.row == 0) [self loadNearbyFoodShop];
                else if(indexPath.row == 1) [self loadBestSalesFoodShop];
            }
            
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
                
                if(self.firstSegmentedControlSelectedIndex == 0) [self loadFoodShopByAreaWithIndex:indexPath];
            }
            return;
        }
        
        if(tableView == self.dropView3)
        {
            self.dropView2.hidden = YES;
            self.dropView3.hidden = YES;
            self.maskView.hidden = YES;
            
            if(self.firstSegmentedControlSelectedIndex == 0) [self loadFoodShopByDistanceWithIndex:indexPath];
            
            return;
        }
    });
}
@end
