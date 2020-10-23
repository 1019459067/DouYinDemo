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

@interface DHTabBarController ()<UITabBarControllerDelegate>

@end

@implementation DHTabBarController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"issueBtnActionNotification" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"tabbarSelectedIndexNotification" object:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    
    self.dhTabBar = [DHTabBar new];
    [self setValue:self.dhTabBar forKey:@"tabBar"];
    
    HomeViewController *homeVC = HNWLoadControllerFromStoryboard(SBName, NSStringFromClass(HomeViewController.class));
    PersonalViewController *personalVC = HNWLoadControllerFromStoryboard(SBName, NSStringFromClass(PersonalViewController.class));
    
    
    [self addCustomChildVC:homeVC title:@"首页" imageName:nil withSelectedImage:nil];
    [self addCustomChildVC:personalVC title:@"我" imageName:nil withSelectedImage:nil];
    
    HomeViewController *homeVC2 = HNWLoadControllerFromStoryboard(SBName, NSStringFromClass(HomeViewController.class));
    PersonalViewController *personalVC2 = HNWLoadControllerFromStoryboard(SBName, NSStringFromClass(PersonalViewController.class));

    [self addCustomChildVC:homeVC2 title:@"首页2" imageName:nil withSelectedImage:nil];
    [self addCustomChildVC:personalVC2 title:@"我2" imageName:nil withSelectedImage:nil];

    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(presentIssueVC:) name:@"issueBtnActionNotification" object:nil];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tabbarBackgroundViewColor:) name:@"tabbarSelectedIndexNotification" object:nil];
}

- (void)presentIssueVC:(NSNotification *)notification{
    NSLog(@"发布发布发布~~~~");
}

- (void)tabbarBackgroundViewColor:(NSNotification *)notification{
    NSDictionary *info = notification.userInfo;
    NSInteger tabBarIndex = [info[@"index"] integerValue];
    ///修改tabBarItem上的indicatorLine的颜色和中心按钮图片
    self.dhTabBar.backgroundImage = tabBarIndex ? [self imageWithColor:[UIColor colorWithRed:255 green:255 blue:255 alpha:1]] : [self imageWithColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0]];
//    self.tabBar.shadowImage = [UIImage new];
    self.dhTabBar.indicatorLine.backgroundColor = tabBarIndex ? UIColor.redColor : UIColor.whiteColor;
    [self.dhTabBar.centerButton setImage:[UIImage imageNamed:tabBarIndex ? @"tabbar_camera_image_selected" : @"tabbar_camera_image_normal"] forState:UIControlStateNormal];
    ///修改tabBarItem的文字颜色
    [self setTabbarItemtextColorWithIndex:tabBarIndex];
//    [self viewDidLayoutSubviews];
}

- (void)addCustomChildVC:(UIViewController *)vc title:(NSString *)title imageName:(NSString *)imageName withSelectedImage:(NSString *)selectedImage {
    self.dhTabBar.tintColor = UIColor.redColor;
    if (imageName) {
        vc.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    if (selectedImage) {
        vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    nav.gk_openScrollLeftPush = YES;
    NSDictionary *textTitleOptions = @{NSForegroundColorAttributeName:UIColor.whiteColor,NSFontAttributeName:[UIFont systemFontOfSize:15]};
    NSDictionary *textTitleOptionsSelected = @{NSForegroundColorAttributeName:UIColor.whiteColor,NSFontAttributeName:[UIFont systemFontOfSize:15]};
    [nav.tabBarItem setTitleTextAttributes:textTitleOptions forState:UIControlStateNormal];
    [nav.tabBarItem setTitleTextAttributes:textTitleOptionsSelected forState:UIControlStateSelected];
    nav.tabBarItem.title = title;
    self.dhTabBar.barTintColor = [UIColor whiteColor];
    [self addChildViewController:nav];
    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0, -15)];
}

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

- (void)setTabbarItemtextColorWithIndex:(NSInteger)index{
    for (UIViewController *vc in self.childViewControllers) {
        if ([vc isKindOfClass:[UINavigationController class]]) {
            UINavigationController *nav = (UINavigationController *)vc;
            NSDictionary *textTitleOptions = @{NSForegroundColorAttributeName:index?rgba(102, 102, 102, 1):UIColor.whiteColor,NSFontAttributeName:[UIFont systemFontOfSize:15]};
            NSDictionary *textTitleOptionsSelected = @{NSForegroundColorAttributeName:index?UIColor.redColor:UIColor.whiteColor,NSFontAttributeName:[UIFont systemFontOfSize:15]};
            [nav.tabBarItem setTitleTextAttributes:textTitleOptions forState:UIControlStateNormal];
            [nav.tabBarItem setTitleTextAttributes:textTitleOptionsSelected forState:UIControlStateSelected];
        }
    }
}


- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    //判断，然后让第一个页面刷新。
    NSInteger index = [tabBarController.viewControllers indexOfObject:viewController];
    NSLog(@"index------>>>%ld",index);
    
    //这里是为了动态修改tabbar的背景色
    [[NSNotificationCenter defaultCenter]postNotificationName:@"tabbarSelectedIndexNotification" object:nil userInfo:@{@"index":@(index)}];
    
    DHTabBarController *tabbar_c = (DHTabBarController *)tabBarController;
    
    CGRect frame = tabbar_c.dhTabBar.indicatorLine.frame;
    if (index == 0) {
        frame.origin.x = 1/15.0f*[UIScreen mainScreen].bounds.size.width;
    }else if (index == 1){
        frame.origin.x = 4/15.0f*[UIScreen mainScreen].bounds.size.width;
    }else if (index == 2){
        frame.origin.x = 10/15.0f*[UIScreen mainScreen].bounds.size.width;
    }else if (index == 3){
        frame.origin.x = 13/15.0f*[UIScreen mainScreen].bounds.size.width;
    }
    tabbar_c.dhTabBar.indicatorLine.frame = frame;
}
@end
