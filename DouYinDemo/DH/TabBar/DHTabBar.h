//
//  DHTabBar.h
//  DouYinDemo
//
//  Created by HN on 2020/7/27.
//  Copyright © 2020 HN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DHTabBarView.h"

@interface DHTabBar : UITabBar

@property (nonatomic, strong) DHTabBarView *tabBarView;

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titlesArray;

- (void)showLine;
- (void)hideLine;

@end
