//
//  SlideTabBarView.m
//  DouYinDemo
//
//  Created by HN on 2020/10/19.
//  Copyright © 2020 HN. All rights reserved.
//

#import "SlideTabBarView.h"

@interface SlideTabBarView ()

@property (strong, nonatomic) NSArray *dataArray;

///@brife 上方的按钮数组
@property (strong, nonatomic) NSMutableArray *topViews;

///@brife 下面滑动的View
@property (strong, nonatomic) UIView *slideView;

///@brife 上方的view
@property (strong, nonatomic) UIView *topMainView;

///@brife 上方的ScrollView
@property (strong, nonatomic) UIScrollView *topScrollView;

@property (assign, nonatomic) NSInteger currentPage;
@end

@implementation SlideTabBarView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titlesArray {
    if (self = [super initWithFrame:frame]) {
        self.dataArray = titlesArray;
        _topViews = [[NSMutableArray alloc] init];

        [self initTopTabs];
        [self initSlideView];
        
//        if ([self.delegate respondsToSelector:@selector(slideTabBarView:didSelectedIndex:)]) {
//            [self.delegate slideTabBarView:self didSelectedIndex:0];
//        }
    }
    return self;
}

#pragma mark - UI
#pragma mark -- 初始化滑动的指示View
- (void)initSlideView {
    
    CGFloat slideW = self.frame.size.width / self.dataArray.count *  0.75;

    self.slideView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width / self.dataArray.count * (1-0.75)/2., self.frame.size.height - 5, slideW, 5)];
    [self.slideView setBackgroundColor:[UIColor whiteColor]];
    [self.topScrollView addSubview:self.slideView];
}

#pragma mark -- 实例化顶部的tab
- (void)initTopTabs {
    CGFloat width = self.frame.size.width / self.dataArray.count;
    
    self.topMainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.topScrollView.showsHorizontalScrollIndicator = NO;
    self.topScrollView.showsVerticalScrollIndicator = YES;
    self.topScrollView.bounces = NO;
    
    self.topScrollView.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    
    [self addSubview:self.topMainView];
    
    [self.topMainView addSubview:self.topScrollView];
    
    
    
    for (int i = 0; i < self.dataArray.count; i ++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(i * width, 0, width, self.frame.size.height)];
        view.backgroundColor = [UIColor lightGrayColor];
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, width, self.frame.size.height)];
        button.tag = i;
        [button setTitle:self.dataArray[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(onActionClicked:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        
        [_topViews addObject:view];
        [self.topScrollView addSubview:view];
    }
}

#pragma mark --点击顶部的按钮所触发的方法
- (void)onActionClicked:(UIButton *)sender {
    if (sender.tag == self.currentPage) {
        return;
    }
    
    self.currentPage = sender.tag;    
    [self.delegate slideTabBarView:self didSelectedIndex:sender.tag];
    
    if ([self.delegate respondsToSelector:@selector(slideTabBarView:didSelectedIndex:)]) {
        [self.delegate slideTabBarView:self didSelectedPageIndex:self.currentPage];
    }
}

#pragma mark - other
- (void)slideTabBarView:(SlideTabBarView *)slideTabBarView scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.currentPage = scrollView.contentOffset.x/scrollView.frame.size.width;

    if ([self.delegate respondsToSelector:@selector(slideTabBarView:didSelectedIndex:)]) {
        [self.delegate slideTabBarView:self didSelectedPageIndex:self.currentPage];
    }
}

- (void)slideTabBarView:(SlideTabBarView *)slideTabBarView scrollViewDidScroll:(UIScrollView *)scrollView {
    CGRect frame = self.slideView.frame;

    frame.origin.x = scrollView.contentOffset.x/[UIScreen mainScreen].bounds.size.width*self.frame.size.width/self.dataArray.count;
    self.slideView.frame = frame;
}
@end
