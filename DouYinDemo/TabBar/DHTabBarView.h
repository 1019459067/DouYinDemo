//
//  DHTabBarView.h
//  DouYinDemo
//
//  Created by HN on 2020/7/27.
//  Copyright © 2020 HN. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DHTabBarView;

@protocol DHTabBarViewDelegate <NSObject>

- (void)dhTabBarView:(DHTabBarView *)view didSelectItemAtIndex:(NSInteger)index;

- (void)dhTabBarViewDidClickCenterItem:(DHTabBarView *)view;

@end

@interface DHTabBarView : UIView

@property (nonatomic, weak) id<DHTabBarViewDelegate> viewDelegate;

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titlesArray;
@end
