//
//  Test2ViewController.m
//  DouYinDemo
//
//  Created by HN on 2020/9/15.
//  Copyright © 2020 cnhnb. All rights reserved.
//

#import "Test2ViewController.h"
#import "NLSliderSwitchProtocol.h"

@interface Test2ViewController ()<NLSliderSwitchProtocol>

@end

@implementation Test2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.gk_statusBarStyle = UIStatusBarStyleLightContent;
    self.gk_navigationBar.hidden = YES;

    UILabel *label = [[UILabel alloc]init];
    label.bounds = CGRectMake(0, 0, self.view.frame.size.width, 50);
    label.center = CGPointMake(self.view.frame.size.width/2., self.view.frame.size.height/2.);
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = UIColor.yellowColor;
    label.adjustsFontSizeToFitWidth = YES;
    label.text = [NSString stringWithFormat:@"%s",__func__];
    [self.view addSubview:label];
    
    self.view.backgroundColor = UIColor.systemPinkColor;
}

- (void)viewDidScrollToVisiableArea
{
    NSLog(@"当前滑动到了‘%s’页面",__func__);
}
@end
