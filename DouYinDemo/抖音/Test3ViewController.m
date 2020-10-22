//
//  Test3ViewController.m
//  DouYinDemo
//
//  Created by HN on 2020/10/22.
//  Copyright © 2020 HN. All rights reserved.
//

#import "Test3ViewController.h"

@interface Test3ViewController ()

@end

@implementation Test3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.gk_navigationBar.hidden = YES;

    UILabel *label = [[UILabel alloc]init];
    label.bounds = CGRectMake(0, 0, self.view.frame.size.width, 50);
    label.center = CGPointMake(self.view.frame.size.width/2., self.view.frame.size.height/2.);
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = UIColor.whiteColor;
    label.adjustsFontSizeToFitWidth = YES;
    label.text = [NSString stringWithFormat:@"%s",__func__];
    [self.view addSubview:label];
    
    self.view.backgroundColor = UIColor.greenColor;
}

@end
