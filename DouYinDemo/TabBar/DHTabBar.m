//
//  DHTabBar.m
//  DouYinDemo
//
//  Created by HN on 2020/7/27.
//  Copyright © 2020 HN. All rights reserved.
//

#import "DHTabBar.h"

@implementation DHTabBar

- (instancetype)init {
    if (self = [super init]) {
        [self setBackgroundImage:[UIImage gk_imageWithColor:[UIColor clearColor] size:CGSizeMake(SCREEN_WIDTH, TABBAR_HEIGHT)]];
        [self showLine];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        [self setBackgroundImage:[UIImage gk_imageWithColor:[UIColor clearColor] size:CGSizeMake(SCREEN_WIDTH, TABBAR_HEIGHT)]];
        [self showLine];
    }
    return self;
}

- (void)showLine {
    self.shadowImage = [UIImage gk_imageWithColor:[UIColor colorWithWhite:1.0f alpha:0.2f] size:CGSizeMake(SCREEN_WIDTH, 0.5f)];
}

- (void)hideLine {
    self.shadowImage = [UIImage gk_imageWithColor:[UIColor clearColor] size:CGSizeMake(SCREEN_WIDTH, 0.5f)];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self addSubview:self.indicatorLine];
    CGFloat tabBarButtonW = ScreenWidth / 5;
    self.centerButton.frame = CGRectMake((ScreenWidth-tabBarButtonW)/2, 0, tabBarButtonW, 49);

    CGFloat tabBarButtonIndex = 0;
    for (UIView *child in self.subviews) {
        Class class = NSClassFromString(@"UITabBarButton");
        if ([child isKindOfClass:class]) {
            // 重新设置frame
            CGRect frame = CGRectMake(tabBarButtonIndex * tabBarButtonW, 0, tabBarButtonW, 47);
            child.frame = frame;
            // 增加索引
            if (tabBarButtonIndex == 1) {
                tabBarButtonIndex++;
            }
            tabBarButtonIndex++;
        }
    }
}

- (void)issueBtnAction:(UIButton *)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"issueBtnActionNotification" object:nil];
}

- (UIButton *)centerButton {
    if (!_centerButton) {
        _centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_centerButton];
        [_centerButton setImage:[UIImage imageNamed:@"tabbar_camera_image_normal"] forState:UIControlStateNormal];
        _centerButton.adjustsImageWhenHighlighted = false;
        [_centerButton addTarget:self action:@selector(issueBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _centerButton;
}

- (UIView *)indicatorLine {
    if (!_indicatorLine) {
//        CGFloat indicatorLineX = [UIScreen mainScreen].bounds.size.width/4-50;
//        _indicatorLine = [[UIView alloc]initWithFrame:CGRectMake(indicatorLineX/2., 47, 32, 2)];
        _indicatorLine = [[UIView alloc]initWithFrame:CGRectMake(1/15.0f*[UIScreen mainScreen].bounds.size.width, 47, 32, 1)];
        _indicatorLine.backgroundColor = UIColor.whiteColor;
        _indicatorLine.tag = 1000;
        [self addSubview:_indicatorLine];
    }
    return _indicatorLine;
}

@end
