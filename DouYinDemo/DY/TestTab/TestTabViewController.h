//
//  TestTabViewController.h
//  DouYinDemo
//
//  Created by HN on 2020/10/27.
//  Copyright © 2020 HN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestTabBar.h"

NS_ASSUME_NONNULL_BEGIN

@interface TestTabViewController : UITabBarController
@property (strong, nonatomic) TestTabBar *testTabBar;

@end

NS_ASSUME_NONNULL_END
