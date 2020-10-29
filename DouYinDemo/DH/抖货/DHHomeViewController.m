//
//  DHHomeViewController.m
//  DouYinDemo
//
//  Created by HN on 2020/9/15.
//  Copyright © 2020 cnhnb. All rights reserved.
//

// ViewController
#import "DHHomeViewController.h"
#import "DHHomeAttentionViewController.h"
#import "DHHomeRecommendViewController.h"
#import "DHMyViewController.h"

// View
#import "DHScrollView.h"
#import "SlideTabBarView.h"
#import "PlayLoadingView.h"

@interface DHHomeViewController ()<GKViewControllerPushDelegate, UITabBarControllerDelegate, UIScrollViewDelegate, SlideTabBarViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *topBgView;
@property (weak, nonatomic) IBOutlet UISwitch *testBT;

@property (strong, nonatomic) SlideTabBarView *slideTabBarView;
@property (strong, nonatomic) DHScrollView *mainScrolView;
@property (strong, nonatomic) PlayLoadingView *playLoadingView;

@property (strong, nonatomic) DHHomeAttentionViewController *attentionVC;
@property (strong, nonatomic) DHHomeRecommendViewController *recommendVC;

@property (strong, nonatomic) NSArray *childVCs;

@end

@implementation DHHomeViewController

#pragma mark - life
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;

//    self.gk_navigationBar.hidden = YES;
//    self.gk_statusBarStyle = UIStatusBarStyleLightContent;
//    self.gk_statusBarHidden = YES;
    // 设置左滑push代理
    self.gk_pushDelegate = self;

    [self settingUI];
    [self addPlayLoadingView];
}


- (void)dealloc {
    NSLog(@"xwh: %@ dealloc", NSStringFromClass([self class]));
}

#pragma mark - UI
- (void)settingUI {
    UIEdgeInsets safeAreaInsets = UIEdgeInsetsZero;
    if (@available(iOS 11.0, *)) {
        safeAreaInsets = APPDELEGATE.window.safeAreaInsets;
    } else {
        // Fallback on earlier versions
    }
    self.slideTabBarView = [[SlideTabBarView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-120)/2., safeAreaInsets.top, 120, 30) titles:@[@"test1VC", @"test2VC"]];
    self.slideTabBarView.delegate = self;
    [self.view addSubview:self.slideTabBarView];
    
    self.childVCs = @[self.attentionVC, self.recommendVC];
    
    // scrolView
    [self.view addSubview:self.mainScrolView];
    self.mainScrolView.frame = self.view.bounds;
    
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    CGFloat h = [UIScreen mainScreen].bounds.size.height;

    [self.childVCs enumerateObjectsUsingBlock:^(UIViewController *vc, NSUInteger idx, BOOL * _Nonnull stop) {
        [self addChildViewController:vc];
        [self.mainScrolView addSubview:vc.view];

        vc.view.frame = CGRectMake(idx * w, 0, w, h);
    }];

    self.mainScrolView.contentSize = CGSizeMake(w * self.childVCs.count, h);//禁止竖向滚动
    
    // 默认显示播放器页
    self.mainScrolView.contentOffset = CGPointMake(0, 0);
    [self.view insertSubview:self.slideTabBarView aboveSubview:self.mainScrolView];
    [self.view insertSubview:self.testBT aboveSubview:self.mainScrolView];

    [self slideTabBarView:self.slideTabBarView didSelectedIndex:0];
}

- (void)addPlayLoadingView {
    UIEdgeInsets safeAreaInsets = UIEdgeInsetsZero;
    if (@available(iOS 11.0, *)) {
        safeAreaInsets = APPDELEGATE.window.safeAreaInsets;
    } else {
        // Fallback on earlier versions
    }
    self.playLoadingView = [[PlayLoadingView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-49-safeAreaInsets.bottom, [UIScreen mainScreen].bounds.size.width, 2) postionX:self.view.center.x];

//    self.playLoadingView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.1];
    [self.view addSubview:self.playLoadingView];
}

- (IBAction)onActionTest:(UIButton *)sender {
    sender.selected = !sender.selected;
    [self.playLoadingView showLoadingPlayAnimation:sender.selected];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.slideTabBarView updateSlideViewWithScroll:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self.slideTabBarView updateCurrentPageWithScroll:scrollView];
}

#pragma mark - SlideTabBarViewDelegate
- (void)slideTabBarView:(SlideTabBarView *)slideTabBarView
       didSelectedIndex:(NSInteger)selectedIndex {
    [self.mainScrolView setContentOffset:CGPointMake(selectedIndex * self.mainScrolView.frame.size.width, 0) animated:YES];
}

- (void)slideTabBarView:(SlideTabBarView *)slideTabBarView
   didSelectedPageIndex:(NSInteger)pageIndex
{
    NSLog(@"xwh：%@", NSStringFromClass([self.childVCs[pageIndex] class]));
}

#pragma mark - GKViewControllerPushDelegate
- (void)pushToNextViewController {
    DHMyViewController *personalVC = HNWLoadControllerFromStoryboard(SBName, NSStringFromClass(DHMyViewController.class));
    personalVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:personalVC animated:YES];
}

#pragma mark - get data
- (DHScrollView *)mainScrolView {
    if (!_mainScrolView) {
        _mainScrolView = [[DHScrollView alloc]init];
        _mainScrolView.scrollPageIndex = 1;
        _mainScrolView.pagingEnabled = YES;
        _mainScrolView.showsHorizontalScrollIndicator = NO;
        _mainScrolView.showsVerticalScrollIndicator = NO;
        _mainScrolView.bounces = NO; // 禁止边缘滑动
        _mainScrolView.delegate = self;
        if (@available(iOS 11.0, *)) {
            _mainScrolView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }
    }
    return _mainScrolView;
}

- (DHHomeAttentionViewController *)attentionVC {
    if (!_attentionVC) {
        _attentionVC = [[DHHomeAttentionViewController alloc]init];
    }
    return _attentionVC;
}

- (DHHomeRecommendViewController *)recommendVC {
    if (!_recommendVC) {
        _recommendVC = [[DHHomeRecommendViewController alloc]init];
    }
    return _recommendVC;
}

@end
