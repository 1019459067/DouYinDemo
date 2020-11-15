//
//  FCHTabbar.h
//  DouYinDemo
//
//  Created by HN on 2020/7/27.
//  Copyright © 2020 HN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class DHBottomView;
@protocol DHBottomViewDelegate <NSObject>

- (void)dhBottomView:(DHBottomView *)view didSelectItemAtIndex:(NSInteger)index;
- (void)dhBottomViewDidClickCenterItem:(DHBottomView *)view;

@end

@interface DHBottomView : UIView

@property (weak, nonatomic) id<DHBottomViewDelegate> delegate;
@property (strong, nonatomic) UIView *shadowView;

@end

NS_ASSUME_NONNULL_END
