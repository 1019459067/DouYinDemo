//
//  DHMessageViewController.m
//  huinongwang
//
//  Created by HN on 2020/10/26.
//  Copyright © 2020 cnhnb. All rights reserved.
//

#import "DHMessageViewController.h"

@interface DHMessageViewController ()

@end

@implementation DHMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    
    UILabel *label = [[UILabel alloc]init];
    label.bounds = CGRectMake(0, 0, self.view.frame.size.width, 50);
    label.center = CGPointMake(self.view.frame.size.width/2., self.view.frame.size.height/2.);
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = UIColor.redColor;
    label.adjustsFontSizeToFitWidth = YES;
    label.text = [NSString stringWithFormat:@"%s",__func__];
    [self.view addSubview:label];
    
    self.view.backgroundColor = UIColor.whiteColor;
}
@end
