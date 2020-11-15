//
//  SlideTabBarView.h
//  DouYinDemo
//
//  Created by HN on 2020/10/19.
//  Copyright © 2020 HN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SlideTabBarView;
@protocol SlideTabBarViewDelegate <NSObject>

- (void)slideTabBarView:(SlideTabBarView *)view
   didSelectedPageIndex:(NSInteger)pageIndex;
- (void)slideTabBarView:(SlideTabBarView *)view
       didSelectedIndex:(NSInteger)selectedIndex;

@end

@interface SlideTabBarView : UIView

@property (assign, nonatomic) id<SlideTabBarViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)itemsArray;

- (void)updateCurrentPageWithScroll:(UIScrollView *)scrollView;
- (void)updateSlideViewWithScroll:(UIScrollView *)scrollView;

@end

NS_ASSUME_NONNULL_END
