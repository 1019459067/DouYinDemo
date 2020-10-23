//
//  SliderSwitch.h
//  DouYinDemo
//
//  Created by HN on 2020/10/19.
//  Copyright © 2020 HN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SliderSwitch;
@protocol SliderSwitchDelegate <NSObject>

- (void)sliderSwitch:(SliderSwitch *)sliderSwitch didSelectedIndex:(NSInteger)selectedIndex;
- (void)sliderSwitch:(SliderSwitch *)sliderSwitch button:(UIButton *)sender;

@end

@interface SliderSwitch : UIView

@property (assign, nonatomic) id<SliderSwitchDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titlesArray;

- (void)sliderSwitch:(SliderSwitch *)sliderSwitch scrollViewDidScroll:(UIScrollView *)scrollView;

- (void)sliderSwitch:(SliderSwitch *)sliderSwitch scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
@end

NS_ASSUME_NONNULL_END
