//
//  TestBaseViewController.m
//  DouYinDemo
//
//  Created by XWH on 2020/10/28.
//  Copyright © 2020 HN. All rights reserved.
//

#import "TestBaseViewController.h"
#import "DHTabBarController.h"

@interface TestBaseViewController ()

@end

@implementation TestBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.label = [[UILabel alloc]init];
    self.label.bounds = CGRectMake(0, 0, self.view.frame.size.width, 50);
    self.label.center = CGPointMake(self.view.frame.size.width/2., self.view.frame.size.height/2.);
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.textColor = UIColor.redColor;
    self.label.adjustsFontSizeToFitWidth = YES;
    self.label.text = [NSString stringWithFormat:@"%s",__func__];
    [self.view addSubview:self.label];
    
    self.view.backgroundColor = UIColor.orangeColor;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"push" style:UIBarButtonItemStylePlain target:self action:@selector(onActionPush:)];
}

- (UIBarButtonItem *)rt_customBackItemWithTarget:(id)target action:(SEL)action
{
    return nil;
}

- (IBAction)onActionPush:(UIButton *)sender {
    DHTabBarController *tabVC = [[DHTabBarController alloc]init];
    tabVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:tabVC animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
