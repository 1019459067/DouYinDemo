//
//  TestBaseViewController.m
//  DouYinDemo
//
//  Created by XWH on 2020/10/28.
//  Copyright © 2020 HN. All rights reserved.
//

#import "TestBaseViewController.h"
#import "DHTabBarController.h"
#import "MainViewController.h"

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
//    [self pushMainVC];
    
    [self pushTabVC];
}

- (void)pushTabVC {
    DHTabBarController *tabVC = [[DHTabBarController alloc]init];
    tabVC.hidesBottomBarWhenPushed = YES;
//    tabVC.modalPresentationStyle = UIModalPresentationFullScreen;
//    [self presentViewController:tabVC animated:YES completion:nil];
    [self.navigationController pushViewController:tabVC animated:YES];
}

- (void)pushMainVC {
    MainViewController *tabVC = [[MainViewController alloc]init];
    tabVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:tabVC animated:YES];
}
@end
