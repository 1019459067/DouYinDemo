//
//  TestBarView.h
//  DouYinDemo
//
//  Created by XWH on 2020/10/29.
//  Copyright © 2020 HN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class TestBarView;

@protocol TestBarViewDelegate <NSObject>

- (void)testBarView:(TestBarView *)view didSelectItemAtIndex:(NSInteger)index;

@end

@interface TestBarView : UIView

@property (nonatomic, weak) id<TestBarViewDelegate> viewDelegate;

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titlesArray;

@end

NS_ASSUME_NONNULL_END
