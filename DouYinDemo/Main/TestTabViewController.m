//
//  TestTabViewController.m
//  DouYinDemo
//
//  Created by HN on 2020/10/27.
//  Copyright © 2020 HN. All rights reserved.
//

#import "TestTabViewController.h"
#import "Test1ViewController.h"
#import "Test2ViewController.h"
#import "Test3ViewController.h"
#import "Test4ViewController.h"

#import "RTRootNavigationController.h"

@interface TestTabViewController ()<DHTabBarViewDelegate, UITabBarControllerDelegate>


@end

@implementation TestTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.tabBar.hidden = YES;
    self.dhTabBar = [[DHCustomTabBar alloc] initWithFrame:self.tabBar.frame titles:@[@"Test1", @"Test2", @"Test3", @"Test4"]];
//    [self.view addSubview:self.dhTabBar];
//    self.dhTabBar.frame = self.tabBar.frame;
    self.dhTabBar.tabBarView.viewDelegate = self;
    [self setValue:self.dhTabBar forKey:@"tabBar"];

    self.dhTabBar.backgroundImage = [UIImage gk_imageWithColor:[UIColor orangeColor] size:CGSizeMake(SCREEN_WIDTH, GK_TABBAR_HEIGHT)];
    
//    self.delegate = self;
//    UITabBar *tabBar = [UITabBar appearance];
//    [tabBar setBarTintColor:[UIColor whiteColor]];
//    tabBar.translucent = NO;    // issue:
    
    
    Test1ViewController *test1VC = [[Test1ViewController alloc]init];
    [self addChildViewControllerWithVC:test1VC];
    
    Test2ViewController *test2VC = [[Test2ViewController alloc]init];
    [self addChildViewControllerWithVC:test2VC];
    
    Test3ViewController *test3VC = [[Test3ViewController alloc]init];
    [self addChildViewControllerWithVC:test3VC];
    
    Test4ViewController *test4VC = [[Test4ViewController alloc]init];
    [self addChildViewControllerWithVC:test4VC];
}

// 添加某个 childViewController
- (void)addChildViewControllerWithVC:(UIViewController *)vc
{
//    RTRootNavigationController *nav = [[RTRootNavigationController alloc]initWithRootViewController:vc];

    RTContainerNavigationController *nav = [[RTContainerNavigationController alloc]initWithRootViewController:vc];
    
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    nav.view.backgroundColor = UIColor.redColor;
//    RTRootNavigationController *nav = [[RTRootNavigationController alloc]initWithRootViewController:vc];
//    nav.title = [NSStringFromClass(vc.class) componentsSeparatedByString:@"V"].firstObject;
//    vc.tabBarItem.title = [NSStringFromClass(vc.class) componentsSeparatedByString:@"V"].firstObject;
    [self addChildViewController:nav];
}

#pragma mark - UITabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    NSInteger index = [tabBarController.viewControllers indexOfObject:viewController];
    NSLog(@"tabBarController index------>>>%ld",index);
    self.tabBar.backgroundImage = index ? [UIImage gk_imageWithColor:[UIColor blueColor] size:CGSizeMake(SCREEN_WIDTH, GK_TABBAR_HEIGHT)] : [UIImage gk_imageWithColor:[UIColor clearColor] size:CGSizeMake(SCREEN_WIDTH, GK_TABBAR_HEIGHT)];

    return YES;
}

#pragma mark - DHCustomTabBarViewDelegate
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
