//
//  DarenHomeVC.m
//  ZHG
//
//  Created by lihong on 14-5-26.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import "DarenHomeVC.h"
#import "DarenHotTagCell.h"
#import "UIScrollView+ContentSize.h"
#import "DarenListVC.h"

@interface DarenHomeVC ()<UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *bigBgImageView;
@property (weak, nonatomic) IBOutlet UIView *tabBarItem1BackgroundView;
@property (weak, nonatomic) IBOutlet UIView *tabBarItem2BackgrondView;
@property (weak, nonatomic) IBOutlet UIButton *upArrowButton;
@property (weak, nonatomic) IBOutlet UIButton *downArrowButton;
@property (weak, nonatomic) IBOutlet UITableView *hotTagTableView;
@property (weak, nonatomic) IBOutlet UIButton *darenListButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation DarenHomeVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    self.navigationController.navigationBarHidden = YES;
    UIImage *image = [[UIImage imageNamed:@"darenNavBacgound"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    [self.tabBarController.tabBar setBackgroundImage:image];
    
    UINib *nib = [UINib nibWithNibName:@"DarenHotTagCell" bundle:nil];
    [self.hotTagTableView registerNib:nib forCellReuseIdentifier:@"DarenHotTagCell"];
    
    [self.scrollView calculateAndSetContentSize];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeDarenType:(UIButton *)sender
{
    if(sender.tag == 520)
    {
        self.tabBarItem1BackgroundView.hidden = NO;
        self.tabBarItem2BackgrondView.hidden = YES;
        self.upArrowButton.hidden = self.downArrowButton.hidden = YES;
        self.bigBgImageView.image = [UIImage imageNamed:@"darenMeiShiBG"];
        [self.darenListButton setImage:[UIImage imageNamed:@"drenListGreen"] forState:UIControlStateNormal];
    }else
    {
        self.tabBarItem1BackgroundView.hidden = YES;
        self.tabBarItem2BackgrondView.hidden = NO;
        self.upArrowButton.hidden = self.downArrowButton.hidden = NO;
        self.bigBgImageView.image = [UIImage imageNamed:@"darenShengHuoBG"];
        [self.darenListButton setImage:[UIImage imageNamed:@"darenListRed"] forState:UIControlStateNormal];
    }
}

- (IBAction)showDarenList:(UIButton *)sender
{
    DarenListVC *dlvc = [[DarenListVC alloc] initWithNibName:@"DarenListVC" bundle:nil];
    [self.navigationController pushViewController:dlvc animated:YES];
}


#pragma mark - UITableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DarenHotTagCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DarenHotTagCell"];
    cell.chineseTagNameLabel.text = [NSString stringWithFormat:@"热门标签%zd",indexPath.row];
    cell.englishTagNameLabel.text = [NSString stringWithFormat:@"HotTagName%d",indexPath.row];
    return cell;
}
@end
