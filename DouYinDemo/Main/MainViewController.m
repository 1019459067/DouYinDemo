//
//  MainViewController.m
//  DouYinDemo
//
//  Created by HN on 2020/10/27.
//  Copyright © 2020 HN. All rights reserved.
//

#import "MainViewController.h"
#import "DHTabBarController.h"
#import "TestTabViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    UIWindow * window = [[UIApplication sharedApplication]keyWindow];
    TestTabViewController * tab = (TestTabViewController*)window.rootViewController;
    tab.tabBar.hidden = YES;
    tab.testTabBar.hidden = NO;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UIWindow * window = [[UIApplication sharedApplication]keyWindow];
    TestTabViewController * tab = (TestTabViewController*)window.rootViewController;
    tab.tabBar.hidden = YES;
//    tab.dhTabBar.hidden = NO;
}

//- (void)viewDidDisappear:(BOOL)animated {
//    [super viewDidDisappear:animated];
//    UIWindow * window = [[UIApplication sharedApplication]keyWindow];
//    TestTabViewController * tab = (TestTabViewController*)window.rootViewController;
//    tab.tabBar.hidden = YES;
//    tab.dhTabBar.hidden = YES;
//}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    UIWindow * window = [[UIApplication sharedApplication]keyWindow];
    TestTabViewController * tab = (TestTabViewController*)window.rootViewController;
    tab.tabBar.hidden = YES;
    tab.testTabBar.hidden = YES;
}
- (IBAction)onActionPush:(UIButton *)sender {
    
    DHTabBarController *tabVC = [[DHTabBarController alloc]init];
    tabVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:tabVC animated:YES];
}

@end
