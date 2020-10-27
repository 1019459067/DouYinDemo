//
//  AppDelegate.m
//  DouYinDemo
//
//  Created by HN on 2020/9/15.
//  Copyright © 2020 HN. All rights reserved.
//

#import "AppDelegate.h"
#import "UINavigationController+GKCategory.h"

#import "DYTabViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    [GKConfigure setupCustomConfigure:^(GKNavigationBarConfigure *configure) {
//        configure.backStyle             = GKNavigationBarBackStyleBlack;
//        configure.titleFont             = [UIFont systemFontOfSize:18.0f];
//        configure.titleColor            = [UIColor whiteColor];
//        configure.gk_navItemLeftSpace   = 12.0f;
//        configure.gk_navItemRightSpace  = 12.0f;
//        configure.statusBarStyle        = UIStatusBarStyleLightContent;
//        configure.gk_translationX       = 10.0f;
//        configure.gk_translationY       = 15.0f;
//        configure.gk_scaleX             = 0.90f;
//        configure.gk_scaleY             = 0.95f;
//    }];
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = UIColor.whiteColor;

    DYTabViewController *tabVC = [[DYTabViewController alloc]init];
    self.window.rootViewController = tabVC;

    [self.window makeKeyAndVisible];
    return YES;
}

@end
