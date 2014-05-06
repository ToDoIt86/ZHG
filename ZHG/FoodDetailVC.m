//
//  FoodShopDetailVC.m
//  ZHG
//
//  Created by lihong on 14-4-29.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import "FoodDetailVC.h"
#import "UIScrollView+ContentSize.h"
#import "SalesPromotionCell.h"
#import "HUD.h"
#import "WSServiceItemService.h"
#import "ProductDetail.h"
#import "AlertView.h"


@interface FoodDetailVC ()<UIScrollViewDelegate,UITableViewDataSource,UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *topLevelScrollView;

@property (weak, nonatomic) IBOutlet UIScrollView *adScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *adPageControl;
@property (weak, nonatomic) IBOutlet UITableView *salesPromotionTableView;

@property (weak, nonatomic) IBOutlet UILabel *numberOfCollectionLabel;
@property (weak, nonatomic) IBOutlet UILabel *discountLabel;
@property (weak, nonatomic) IBOutlet UILabel *discountLabel2;
@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UITextView *introductionTextView;


@property (nonatomic, strong) NSString *productNumber;
@end

@implementation FoodDetailVC

- (id)initWithNibName:(NSString *)nibNameOrNil productNumber:(NSString *)number
{
    self = [super initWithNibName:nibNameOrNil bundle:nil];
    if (self)
    {
        self.title = @"商品详情";
        self.productNumber = number;
        self.edgesForExtendedLayout = UIRectEdgeLeft|UIRectEdgeRight;
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.salesPromotionTableView registerNib:[UINib nibWithNibName:@"SalesPromotionCell" bundle:nil]
                       forCellReuseIdentifier:@"SalesPromotionCell"];
    
    [self insertAdContent];
    [self.topLevelScrollView calculateAndSetContentSize];
    
    [HUD showHUDInView:self.view title:@"玩命加载中..."];
    /*[WSServiceItemService getItemBasicProperty:self.productNumber usersn:@"NULL" groupsn:@"NULL" onCompleted:^(JSONModel *model, JSONModelError *err) {
        [HUD hideHUDForView:self.view];
        
        ProductDetailResponse *response = (ProductDetailResponse *)model;
        if(err || model == nil) [AlertView showWithMessage:@"获取数据失败"];
        else if(response.success == NO) [AlertView showWithMessage:response.message];
        else
        {
            self.productNameLabel.text = response.Datas.Serviceitem;
            self.numberOfCollectionLabel.text = response.Datas.Collection;
        }
    }];*/
    
    [WSServiceItemService getItem:self.productNumber onCompleted:^(JSONModel *model, JSONModelError *err) {
        [HUD hideHUDForView:self.view];
        
        ProductDetailResponse *response = (ProductDetailResponse *)model;
        if(err || model == nil) [AlertView showWithMessage:@"获取数据失败"];
        else if(response.success == NO) [AlertView showWithMessage:response.message];
        else
        {
            self.productNameLabel.text = response.Datas.Serviceitem;
            self.numberOfCollectionLabel.text = response.Datas.Collection;
            //self.addressLabel.text = response.Datas.Address;
           // self.phoneLabel.text = response.Datas.Telephone;
           // self.introductionTextView.text  = response.Datas.Itemintro;
            [self.webView loadHTMLString:response.Datas.Itemcontent baseURL:nil];
        }
    }];
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

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    CGRect newRect = webView.frame;
    newRect.size = webView.scrollView.contentSize;
    webView.frame = newRect;
    [self.topLevelScrollView calculateAndSetContentSize];
}

@end
