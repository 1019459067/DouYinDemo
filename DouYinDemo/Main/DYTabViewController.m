//
//  DYTabViewController.m
//  DouYinDemo
//
//  Created by HN on 2020/10/27.
//  Copyright © 2020 HN. All rights reserved.
//

#import "DYTabViewController.h"
#import "MainViewController.h"

@interface DYTabViewController ()

@end

@implementation DYTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MainViewController *homeVC = HNWLoadControllerFromStoryboard(SBName, NSStringFromClass(MainViewController.class));
    [self addChildViewControllerWithVC:homeVC];
}

// 添加某个 childViewController
- (void)addChildViewControllerWithVC:(UIViewController *)vc
{
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
//    nav.gk_openScrollLeftPush = YES;
    // 如果同时有navigationbar 和 tabbar的时候最好分别设置它们的title
//    vc.navigationItem.title = title;
    nav.title = nil;
//    vc.tabBarItem.title = title;
    [self addChildViewController:nav];
}
@end
