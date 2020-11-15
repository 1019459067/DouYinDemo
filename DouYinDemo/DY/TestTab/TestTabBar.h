//
//  TestTabBar.h
//  DouYinDemo
//
//  Created by XWH on 2020/10/29.
//  Copyright © 2020 HN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestBarView.h"

NS_ASSUME_NONNULL_BEGIN

@interface TestTabBar : UITabBar

@property (nonatomic, strong) TestBarView *tabBarView;

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titlesArray;

- (void)showLine;
- (void)hideLine;

@end

NS_ASSUME_NONNULL_END
