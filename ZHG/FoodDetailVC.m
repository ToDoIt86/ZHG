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
#import "FoodOrderVC.h"
#import "ProductDetailTemplate.h"
#import "UIImageView+WebCache.h"
#import "Template.h"
//#import "UMSocial.h"

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

@property (nonatomic, strong) Product *productEntity;
@property (nonatomic, strong) ProductDetailTemplateResponse *templateReponseEntity;
@property (nonatomic, assign) BOOL isLoadedHTML, isLoadedTemplate;

@property (weak, nonatomic) IBOutlet UIView *productDetailView;
@property (weak, nonatomic) IBOutlet UIImageView *AvatarImageView;

@property (weak, nonatomic) IBOutlet UIButton *buyButton;

@end

@implementation FoodDetailVC

- (id)initWithNibName:(NSString *)nibNameOrNil productNumber:(Product *)product
{
    self = [super initWithNibName:nibNameOrNil bundle:nil];
    if (self)
    {
        self.title = @"商品详情";
        self.productEntity = product;
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
    
    [WSServiceItemService getItem:self.productEntity.Itemsn onCompleted:^(JSONModel *model, JSONModelError *err) {
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
            self.discountLabel.text = response.Datas.Discount;
            self.discountLabel2.text = response.Datas.Discount;
            //[self.AvatarImageView setImageWithURL:[NSURL URLWithString:response.Datas.Itemimage] placeholderImage:nil];
            [self.webView loadHTMLString:response.Datas.Itemcontent baseURL:nil];
            
            self.buyButton.enabled = YES;
        }
    }];
    
    [WSServiceItemService getItemContents:self.productEntity.Itemsn onCompleted:^(JSONModel *model, JSONModelError *err) {
        self.templateReponseEntity = (ProductDetailTemplateResponse *)model;
        if(self.isLoadedHTML)  [self layoutProductDetialIntroduce];
        else self.isLoadedTemplate = YES;
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

#pragma mark - Action

- (IBAction)buyNow:(id)sender
{
    
    FoodOrderVC *vc = [[FoodOrderVC alloc] initWithNibName:@"FoodOrderVC" product:self.productEntity];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)collect:(id)sender
{
    [WSServiceItemService addCollection:self.productEntity.Itemsn onCompleted:^(JSONModel *model, JSONModelError *err) {
        
    }];
}

- (IBAction)share:(id)sender
{
   /* [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"536999f656240b658005dca8"
                                      shareText:@"测试分享"
                                     shareImage:nil
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToQzone,UMShareToWechatTimeline,UMShareToQQ,UMShareToRenren,nil]
                                       delegate:nil];*/
}

- (IBAction)callTelephone:(id)sender
{

    if(self.productEntity.Telephone == nil)
    {
        [AlertView showWithMessage:@"无联系电话"];
        return;
    }
    
    NSURL *telephoneURL =
    [[NSURL alloc] initWithString:[@"tel://" stringByAppendingString:self.productEntity.Telephone]];
    if([[UIApplication sharedApplication] canOpenURL:telephoneURL] == NO)
        [AlertView showWithMessage:[@"无法拨打电话:" stringByAppendingString:self.productEntity.Telephone]];
        
    [[UIApplication sharedApplication] openURL:telephoneURL];
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
    
    newRect.origin.y += newRect.size.height;
    newRect.size = self.productDetailView.bounds.size;
    self.productDetailView.frame = newRect;
    
    [self.topLevelScrollView calculateAndSetContentSize];
    
    if(self.isLoadedTemplate) [self layoutProductDetialIntroduce];
    else self.isLoadedHTML = YES;
}

#pragma makr - 
- (void)layoutProductDetialIntroduce
{
    UINib *nib = [UINib nibWithNibName:@"Template" bundle:nil];
    NSArray *views = [nib instantiateWithOwner:nil options:nil];
    CGRect newRect = CGRectMake(0,  self.topLevelScrollView.contentSize.height, 0, 0);
    Template *templateView = nil;
    
    for(ProductDetailTemplate *template in self.templateReponseEntity.Datas)
    {
        if([template.Contentmodel isEqualToString:@"model1"])
        {
             templateView = views[0];
            newRect.size = templateView.bounds.size;
            templateView.frame = newRect;
            [self.topLevelScrollView addSubview:templateView];
            newRect.origin.y += newRect.size.height;
        }
        else if([template.Contentmodel isEqualToString:@"model2"])
        {
            templateView = views[1];
            newRect.size = templateView.bounds.size;
            templateView.frame = newRect;
            [self.topLevelScrollView addSubview:templateView];
            newRect.origin.y += newRect.size.height;
            
        }
        else if([template.Contentmodel isEqualToString:@"model3"])
        {
            templateView = views[2];
            newRect.size = templateView.bounds.size;
            templateView.frame = newRect;
            [self.topLevelScrollView addSubview:templateView];
            newRect.origin.y += newRect.size.height;
            
        }
        else if([template.Contentmodel isEqualToString:@"model4"])
        {
            templateView = views[3];
            newRect.size = templateView.bounds.size;
            templateView.frame = newRect;
            [self.topLevelScrollView addSubview:templateView];
            newRect.origin.y += newRect.size.height;
            
        }
        else if([template.Contentmodel isEqualToString:@"model5"])
        {
            templateView = views[4];
            newRect.size = templateView.bounds.size;
            templateView.frame = newRect;
            [self.topLevelScrollView addSubview:templateView];
            newRect.origin.y += newRect.size.height;
            
        }
        else if([template.Contentmodel isEqualToString:@"model6"])
        {
            templateView = views[5];
            newRect.size = templateView.bounds.size;
            templateView.frame = newRect;
            [self.topLevelScrollView addSubview:templateView];
            newRect.origin.y += newRect.size.height;
        }
        
        if(templateView) [templateView setWith:template];
    }
    
    [self.topLevelScrollView calculateAndSetContentSize];
}

@end
