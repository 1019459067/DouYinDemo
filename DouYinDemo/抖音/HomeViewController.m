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
#import "SliderSwitch.h"

#define TopBarHeight (([UIScreen mainScreen].bounds.size.height >= 812.0) ? 88.f : 64.f)

@interface HomeViewController ()<GKViewControllerPushDelegate, UITabBarControllerDelegate, UIScrollViewDelegate, SliderSwitchDelegate>
@property (weak, nonatomic) IBOutlet UIView *topBgView;

@property (strong, nonatomic) SliderSwitch *sliderSwitch;
@property (nonatomic, strong) DHScrollView *mainScrolView;

@property (nonatomic, strong) Test1ViewController *test1VC;
@property (nonatomic, strong) Test2ViewController *test2VC;
@property (nonatomic, strong) Test3ViewController *test3VC;

@property (nonatomic, strong) NSArray *childVCs;

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
}

- (void)dealloc {
    NSLog(@"%@ dealloc", NSStringFromClass([self class]));
}

#pragma mark - UI
- (void)settingUI {
    self.sliderSwitch = [[SliderSwitch alloc]initWithFrame:CGRectMake(0, 0, 200, 44) titles:@[@"test1VC", @"test2VC", @"test3VC"]];
    self.sliderSwitch.delegate = self;
    [self.topBgView addSubview:self.sliderSwitch];
    
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
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat value = scrollView.contentOffset.x - scrollView.bounds.size.width;
    CGFloat progress = value/scrollView.bounds.size.width;

    [self.sliderSwitch showShadowAnimationWithProgress:progress];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger pageIndex = scrollView.contentOffset.x/scrollView.bounds.size.width;
    [self sliderSwitchDidSelectedIndex:pageIndex];
    
    NSLog(@"xwh===  %ld",pageIndex);
}

- (void)sliderSwitchDidSelectedIndex:(NSInteger)index
{
    NSLog(@"xwh：%@", NSStringFromClass([self.childVCs[index] class]));
}

#pragma mark - SliderSwitchDelegate
- (void)sliderSwitch:(SliderSwitch *)sliderSwitch didSelectedIndex:(NSInteger)selectedIndex {
    [self.mainScrolView scrollRectToVisible:CGRectMake(selectedIndex * [UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) animated:YES];
    [self sliderSwitchDidSelectedIndex:selectedIndex];
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
