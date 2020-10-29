//
//  TestBarView.m
//  DouYinDemo
//
//  Created by XWH on 2020/10/29.
//  Copyright © 2020 HN. All rights reserved.
//

#import "TestBarView.h"

@interface TestBarView ()

@property (assign, nonatomic) NSInteger selectIndex;
@property (strong, nonatomic) NSArray *titlesArray;
@property (strong, nonatomic) NSMutableArray<UIButton *> *btnsArray;

@end

@implementation TestBarView

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
    CGFloat tabBarButtonW = SCREEN_WIDTH / (self.titlesArray.count);
    CGFloat tabBarButtonH = 49;
    
    // button
    for (int i = 0; i<self.titlesArray.count; i++) {

        tabBarButtonX = tabBarButtonW*i;

        NSString *title = self.titlesArray[i];
        CGRect frame = CGRectMake(tabBarButtonX, tabBarButtonY, tabBarButtonW, tabBarButtonH);

        UIButton *btn = [self addButtonWithFrame:frame title:title];
        btn.tag = i;
        
        [self.btnsArray addObject:btn];
    }
}

- (UIButton *)addButtonWithFrame:(CGRect)frame title:(NSString *)title {
    UIButton *btn = [[UIButton alloc]initWithFrame:frame];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
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
    if ([self.viewDelegate respondsToSelector:@selector(testBarView:didSelectItemAtIndex:)]) {
        [self.viewDelegate testBarView:self didSelectItemAtIndex:sender.tag];
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
    
    for (UIButton *button in self.btnsArray) {
        if (button.tag == selectIndex) {
            [button setTitleColor:UIColor.redColor forState:UIControlStateNormal];
        } else {
            [button setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        }
    }
}

#pragma mark - get data
- (NSMutableArray *)btnsArray {
    if (!_btnsArray) {
        _btnsArray = [NSMutableArray array];
    }
    return _btnsArray;
}
@end
