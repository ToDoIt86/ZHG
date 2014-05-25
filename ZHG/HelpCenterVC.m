//
//  HelpCenterVC.m
//  ZHG
//
//  Created by lihong on 14-5-25.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import "HelpCenterVC.h"
#import "WSHelpCenter.h"
#import "MHelpInfo.h"
#import "AlertView.h"
#import "HUD.h"
#import "UIColor+RGB.h"

@interface HelpCenterVC ()<UITableViewDataSource,UITabBarDelegate>
@property (nonatomic, strong) NSArray *helpItems;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (assign, nonatomic) CGFloat rowHeight;
@property (assign, nonatomic) NSInteger expandingSection;
@property (assign, nonatomic) BOOL isLoading;
@property (strong, nonatomic) UIView *selectedHeaderView;
@property (strong, nonatomic) NSMutableArray *headerViews;
@end

@implementation HelpCenterVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"帮助中心";
        self.expandingSection = -1;
        self.tabBarItem.image = [UIImage imageNamed:@"home_help"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if(_isLoading || (self.helpItems && self.helpItems.count)) return;
    
    _isLoading = YES;
    [HUD showHUDInView:self.view title:@"请稍后"];
    
    [WSHelpCenter GetHelpObj:@"" OnCompleted:^(JSONModel *model, JSONModelError *err) {
        
        _isLoading = NO;
        [HUD hideHUDForView:self.view];
        
        MHelpInfoResponse *r = (MHelpInfoResponse *)model;
        if(!r || !r.success)
        {
            [AlertView showWithMessage:@"不能获取数据，请检查网络连接。"];
            return;
        }
        
        NSInteger i = 1;
        for(MHelpInfo *item in r.Datas)
            item.Htitle = [NSString stringWithFormat:@"%d、%@",i++,item.Htitle];

        self.helpItems = r.Datas;
        [self.tableView reloadData];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(self.helpItems) return self.helpItems.count;
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"xxoo";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
    }
    
    MHelpInfo *item = self.helpItems[indexPath.section];
    cell.textLabel.text = item.Hcontent;
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(self.headerViews == nil) self.headerViews = [NSMutableArray new];
    
    if(self.headerViews.count <= section)
    {
        MHelpInfo *item = self.helpItems[section];
        CGFloat h = [item.Htitle sizeWithFont:[UIFont systemFontOfSize:17]].height;
        h = h > 44.0 ? h : 44.0;
        
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, h)];
        headerView.tag = section;
        headerView.backgroundColor = [UIColor r:230 g:230 b:230];
        
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnSection:)];
        headerView.gestureRecognizers = @[tapGR];
        
        UIView *hairLine = [[UIView alloc] initWithFrame:CGRectMake(0, h-1, 320, 1)];
        hairLine.backgroundColor = [UIColor r:220 g:220 b:220];
        [headerView addSubview:hairLine];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectInset(headerView.bounds, 10, 2)];
        label.numberOfLines = 0;
        label.text = item.Htitle;
        label.tag = 520;
        [headerView addSubview:label];
        
        [self.headerViews addObject:headerView];
        
        return headerView;
    }
    
    return [self.headerViews objectAtIndex:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == _expandingSection) return _rowHeight;
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    MHelpInfo *item = self.helpItems[section];
    CGFloat h = [item.Htitle sizeWithFont:[UIFont systemFontOfSize:17]].height;
    return  h > 44.0 ? h : 44.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)tapOnSection:(UITapGestureRecognizer *)tapGR
{
    if(self.selectedHeaderView && self.selectedHeaderView == tapGR.view)
    {
        UILabel *l = (UILabel *)[self.selectedHeaderView viewWithTag:520];
        l.textColor = [UIColor blackColor];
        self.selectedHeaderView = nil;
    }
    else
    {
        UILabel *l = (UILabel *)[self.selectedHeaderView viewWithTag:520];
        l.textColor = [UIColor blackColor];
        
        l = (UILabel *)[tapGR.view viewWithTag:520];
        l.textColor = [UIColor r:82 g:191 b:210];
        
        self.selectedHeaderView = tapGR.view;
    }
    
    if(_expandingSection == tapGR.view.tag)
    {
        _expandingSection = -1;
    }
    else
    {
        _expandingSection = tapGR.view.tag;
        MHelpInfo *item = self.helpItems[_expandingSection];
        _rowHeight = [item.Hcontent sizeWithFont:[UIFont systemFontOfSize:14.0] forWidth:300.0 lineBreakMode:NSLineBreakByWordWrapping].height;
        _rowHeight += 60.0;
    }
    
    [self.tableView reloadData];
}
@end
