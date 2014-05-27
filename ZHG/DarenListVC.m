//
//  DarenListVC.m
//  ZHG
//
//  Created by lihong on 14-5-26.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import "DarenListVC.h"
#import "DarenListCell.h"
#import "UIColor+RGB.h"

@interface DarenListVC ()<UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *darenListVIew;

@end

@implementation DarenListVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    UINib *nib = [UINib nibWithNibName:@"DarenListCell" bundle:nil];
    [self.darenListVIew registerNib:nib forCellReuseIdentifier:@"DarenListCell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)popSelfFromNavigationStack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)refreshDarenListByType:(UIButton *)sender {
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DarenListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DarenListCell"];
    
    cell.darenNameLabel.text = [NSString stringWithFormat:@"吐槽达人 %zd",indexPath.row];
    cell.darenQianMingLable.text = [NSString stringWithFormat:@"有些路，走过后才发现风景并没想像的美 %d",indexPath.row];
    
    cell.backgroundColor = indexPath.row%2?[UIColor r:30.0 g:30.0 b:30.0 ]:[UIColor r:44.0 g:44.0 b:44.0 ];
    
    return cell;
}
@end
