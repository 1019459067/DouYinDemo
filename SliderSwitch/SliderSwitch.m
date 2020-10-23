//
//  SliderSwitch.m
//  DouYinDemo
//
//  Created by HN on 2020/10/19.
//  Copyright © 2020 HN. All rights reserved.
//

#import "SliderSwitch.h"

#define TOPHEIGHT 60

@interface SliderSwitch ()

@property (strong, nonatomic) NSArray *dataArray;
///@brife 上方的按钮数组
@property (strong, nonatomic) NSMutableArray *topViews;
///@brife 当前选中页数
//@property (assign) NSInteger currentPage;

///@brife 下面滑动的View
@property (strong, nonatomic) UIView *slideView;

///@brife 上方的view
@property (strong, nonatomic) UIView *topMainView;

///@brife 上方的ScrollView
@property (strong, nonatomic) UIScrollView *topScrollView;

///@brife 整个视图的大小
@property (assign) CGRect mViewFrame;

@end

@implementation SliderSwitch

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titlesArray {
    if (self = [super initWithFrame:frame]) {
        self.dataArray = titlesArray;
        _mViewFrame = frame;
        _topViews = [[NSMutableArray alloc] init];

        [self initTopTabs];
        [self initSlideView];
        
//        if ([self.delegate respondsToSelector:@selector(sliderSwitch:didSelectedIndex:)]) {
//            [self.delegate sliderSwitch:self didSelectedIndex:0];
//        }
    }
    return self;
}

#pragma mark - UI
#pragma mark -- 初始化滑动的指示View
- (void)initSlideView {
    
    CGFloat width = _mViewFrame.size.width / self.dataArray.count;

    _slideView = [[UIView alloc] initWithFrame:CGRectMake(0, TOPHEIGHT - 5, width, 5)];
    [_slideView setBackgroundColor:[UIColor whiteColor]];
    [_topScrollView addSubview:_slideView];
}

#pragma mark -- 实例化顶部的tab
-(void) initTopTabs{
    CGFloat width = _mViewFrame.size.width / self.dataArray.count;
    
    _topMainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _mViewFrame.size.width, TOPHEIGHT)];
    _topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, _mViewFrame.size.width, TOPHEIGHT)];
    _topScrollView.showsHorizontalScrollIndicator = NO;
    _topScrollView.showsVerticalScrollIndicator = YES;
    _topScrollView.bounces = NO;
    
    _topScrollView.contentSize = CGSizeMake(_mViewFrame.size.width, TOPHEIGHT);
    
    [self addSubview:_topMainView];
    
    [_topMainView addSubview:_topScrollView];
    
    
    
    for (int i = 0; i < self.dataArray.count; i ++) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(i * width, 0, width, TOPHEIGHT)];
        
        view.backgroundColor = [UIColor lightGrayColor];
        
        if (i % 2) {
            view.backgroundColor = [UIColor grayColor];
        }
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, width, TOPHEIGHT)];
        button.tag = i;
        [button setTitle:self.dataArray[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(tabButton:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        
        
        [_topViews addObject:view];
        [_topScrollView addSubview:view];
    }
}



#pragma mark --点击顶部的按钮所触发的方法
-(void) tabButton: (id) sender{
    UIButton *button = sender;
    [self.delegate sliderSwitch:self button:button];
}

#pragma mark - other
- (void)sliderSwitch:(SliderSwitch *)sliderSwitch scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger currentPage = scrollView.contentOffset.x/scrollView.frame.size.width;

//    if ([self.delegate respondsToSelector:@selector(sliderSwitch:didSelectedIndex:)]) {
//        [self.delegate sliderSwitch:self didSelectedIndex:currentPage];
//    }

}

- (void)sliderSwitch:(SliderSwitch *)sliderSwitch scrollViewDidScroll:(UIScrollView *)scrollView {
    CGRect frame = self.slideView.frame;

    frame.origin.x = scrollView.contentOffset.x/[UIScreen mainScreen].bounds.size.width*self.frame.size.width/self.dataArray.count;
    self.slideView.frame = frame;
}
@end
