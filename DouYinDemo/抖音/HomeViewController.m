//
//  HomeViewController.m
//  DouYinDemo
//
//  Created by HN on 2020/9/15.
//  Copyright © 2020 cnhnb. All rights reserved.
//

#import "HomeViewController.h"
#import "AttentionViewController.h"
#import "PlayerViewController.h"
#import "DHScrollView.h"


@interface HomeViewController ()<GKViewControllerPushDelegate, UITabBarControllerDelegate, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *topBgView;

@property (nonatomic, strong) DHScrollView *mainScrolView;

@property (nonatomic, strong) AttentionViewController *attentionVC;
@property (nonatomic, strong) PlayerViewController *playerVC;

@property (nonatomic, strong) NSArray *childVCs;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.greenColor;
    self.gk_navigationBar.hidden = YES;
    self.gk_statusBarHidden = YES;

    // 设置左滑push代理
    self.gk_pushDelegate = self;
    [self.view addSubview:self.mainScrolView];
    self.mainScrolView.frame = self.view.bounds;
    
    self.childVCs = @[self.attentionVC, self.playerVC];
    
    CGFloat w = self.view.frame.size.width;
    CGFloat h = self.view.frame.size.height;
    
    [self.childVCs enumerateObjectsUsingBlock:^(UIViewController *vc, NSUInteger idx, BOOL * _Nonnull stop) {
        [self addChildViewController:vc];
        [self.mainScrolView addSubview:vc.view];
        
        vc.view.frame = CGRectMake(idx * w, 0, w, h);
    }];
    
    self.mainScrolView.contentSize = CGSizeMake(self.childVCs.count * w, 0);
    
    // 默认显示播放器页
    self.mainScrolView.contentOffset = CGPointMake(w, 0);
    [self.view insertSubview:self.topBgView aboveSubview:self.mainScrolView];
}

- (UIBarButtonItem *)itemWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    UIButton *btn = [UIButton new];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
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

- (AttentionViewController *)attentionVC {
    if (!_attentionVC) {
        _attentionVC = HNWLoadControllerFromStoryboard(SBName, NSStringFromClass(AttentionViewController.class));
    }
    return _attentionVC;
}

- (PlayerViewController *)playerVC {
    if (!_playerVC) {
        _playerVC = HNWLoadControllerFromStoryboard(SBName, NSStringFromClass(PlayerViewController.class));
    }
    return _playerVC;
}

@end
