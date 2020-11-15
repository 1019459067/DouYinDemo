//
//  DHTabBar.m
//  DouYinDemo
//
//  Created by HN on 2020/7/27.
//  Copyright © 2020 HN. All rights reserved.
//

#import "DHTabBar.h"

@implementation DHTabBar

- (void)layoutSubviews
{
    [super layoutSubviews];
    UIImageView *topLine = nil;
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIImageView class]] && view.frame.size.height == 0.5) {
            topLine = (UIImageView *)view;
        } else if ([view isKindOfClass:NSClassFromString(@"_UIBarBackground")]) {
            [view removeFromSuperview];
        }
    }
    // 移除iOS9顶部黑线
    [topLine removeFromSuperview];
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
    
//    DHTabBarView *bottomView;
//    for (UIView *subView in self.subviews) {
//        if ([subView isKindOfClass:[DHTabBarView class]]) {
//            bottomView = (DHTabBarView *)subView;
//            break;
//        }
//    }
//
//    // 这里遍历那些超出的部分就可以了，不过这么写比较通用。
//    for (UIView *subview in bottomView.subviews) {
//        // 把这个坐标从tabbar的坐标系转为subview的坐标系
//        CGPoint subPoint = [subview convertPoint:point fromView:self];
//        result = [subview hitTest:subPoint withEvent:event];
//        // 如果事件发生在subView里就返回
//        if (result) {
//            return result;
//        }
//    }
    return nil;
}

@end
