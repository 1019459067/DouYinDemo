//
//  Test1ViewController.m
//  DouYinDemo
//
//  Created by XWH on 2020/10/28.
//  Copyright © 2020 HN. All rights reserved.
//

#import "Test1ViewController.h"
#import "DHTabBarController.h"
#import "TestTabViewController.h"

@interface Test1ViewController ()

@end

@implementation Test1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.label.text = [NSString stringWithFormat:@"%s",__func__];
}

- (IBAction)onActionPush:(UIButton *)sender {
    DHTabBarController *tabVC = [[DHTabBarController alloc]init];
    tabVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:tabVC animated:YES];
}

@end
