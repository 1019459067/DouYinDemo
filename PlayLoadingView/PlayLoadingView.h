//
//  PlayLoadingView.h
//  DouYinDemo
//
//  Created by HN on 2020/10/23.
//  Copyright © 2020 HN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PlayLoadingView : UIView

- (instancetype)initWithFrame:(CGRect)frame postionX:(CGFloat)postionX;

- (void)showLoadingPlayAnimation:(BOOL)isStart;

@end

NS_ASSUME_NONNULL_END
