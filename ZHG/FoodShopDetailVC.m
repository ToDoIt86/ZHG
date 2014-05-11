//
//  FoodShopDetailVC.m
//  ZHG
//
//  Created by lihong on 14-4-29.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import "FoodShopDetailVC.h"
#import "UIScrollView+ContentSize.h"
#import "SalesPromotionCell.h"
#import "HUD.h"
#import "LHLocationManager.h"
#import "AlertView.h"
#import "UIImageView+WebCache.h"

@interface FoodShopDetailVC ()<UIScrollViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIScrollView *topLevelScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *adScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *adPageControl;
@property (weak, nonatomic) IBOutlet UITableView *salesPromotionTableView;
@property (weak, nonatomic) IBOutlet UILabel *locationLable;
@property (weak, nonatomic) IBOutlet UIImageView *AvatarImageView;
@property (strong, nonatomic) FoodShop *foodShopEntity;

@property (weak, nonatomic) IBOutlet UILabel *dicountLabel1;
@property (weak, nonatomic) IBOutlet UILabel *discountLablel2;
@property (weak, nonatomic) IBOutlet UILabel *produtNameLabel;
@property (weak, nonatomic) IBOutlet UITextView *groupIntroduceTextView;
@property (weak, nonatomic) IBOutlet UILabel *shopAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfShare;

@end

@implementation FoodShopDetailVC

- (instancetype) initWithNibName:(NSString *)nibNameOrNil FoodShopEntity:(FoodShop *)foodShop
{
    self = [super initWithNibName:nibNameOrNil bundle:nil];
    if (self)
    {
        self.title = @"商户详情";
        self.foodShopEntity = foodShop;
        self.edgesForExtendedLayout = UIRectEdgeLeft|UIRectEdgeRight;
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.AvatarImageView.clipsToBounds = YES;
    self.AvatarImageView.layer.cornerRadius = 30.0;
    
    [self.salesPromotionTableView registerNib:[UINib nibWithNibName:@"SalesPromotionCell" bundle:nil]
                       forCellReuseIdentifier:@"SalesPromotionCell"];
    
    [self insertAdContent];
    [self.topLevelScrollView calculateAndSetContentSize];
   
    self.numberOfShare.text = self.foodShopEntity.Share;
    self.dicountLabel1.text = self.discountLablel2.text = self.foodShopEntity.Discountinfo;
    self.produtNameLabel.text = self.foodShopEntity.Groupname;
    self.groupIntroduceTextView.text = self.foodShopEntity.Intro;
    self.shopAddressLabel.text = self.foodShopEntity.Address;
    [self.AvatarImageView setImageWithURL:[NSURL URLWithString:self.foodShopEntity.Groupico]];
}

#pragma mark - KVO
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.locationLable.text = [LHLocationManager sharedInstance].streetAddress;
    [[LHLocationManager sharedInstance] addObserver:self forKeyPath:@"streetAddress" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [[LHLocationManager sharedInstance] removeObserver:self forKeyPath:@"streetAddress"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    self.locationLable.text = [change objectForKey:@"new"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark － Advertising

- (void)insertAdContent
{
    self.adPageControl.numberOfPages = 4;
    CGRect newRect = self.adScrollView.bounds;
    for(int i = 0; i < 4; i++)
    {
        newRect.origin.x = i*newRect.size.width;
        UIImageView *iamgeView = [[UIImageView alloc] initWithFrame:newRect];
        iamgeView.image = [UIImage imageNamed:[NSString stringWithFormat:@"ad%d.jpg",i]];
        [self.adScrollView addSubview:iamgeView];
    }
    
    [self.adScrollView calculateAndSetContentSize];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    NSInteger pageIndex = floorf( scrollView.contentOffset.x/scrollView.bounds.size.width);
    self.adPageControl.currentPage = pageIndex;
}

#pragma mark - Action
- (IBAction)buyNow:(id)sender
{
    [AlertView showWithMessage:@"购买成功"];
}

- (IBAction)collect:(id)sender
{
    
}

- (IBAction)share:(id)sender {
}


#pragma mark - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SalesPromotionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SalesPromotionCell"];
    return cell;
}
@end
