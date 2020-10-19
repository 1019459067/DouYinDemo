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

@end

@interface SliderSwitch : UIView

@property (assign, nonatomic) id<SliderSwitchDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titlesArray;

- (void)updatePositonWithIndex:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
