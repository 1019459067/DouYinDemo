//
//  DHHomeBaseViewController.m
//  huinongwang
//
//  Created by HN on 2020/10/26.
//  Copyright © 2020 cnhnb. All rights reserved.
//

// ViewController
#import "DHHomeBaseViewController.h"

@interface DHHomeBaseViewController ()

@end

@implementation DHHomeBaseViewController

#pragma mark - life
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;

    self.label = [[UILabel alloc]init];
    self.label.bounds = CGRectMake(0, 0, self.view.frame.size.width, 50);
    self.label.center = CGPointMake(self.view.frame.size.width/2., self.view.frame.size.height/2.);
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.textColor = UIColor.redColor;
    self.label.adjustsFontSizeToFitWidth = YES;
    self.label.text = [NSString stringWithFormat:@"%s",__func__];
    [self.view addSubview:self.label];
    
    self.view.backgroundColor = UIColor.orangeColor;
}

@end
