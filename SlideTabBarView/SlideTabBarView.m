//
//  SlideTabBarView.m
//  DouYinDemo
//
//  Created by HN on 2020/10/19.
//  Copyright © 2020 HN. All rights reserved.
//

#import "SlideTabBarView.h"

@interface SlideTabBarView ()

///@brife 下面滑动的View
@property (strong, nonatomic) UIView *slideView;

///@brife 上方的view
@property (strong, nonatomic) UIView *topMainView;

///@brife 上方的ScrollView
@property (strong, nonatomic) UIScrollView *topScrollView;

@property (assign, nonatomic) NSInteger currentPage;
@property (strong, nonatomic) NSArray *dataArray;
@property (strong, nonatomic) NSMutableArray *buttonsArray;

@end

@implementation SlideTabBarView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)itemsArray
{
    if (self = [super initWithFrame:frame]) {
        self.dataArray = itemsArray;

        [self initTopTabs];
        [self initSlideView];
    }
    return self;
}

#pragma mark - UI
#pragma mark -- 初始化滑动的指示View
- (void)initSlideView {
    CGFloat slideW = 21;
    CGFloat slideX = (self.frame.size.width/2.-slideW)/2.;

    self.slideView = [[UIView alloc] initWithFrame:CGRectMake(slideX, self.frame.size.height - 2, slideW, 2)];
    self.slideView.layer.cornerRadius = self.slideView.frame.size.height/2.;
    self.slideView.backgroundColor = [UIColor whiteColor];
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
        NSString *name = self.dataArray[i];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(i * width, 0, width, self.frame.size.height)];
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, width, self.frame.size.height)];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        button.tag = i;
        [button setTitle:name forState:UIControlStateNormal];
        [button addTarget:self action:@selector(onActionClicked:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        
        [self.buttonsArray addObject:button];
        [self.topScrollView addSubview:view];
    }
}

- (void)updateUIWithPageIndex
{
    for (UIButton *btn in self.buttonsArray) {
        if (self.currentPage == btn.tag) {
            [btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        } else {
            [btn setTitleColor:[UIColor colorWithWhite:1 alpha:0.6] forState:UIControlStateNormal];
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(slideTabBarView:didSelectedIndex:)]) {
        [self.delegate slideTabBarView:self didSelectedPageIndex:self.currentPage];
    }
}

#pragma mark - other
- (void)onActionClicked:(UIButton *)sender {
    if (sender.tag == self.currentPage) {
        return;
    }
    
    self.currentPage = sender.tag;
    [self.delegate slideTabBarView:self didSelectedIndex:sender.tag];
    [self updateUIWithPageIndex];
}

- (void)updateCurrentPageWithScroll:(UIScrollView *)scrollView {
    self.currentPage = scrollView.contentOffset.x/scrollView.frame.size.width;

    [self updateUIWithPageIndex];
}

- (void)updateSlideViewWithScroll:(UIScrollView *)scrollView {
    CGRect frame = self.slideView.frame;
    CGFloat slideX = (self.frame.size.width/2.-frame.size.width)/2.;

    frame.origin.x = scrollView.contentOffset.x/[UIScreen mainScreen].bounds.size.width * self.frame.size.width/self.dataArray.count+slideX;

    self.slideView.frame = frame;
}

#pragma mark - get data
- (NSMutableArray *)buttonsArray
{
    if (!_buttonsArray) {
        _buttonsArray = [NSMutableArray array];
    }
    return _buttonsArray;
}

@end
