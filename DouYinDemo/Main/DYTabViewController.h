//
//  DYTabViewController.h
//  DouYinDemo
//
//  Created by HN on 2020/10/27.
//  Copyright © 2020 HN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DHCustomTabBar.h"

NS_ASSUME_NONNULL_BEGIN

@interface DYTabViewController : UITabBarController
@property (strong, nonatomic) DHCustomTabBar *dhTabBar;

@end

NS_ASSUME_NONNULL_END
