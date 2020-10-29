//
//  DHTabBar.m
//  DouYinDemo
//
//  Created by HN on 2020/7/27.
//  Copyright © 2020 HN. All rights reserved.
//

#import "DHTabBar.h"

@interface DHTabBar ()

@property (strong, nonatomic) NSArray *titlesArray;

@end

@implementation DHTabBar

#pragma mark - life
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titlesArray {
    self = [super initWithFrame:frame];
    if (self) {
        self.titlesArray = titlesArray;
        [self setBackgroundImage:[UIImage gk_imageWithColor:[UIColor clearColor] size:CGSizeMake(SCREEN_WIDTH, GK_TABBAR_HEIGHT)]];
        [self showLine];
        [self addSubview:self.tabBarView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    // 设置tabBarView的frame
    self.tabBarView.frame = self.bounds;
    // 把tabBarView带到最前面，覆盖tabBar的内容
    [self bringSubviewToFront:self.tabBarView];
}

#pragma mark - UI
- (void)showLine {
    self.shadowImage = [UIImage gk_imageWithColor:[UIColor colorWithWhite:1.0f alpha:0.2f] size:CGSizeMake(SCREEN_WIDTH, 0.5f)];
}

- (void)hideLine {
    self.shadowImage = [UIImage gk_imageWithColor:[UIColor clearColor] size:CGSizeMake(SCREEN_WIDTH, 0.5f)];
}

#pragma mark - other
// 重写hitTest方法，让超出tabBar部分也能响应事件
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (self.clipsToBounds || self.hidden || (self.alpha == 0.f)) {
        return nil;
    }
    UIView *result = [super hitTest:point withEvent:event];
    // 如果事件发生在tabbar里面直接返回
    if (result) {
        return result;
    }
    // 这里遍历那些超出的部分就可以了，不过这么写比较通用。
    for (UIView *subview in self.tabBarView.subviews) {
        // 把这个坐标从tabbar的坐标系转为subview的坐标系
        CGPoint subPoint = [subview convertPoint:point fromView:self];
        result = [subview hitTest:subPoint withEvent:event];
        // 如果事件发生在subView里就返回
        if (result) {
            return result;
        }
    }
    return nil;
}

#pragma mark - get data
- (DHTabBarView *)tabBarView
{
    if (_tabBarView == nil) {
        // xib的加载方式
        _tabBarView = [[DHTabBarView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 49) titles:self.titlesArray];
    }
    return _tabBarView;
}

@end
