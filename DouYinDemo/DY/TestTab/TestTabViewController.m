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

#import "TestNavigationController.h"

@interface TestTabViewController ()<TestBarViewDelegate, UITabBarControllerDelegate>


@end

@implementation TestTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.tabBar.hidden = YES;
    self.testTabBar = [[TestTabBar alloc] initWithFrame:self.tabBar.frame titles:@[@"Test1", @"Test2", @"Test3", @"Test4"]];
//    [self.view addSubview:self.testTabBar];
//    self.testTabBar.frame = self.tabBar.frame;
    self.testTabBar.tabBarView.viewDelegate = self;
    [self setValue:self.testTabBar forKey:@"tabBar"];
    
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

    TestNavigationController *nav = [[TestNavigationController alloc]initWithRootViewController:vc];
    
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

#pragma mark - TestBarViewViewDelegate
- (void)testBarView:(TestBarView *)view didSelectItemAtIndex:(NSInteger)index
{
//    self.testTabBar.backgroundImage = index ? [UIImage gk_imageWithColor:[UIColor blueColor] size:CGSizeMake(SCREEN_WIDTH, GK_TABBAR_HEIGHT)] : [UIImage gk_imageWithColor:[UIColor clearColor] size:CGSizeMake(SCREEN_WIDTH, GK_TABBAR_HEIGHT)];
    // 切换到对应index的viewController
    self.selectedIndex = index;
    NSLog(@"index------>>>%ld",index);
}

@end
