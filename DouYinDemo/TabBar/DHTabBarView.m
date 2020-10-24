//
//  DHTabBarView.m
//  DouYinDemo
//
//  Created by HN on 2020/7/27.
//  Copyright © 2020 HN. All rights reserved.
//

#import "DHTabBarView.h"
#import "DHTabbarButton.h"

@interface DHTabBarView ()

@property (strong, nonatomic) UIButton *centerButton;

@property (assign, nonatomic) NSInteger selectIndex;
@property (strong, nonatomic) NSArray *titlesArray;
@property (strong, nonatomic) NSMutableArray<DHTabbarButton *> *btnsArray;

@end

@implementation DHTabBarView

#pragma mark - life
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titlesArray {
    if (self = [super initWithFrame:frame]) {
        self.titlesArray = titlesArray;
        [self setttingUI];
        
        self.selectIndex = 0;
    }
    return self;
}

#pragma mark - UI
- (void)setttingUI {
    CGFloat tabBarButtonX = 0;
    CGFloat tabBarButtonY = 0;
    CGFloat tabBarButtonW = SCREEN_WIDTH / (self.titlesArray.count+1);
    CGFloat tabBarButtonH = 49;
    
    self.centerButton.frame = CGRectMake((SCREEN_WIDTH-tabBarButtonW)/2, 0, tabBarButtonW, 49);
    // button
    for (int i = 0; i<self.titlesArray.count; i++) {
        if (i>1) {
            tabBarButtonX = tabBarButtonW*(i+1);
        } else {
            tabBarButtonX = tabBarButtonW*i;
        }
        
        NSString *title = self.titlesArray[i];
        CGRect frame = CGRectMake(tabBarButtonX, tabBarButtonY, tabBarButtonW, tabBarButtonH);

        DHTabbarButton *btn = [self addButtonWithFrame:frame title:title];
        btn.tag = i;
        
        [self.btnsArray addObject:btn];
    }
}

- (DHTabbarButton *)addButtonWithFrame:(CGRect)frame title:(NSString *)title {
    DHTabbarButton *btn = [[DHTabbarButton alloc]initWithFrame:frame];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn addTarget:self action:@selector(onActionClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    return btn;
}

#pragma mark - other
- (void)onActionClicked:(UIButton *)sender
{
    // button的tag对应tabBarController的selectedIndex
    // 设置选中button的样式
    self.selectIndex = sender.tag;
    // 让代理来处理切换viewController的操作
    if ([self.viewDelegate respondsToSelector:@selector(dhTabBarView:didSelectItemAtIndex:)]) {
        [self.viewDelegate dhTabBarView:self didSelectItemAtIndex:sender.tag];
    }
}

- (void)onActionClickCenterButton:(id)sender
{
    // 让代理来处理点击中间button的操作
    if ([self.viewDelegate respondsToSelector:@selector(dhTabBarViewDidClickCenterItem:)]) {
        [self.viewDelegate dhTabBarViewDidClickCenterItem:self];
    }
}

#pragma mark - set data
- (void)setSelectIndex:(NSInteger)selectIndex
{
    // 先把上次选择的item设置为可用
    UIButton *lastItem = self.btnsArray[_selectIndex];
    lastItem.enabled = YES;
    // 再把这次选择的item设置为不可用
    UIButton *item = self.btnsArray[selectIndex];
    item.enabled = NO;
    _selectIndex = selectIndex;
    
    for (DHTabbarButton *button in self.btnsArray) {
        if (button.tag == selectIndex) {
            [button setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
            button.indicatorLine.hidden = NO;
        } else {
            [button setTitleColor:[UIColor colorWithWhite:1 alpha:0.5] forState:UIControlStateNormal];
            button.indicatorLine.hidden = YES;
        }
    }
}

#pragma mark - get data
- (UIButton *)centerButton {
    if (!_centerButton) {
        _centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_centerButton];
        [_centerButton setImage:[UIImage imageNamed:@"tabbar_camera_image_normal"] forState:UIControlStateNormal];
        _centerButton.adjustsImageWhenHighlighted = false;
        [_centerButton addTarget:self action:@selector(onActionClickCenterButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _centerButton;
}

- (NSMutableArray *)btnsArray {
    if (!_btnsArray) {
        _btnsArray = [NSMutableArray array];
    }
    return _btnsArray;
}
@end
