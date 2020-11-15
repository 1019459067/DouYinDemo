//
//  DHNearViewController.m
//  DouYinDemo
//
//  Created by HN on 2020/10/26.
//  Copyright © 2020 cnhnb. All rights reserved.
//

#import "DHNearViewController.h"

@interface DHNearViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *dataArray;
@end

@implementation DHNearViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;

    self.title = @"Near";
    
    UILabel *label = [[UILabel alloc]init];
    label.bounds = CGRectMake(0, 0, self.view.frame.size.width, 50);
    label.center = CGPointMake(self.view.frame.size.width/2., self.view.frame.size.height/2.);
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = UIColor.redColor;
    label.adjustsFontSizeToFitWidth = YES;
    label.text = [NSString stringWithFormat:@"%s",__func__];
    [self.view addSubview:label];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate, UITableViewData
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"Near_%ld" ,indexPath.row];
    cell.backgroundColor = UIColor.redColor;
    return cell;
}

#pragma mark - get data
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        for (int i = 0; i < 15; i++) {
            [_dataArray addObject:@(i)];
        }
    }
    return _dataArray;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _tableView;
}

@end
