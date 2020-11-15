//
//  DHTabBarController.m
//  DouYinDemo
//
//  Created by HN on 2020/7/27.
//  Copyright © 2020 HN. All rights reserved.
//

// ViewController
#import "DHTabBarController.h"
#import "DHHomeViewController.h"
#import "DHNearViewController.h"
#import "DHMessageViewController.h"
#import "DHMyViewController.h"

//View
#import "DHTabBar.h"
#import "DHBottomView.h"

@interface DHTabBarController ()<DHBottomViewDelegate>
@property (strong, nonatomic) DHBottomView *bottomView;
@end

@implementation DHTabBarController

#pragma mark - life
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self setUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLayoutSubviews
{
    [self setCustemerTabbar];
    [self setSkidGesture];
}

#pragma mark - UI
- (void)setUI
{
    self.rt_disableInteractivePop = NO;
    DHTabBar *dhTabbar = [[DHTabBar alloc] init];
    dhTabbar.backgroundColor = UIColor.clearColor;
    [self setValue:dhTabbar forKey:@"tabBar"];
    [self addAllChildViewController];
}

#pragma mark - other
- (void)addAllChildViewController
{
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
    nav.view.backgroundColor = UIColor.clearColor;
    nav.title = nil;
    [self addChildViewController:nav];
}

- (void)setCustemerTabbar
{
    [self.tabBar setBackgroundImage:[UIImage new]];
    [self.tabBar setShadowImage:[UIImage new]];
    for (UIView *view in self.tabBar.subviews) {
        [view removeFromSuperview];
    }
    [self.tabBar addSubview:self.bottomView];
}

#pragma mark 设置页面的侧滑手势
- (void)setSkidGesture
{
    if (self.tabBar.isHidden) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    } else {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

#pragma mark - delegate
- (void)dhBottomView:(DHBottomView *)view didSelectItemAtIndex:(NSInteger)index
{
    view.shadowView.backgroundColor = index ? [UIColor orangeColor] : [UIColor clearColor];
    self.selectedIndex = index;
}

- (void)dhBottomViewDidClickCenterItem:(DHBottomView *)view
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"点击了中间的按钮" message:@"do something!" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (DHBottomView *)bottomView
{
    if (!_bottomView) {
        CGFloat tabBarHeight = self.tabBar.frame.size.height;
        UIEdgeInsets safeAreaInsets = UIEdgeInsetsZero;
        if (@available(iOS 11.0, *)) {
            safeAreaInsets = APPDELEGATE.window.safeAreaInsets;
        } else {
            // Fallback on earlier versions
        }
        tabBarHeight = tabBarHeight+safeAreaInsets.bottom;
        _bottomView = [[DHBottomView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, tabBarHeight)];
        _bottomView.delegate = self;
    }
    return _bottomView;
}

@end
