//
//  Test4ViewController.m
//  DouYinDemo
//
//  Created by XWH on 2020/10/28.
//  Copyright © 2020 HN. All rights reserved.
//

#import "Test4ViewController.h"

@interface Test4ViewController ()

@end

@implementation Test4ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;

    self.label.text = [NSString stringWithFormat:@"%s",__func__];
}

@end
