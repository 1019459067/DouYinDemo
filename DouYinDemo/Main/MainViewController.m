//
//  MainViewController.m
//  DouYinDemo
//
//  Created by HN on 2020/10/27.
//  Copyright © 2020 HN. All rights reserved.
//

#import "MainViewController.h"
#import "DHTabBarController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = YES;
}

- (IBAction)onActionPush:(UIButton *)sender {
    
    DHTabBarController *tabVC = [[DHTabBarController alloc]init];
    tabVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:tabVC animated:YES];
}

@end
