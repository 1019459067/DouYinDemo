//
//  DHTabbarButton.m
//  DouYinDemo
//
//  Created by HN on 2020/10/24.
//  Copyright © 2020 HN. All rights reserved.
//

#import "DHTabbarButton.h"

@implementation DHTabbarButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.indicatorLine];
    }
    return self;
}

- (UIView *)indicatorLine {
    if (!_indicatorLine) {
        CGFloat indicatorLineW = 32;
        CGFloat indicatorLineH = 1;
        CGFloat indicatorLineX = (self.frame.size.width-indicatorLineW)/2.;
        CGFloat indicatorLineY = self.frame.size.height-5;
        
        _indicatorLine = [[UIView alloc]initWithFrame:CGRectMake(indicatorLineX, indicatorLineY, indicatorLineW, indicatorLineH)];
        _indicatorLine.backgroundColor = UIColor.whiteColor;
        _indicatorLine.layer.cornerRadius = indicatorLineH/2.;
        [self addSubview:_indicatorLine];
        
        _indicatorLine.hidden = YES;
    }
    return _indicatorLine;
}
@end
