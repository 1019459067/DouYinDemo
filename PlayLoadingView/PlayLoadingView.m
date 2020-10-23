//
//  PlayLoadingView.m
//  DouYinDemo
//
//  Created by HN on 2020/10/23.
//  Copyright © 2020 HN. All rights reserved.
//

#import "PlayLoadingView.h"

@interface PlayLoadingView ()

@property (strong, nonatomic) UIView *playLoadingView;
@property (assign, nonatomic) CGFloat postionX;
@end

@implementation PlayLoadingView

- (instancetype)initWithFrame:(CGRect)frame postionX:(CGFloat)postionX {
    if (self = [super initWithFrame:frame]) {
        self.postionX = postionX;
        [self settingUI];
    }
    return self;
}

- (void)settingUI {
    self.playLoadingView = [[UIView alloc]init];
    self.playLoadingView.backgroundColor = [UIColor whiteColor];
    [self.playLoadingView setHidden:YES];
    [self addSubview:self.playLoadingView];
    
    self.playLoadingView.frame = CGRectMake(0, 0, 5, 2);
    self.playLoadingView.center = CGPointMake(self.postionX, self.frame.size.height/2.);
}

#pragma mark - other
- (void)showLoadingPlayAnimation:(BOOL)isStart {
    if (isStart) {
        self.playLoadingView.backgroundColor = [UIColor whiteColor];
        self.playLoadingView.hidden = NO;
        [self.playLoadingView.layer removeAllAnimations];
        
        CAAnimationGroup *animationGroup = [[CAAnimationGroup alloc] init];
        animationGroup.duration = 0.65;
        animationGroup.beginTime = CACurrentMediaTime() + 0;
        animationGroup.repeatCount = MAXFLOAT;
        animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        
        CABasicAnimation *scaleAnimation = [CABasicAnimation animation];
        scaleAnimation.keyPath = @"transform.scale.x";
        scaleAnimation.fromValue = @(1.0f);
        scaleAnimation.toValue = @(1.0f * [UIScreen mainScreen].bounds.size.width);
        
        CABasicAnimation *alphaAnimation = [CABasicAnimation animation];
        alphaAnimation.keyPath = @"opacity";
        alphaAnimation.fromValue = @(1.0f);
        alphaAnimation.toValue = @(0.25f);
        
        [animationGroup setAnimations:@[scaleAnimation, alphaAnimation]];
        [self.playLoadingView.layer addAnimation:animationGroup forKey:nil];
    } else {
        [self.playLoadingView.layer removeAllAnimations];
        self.playLoadingView.hidden = YES;
    }
}

@end
