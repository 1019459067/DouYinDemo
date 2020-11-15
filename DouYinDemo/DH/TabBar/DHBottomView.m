//
//  FCHTabbar.m
//  DouYinDemo
//
//  Created by HN on 2020/7/27.
//  Copyright © 2020 HN. All rights reserved.
//

//View
#import "DHBottomView.h"
#import "DHTabbarButton.h"

@interface DHBottomView()

@property (strong, nonatomic) UIButton *centerButton;

@property (strong, nonatomic) NSMutableArray<DHTabbarButton *> *tabbarItems;

@property (assign, nonatomic) NSInteger selectIndex;

@end

@implementation DHBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createTabbarItemWithDatas:[self getUIDatas]];
    }
    return self;
}

- (NSArray *)getUIDatas
{
    return @[@"首页",@"附近",@"消息",@"我"];
}

- (void)createTabbarItemWithDatas:(NSArray *)datas
{
    [self addSubview:self.shadowView];
    
    CGFloat tabBarButtonH = 49;
    CGFloat tabBarButtonW = SCREEN_WIDTH / (datas.count+1);
    self.centerButton.frame = CGRectMake((SCREEN_WIDTH-tabBarButtonW)/2, 0, tabBarButtonW, tabBarButtonH);
    CGRect frame = self.centerButton.frame;
    frame.origin = CGPointMake((CGRectGetWidth(self.frame)/2)-(CGRectGetWidth(self.centerButton.frame)/2.0), -24);
    [self addSubview:self.centerButton];
    
    CGFloat itemWidth = (self.frame.size.width - CGRectGetWidth(self.centerButton.frame))/4;
    CGFloat x = 0.0;
    for (NSString *title in datas) {
        NSInteger index = [datas indexOfObject:title];
        x = itemWidth * index;
        if (index >= datas.count/2) {
            x = x + CGRectGetWidth(self.centerButton.frame);
        }

        DHTabbarButton *btn = [self addButtonWithFrame:CGRectMake(x, 0, itemWidth, 50) title:title];
        btn.tag = index;
        [self.tabbarItems addObject:btn];
    }
    self.selectIndex = 0;
}

- (DHTabbarButton *)addButtonWithFrame:(CGRect)frame title:(NSString *)title
{
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
    // 设置选中button的样式
    self.selectIndex = sender.tag;
    // 让代理来处理切换viewController的操作
    if ([self.delegate respondsToSelector:@selector(dhBottomView:didSelectItemAtIndex:)]) {
        [self.delegate dhBottomView:self didSelectItemAtIndex:sender.tag];
    }
}

- (void)onActionClickCenterButton:(id)sender
{
    // 让代理来处理点击中间button的操作
    if ([self.delegate respondsToSelector:@selector(dhBottomViewDidClickCenterItem:)]) {
        [self.delegate dhBottomViewDidClickCenterItem:self];
    }
}

#pragma mark - set data
- (void)setSelectIndex:(NSInteger)selectIndex
{
    // 先把上次选择的item设置为可用
    UIButton *lastItem = self.tabbarItems[_selectIndex];
    lastItem.enabled = YES;
    // 再把这次选择的item设置为不可用
    UIButton *item = self.tabbarItems[selectIndex];
    item.enabled = NO;
    _selectIndex = selectIndex;
    
    for (DHTabbarButton *button in self.tabbarItems) {
        if (selectIndex == 0) {
            button.indicatorLine.backgroundColor = UIColor.whiteColor;
            if (button.tag == selectIndex) {
                [button setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
                button.indicatorLine.hidden = NO;
                button.titleLabel.font = [UIFont boldSystemFontOfSize:16];
            } else {
                [button setTitleColor:[UIColor colorWithWhite:1 alpha:0.6] forState:UIControlStateNormal];
                button.indicatorLine.hidden = YES;
                button.titleLabel.font = [UIFont systemFontOfSize:16];
            }
        } else {
            button.indicatorLine.backgroundColor = UIColor.greenColor;
            if (button.tag == selectIndex) {
                [button setTitleColor:UIColor.greenColor forState:UIControlStateNormal];
                button.indicatorLine.hidden = NO;
                button.titleLabel.font = [UIFont boldSystemFontOfSize:16];
            } else {
                [button setTitleColor:[UIColor colorWithWhite:1 alpha:0.6] forState:UIControlStateNormal];
                button.indicatorLine.hidden = YES;
                button.titleLabel.font = [UIFont systemFontOfSize:16];
            }
        }
    }
}

#pragma mark - get data
- (UIView *)shadowView {
    if (!_shadowView) {
        _shadowView = [[UIView alloc] initWithFrame:self.bounds];
        _shadowView.backgroundColor = UIColor.clearColor;
    }
    return _shadowView;
}

- (UIButton *)centerButton {
    if (!_centerButton) {
        _centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_centerButton];
        [_centerButton setImage:[UIImage imageNamed:@"tabbar_camera_image_selected"] forState:UIControlStateNormal];
        _centerButton.adjustsImageWhenHighlighted = false;
        [_centerButton addTarget:self action:@selector(onActionClickCenterButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _centerButton;
}

- (NSMutableArray<DHTabbarButton *> *)tabbarItems {
    if (!_tabbarItems) {
        _tabbarItems = [NSMutableArray array];
    }
    return _tabbarItems;
}

@end
