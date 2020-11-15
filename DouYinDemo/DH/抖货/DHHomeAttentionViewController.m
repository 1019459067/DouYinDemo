//
//  DHHomeAttentionViewController.m
//  DouYinDemo
//
//  Created by HN on 2020/10/26.
//  Copyright © 2020 cnhnb. All rights reserved.
//

#import "DHHomeAttentionViewController.h"

@interface DHHomeAttentionViewController ()

@end

@implementation DHHomeAttentionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;

    // Do any additional setup after loading the view.
    self.label.text = [NSString stringWithFormat:@"%s",__func__];
}

@end
