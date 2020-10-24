//
//  HomeViewController.m
//  DouYinDemo
//
//  Created by HN on 2020/9/15.
//  Copyright © 2020 cnhnb. All rights reserved.
//

#import "HomeViewController.h"
#import "Test1ViewController.h"
#import "Test2ViewController.h"
#import "Test3ViewController.h"
#import "DHScrollView.h"
#import "SlideTabBarView.h"
#import "PlayLoadingView.h"

@interface HomeViewController ()<GKViewControllerPushDelegate, UITabBarControllerDelegate, UIScrollViewDelegate, SlideTabBarViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *topBgView;
@property (weak, nonatomic) IBOutlet UIButton *showLoadingButton;

@property (strong, nonatomic) SlideTabBarView *slideTabBarView;
@property (strong, nonatomic) DHScrollView *mainScrolView;
@property (strong, nonatomic) PlayLoadingView *playLoadingView;

@property (strong, nonatomic) Test1ViewController *test1VC;
@property (strong, nonatomic) Test2ViewController *test2VC;
@property (strong, nonatomic) Test3ViewController *test3VC;

@property (strong, nonatomic) NSArray *childVCs;

@end

@implementation HomeViewController

#pragma mark - life
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.greenColor;
    self.gk_navigationBar.hidden = YES;
    self.gk_statusBarStyle = UIStatusBarStyleLightContent;
//    self.gk_statusBarHidden = YES;
    // 设置左滑push代理
    self.gk_pushDelegate = self;

    [self settingUI];
    [self addPlayLoadingView];
}

- (void)dealloc {
    NSLog(@"%@ dealloc", NSStringFromClass([self class]));
}

#pragma mark - UI
- (void)settingUI {
    self.slideTabBarView = [[SlideTabBarView alloc]initWithFrame:CGRectMake(0, 0, 200, 44) titles:@[@"test1VC", @"test2VC", @"test3VC"]];
    self.slideTabBarView.delegate = self;
    [self.topBgView addSubview:self.slideTabBarView];
    
    self.childVCs = @[self.test1VC, self.test2VC, self.test3VC];
    
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
    [self.view insertSubview:self.topBgView aboveSubview:self.mainScrolView];
    [self.view insertSubview:self.showLoadingButton aboveSubview:self.mainScrolView];

    [self slideTabBarView:self.slideTabBarView didSelectedIndex:1];
}

- (void)addPlayLoadingView {
    self.playLoadingView = [[PlayLoadingView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-49-APPDELEGATE.window.safeAreaInsets.bottom, [UIScreen mainScreen].bounds.size.width, 2) postionX:self.view.center.x];
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
    PersonalViewController *personalVC = HNWLoadControllerFromStoryboard(SBName, NSStringFromClass(PersonalViewController.class));
    personalVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:personalVC animated:YES];
}

#pragma mark - 懒加载
- (DHScrollView *)mainScrolView {
    if (!_mainScrolView) {
        _mainScrolView = [[DHScrollView alloc]init];
        _mainScrolView.scrollPageIndex = self.childVCs.count-1;
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

- (Test1ViewController *)test1VC {
    if (!_test1VC) {
        _test1VC = HNWLoadControllerFromStoryboard(SBName, NSStringFromClass(Test1ViewController.class));
    }
    return _test1VC;
}

- (Test2ViewController *)test2VC {
    if (!_test2VC) {
        _test2VC = HNWLoadControllerFromStoryboard(SBName, NSStringFromClass(Test2ViewController.class));
    }
    return _test2VC;
}

- (Test3ViewController *)test3VC {
    if (!_test3VC) {
        _test3VC = HNWLoadControllerFromStoryboard(SBName, NSStringFromClass(Test3ViewController.class));
    }
    return _test3VC;
}

@end
