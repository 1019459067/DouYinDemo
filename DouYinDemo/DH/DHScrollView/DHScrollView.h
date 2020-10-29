//
//  DHScrollView.h
//  GKDYVideo
//
//  Created by HN on 2020/9/15.
//  Copyright © 2020 cnhnb.All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DHScrollView : UIScrollView

@property (assign, nonatomic) NSInteger scrollPageIndex; // 可滑动push的临界下标
@end

NS_ASSUME_NONNULL_END
