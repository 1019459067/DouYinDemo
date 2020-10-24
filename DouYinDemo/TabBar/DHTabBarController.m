//
//  DHTabBarController.m
//  DouYinDemo
//
//  Created by HN on 2020/7/27.
//  Copyright © 2020 HN. All rights reserved.
//

#import "DHTabBarController.h"
#import "PersonalViewController.h"
#import "HomeViewController.h"

#import "DHCustomTabBar.h"

@interface DHTabBarController ()<DHTabBarViewDelegate>

@end

@implementation DHTabBarController

#pragma mark - life
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dhTabBar = [[DHCustomTabBar alloc] initWithFrame:CGRectZero titles:@[@"首页",@"我",@"首页复制",@"我复制"]];
    self.dhTabBar.tabBarView.viewDelegate = self;
    [self setValue:self.dhTabBar forKey:@"tabBar"];
    
    [self addAllChildViewController];
}

#pragma mark - UI
- (void)addAllChildViewController {
    HomeViewController *homeVC = HNWLoadControllerFromStoryboard(SBName, NSStringFromClass(HomeViewController.class));
    PersonalViewController *personalVC = HNWLoadControllerFromStoryboard(SBName, NSStringFromClass(PersonalViewController.class));
    
    [self addChildViewControllerWithVC:homeVC];
    [self addChildViewControllerWithVC:personalVC];

    HomeViewController *homeVC2 = HNWLoadControllerFromStoryboard(SBName, NSStringFromClass(HomeViewController.class));
    PersonalViewController *personalVC2 = HNWLoadControllerFromStoryboard(SBName, NSStringFromClass(PersonalViewController.class));

    [self addChildViewControllerWithVC:homeVC2];
    [self addChildViewControllerWithVC:personalVC2];

}

// 添加某个 childViewController
- (void)addChildViewControllerWithVC:(UIViewController *)vc
{
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.gk_openScrollLeftPush = YES;
    // 如果同时有navigationbar 和 tabbar的时候最好分别设置它们的title
//    vc.navigationItem.title = title;
    nav.title = nil;
//    vc.tabBarItem.title = title;
    [self addChildViewController:nav];
}

#pragma mark - other
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f,0.0f, 1.0f,1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - DHCustomTabBarViewDelegate
- (void)dhTabBarView:(DHTabBarView *)view didSelectItemAtIndex:(NSInteger)index
{
    self.dhTabBar.backgroundImage = index ? [self imageWithColor:UIColor.lightTextColor] : [self imageWithColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0]];
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
