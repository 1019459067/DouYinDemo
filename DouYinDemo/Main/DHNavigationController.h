//
//  DHNavigationController.h
//  DouYinDemo
//
//  Created by HN on 2020/9/30.
//  Copyright © 2020 HN. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HomeViewController.h"
#import "AttentionViewController.h"
#import "PlayerViewController.h"
#import "PersonalViewController.h"

NS_ASSUME_NONNULL_BEGIN

#define HNWLoadControllerFromStoryboard(storyboardNameStr, storyboardIdStr) [[UIStoryboard storyboardWithName:storyboardNameStr bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:storyboardIdStr]

#define SBName @"main"

@interface DHNavigationController : UINavigationController

@end

NS_ASSUME_NONNULL_END
