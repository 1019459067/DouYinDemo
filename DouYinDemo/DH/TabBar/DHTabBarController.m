//
//  DHTabBarController.m
//  DouYinDemo
//
//  Created by HN on 2020/7/27.
//  Copyright © 2020 HN. All rights reserved.
//

#import "DHTabBarController.h"
#import "DHHomeViewController.h"
#import "DHNearViewController.h"
#import "DHMessageViewController.h"
#import "DHMyViewController.h"

#import "DHTabBar.h"

@interface DHTabBarController ()<DHTabBarViewDelegate>

@end

@implementation DHTabBarController

#pragma mark - life
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;

    // Do any additional setup after loading the view.
    self.dhTabBar = [[DHTabBar alloc] initWithFrame:CGRectZero titles:@[@"首页",@"附近",@"消息",@"我"]];
    self.dhTabBar.tabBarView.viewDelegate = self;
    [self setValue:self.dhTabBar forKey:@"tabBar"];
    
    [self addAllChildViewController];
}

#pragma mark - UI
- (void)addAllChildViewController {
    DHHomeViewController *homeVC = HNWLoadControllerFromStoryboard(SBName, NSStringFromClass(DHHomeViewController.class));
    DHNearViewController *nearVC = HNWLoadControllerFromStoryboard(SBName, NSStringFromClass(DHNearViewController.class));
    DHMessageViewController *messageVC = HNWLoadControllerFromStoryboard(SBName, NSStringFromClass(DHMessageViewController.class));
    DHMyViewController *myVC = HNWLoadControllerFromStoryboard(SBName, NSStringFromClass(DHMyViewController.class));
    
    [self addChildViewControllerWithVC:homeVC];
    [self addChildViewControllerWithVC:nearVC];
    [self addChildViewControllerWithVC:messageVC];
    [self addChildViewControllerWithVC:myVC];
}

// 添加某个 childViewController
- (void)addChildViewControllerWithVC:(UIViewController *)vc
{
    TestNavigationController *nav = [[TestNavigationController alloc] initWithRootViewController:vc];
    nav.gk_openScrollLeftPush = YES;
    // 如果同时有navigationbar 和 tabbar的时候最好分别设置它们的title
//    vc.navigationItem.title = title;
    nav.title = nil;
//    vc.tabBarItem.title = title;
    [self addChildViewController:nav];
}

#pragma mark - DHTabBarViewDelegate
- (void)dhTabBarView:(DHTabBarView *)view didSelectItemAtIndex:(NSInteger)index
{
    self.dhTabBar.backgroundImage = index ? [UIImage gk_imageWithColor:[UIColor blueColor] size:CGSizeMake(SCREEN_WIDTH, GK_TABBAR_HEIGHT)] : [UIImage gk_imageWithColor:[UIColor clearColor] size:CGSizeMake(SCREEN_WIDTH, GK_TABBAR_HEIGHT)];
    // 切换到对应index的viewController
    self.selectedIndex = index;
    NSLog(@"index------>>>%ld",index);
}

- (void)dhTabBarViewDidClickCenterItem:(DHTabBarView *)view
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"点击了中间的按钮" message:@"do something!" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
