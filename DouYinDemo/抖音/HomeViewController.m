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
#import "DHScrollView.h"
#import "NLSliderSwitch.h"

#define TopBarHeight (([UIScreen mainScreen].bounds.size.height >= 812.0) ? 88.f : 64.f)

@interface HomeViewController ()<GKViewControllerPushDelegate, UITabBarControllerDelegate, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *topBgView;
@property (nonatomic, strong) NLSliderSwitch *sliderSwitch;

@property (nonatomic, strong) DHScrollView *mainScrolView;

@property (nonatomic, strong) Test1ViewController *test1VC;
@property (nonatomic, strong) Test2ViewController *test2VC;

@property (nonatomic, strong) NSArray *childVCs;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.greenColor;
    self.gk_navigationBar.hidden = YES;
    self.gk_statusBarStyle = UIStatusBarStyleLightContent;
//    self.gk_statusBarHidden = YES;
    // 设置左滑push代理
    self.gk_pushDelegate = self;

    [self settingUpUI];
}

- (void)settingUpUI {
    self.sliderSwitch = [[NLSliderSwitch alloc]initWithFrame:CGRectMake(0, 0, 200, 44) buttonSize:CGSizeMake(100, 44)];
    self.sliderSwitch.titleArray = @[@"test1VC",@"test2VC"];
    self.sliderSwitch.normalTitleColor = [UIColor whiteColor];
    self.sliderSwitch.selectedTitleColor = [UIColor whiteColor];
    self.sliderSwitch.selectedButtonColor = [UIColor whiteColor];
    self.sliderSwitch.titleFont = [UIFont systemFontOfSize:15];
    self.sliderSwitch.backgroundColor = [UIColor clearColor];
    self.sliderSwitch.delegate = (id)self;
    self.sliderSwitch.viewControllers = @[self.test1VC,self.test2VC];
    [self.topBgView addSubview:self.sliderSwitch];
    
    // scrolView
    [self.view addSubview:self.mainScrolView];
    self.mainScrolView.frame = self.view.bounds;
    
    self.childVCs = @[self.test1VC, self.test2VC];

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

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.mainScrolView) {
        float xx = scrollView.contentOffset.x;
        int rate = round(xx/[UIScreen mainScreen].bounds.size.width);
        if (rate != self.sliderSwitch.selectedIndex)
        {
            [self.sliderSwitch slideToIndex:rate];
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat pageIndex = scrollView.contentOffset.x/scrollView.bounds.size.width;

    CGFloat sliderLayerX = CGRectGetWidth(self.sliderSwitch.sliderLayer.frame) * pageIndex;
    CGFloat sliderLayerY = CGRectGetMinY(self.sliderSwitch.sliderLayer.frame);
    CGFloat sliderLayerW = CGRectGetWidth(self.sliderSwitch.sliderLayer.frame);
    CGFloat sliderLayerH = CGRectGetHeight(self.sliderSwitch.sliderLayer.frame);
    self.sliderSwitch.sliderLayer.frame = CGRectMake(sliderLayerX, sliderLayerY, sliderLayerW, sliderLayerH);

    NSLog(@"xwh：%f", pageIndex);
}


- (void)sliderSwitch:(NLSliderSwitch *)sliderSwitch didSelectedIndex:(NSInteger)selectedIndex{
    [self.mainScrolView scrollRectToVisible:CGRectMake(selectedIndex * [UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) animated:YES];
}

- (void)dealloc {
    NSLog(@"%@ dealloc", NSStringFromClass([self class]));
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
        _mainScrolView = [DHScrollView new];
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

@end
