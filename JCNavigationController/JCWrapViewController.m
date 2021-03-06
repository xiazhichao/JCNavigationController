//
//  JCWrapViewController.m
//  JCNavigationController
//
//  Created by Jam on 16/3/29.
//  Copyright © 2016年 Jam. All rights reserved.
//

#import "JCWrapViewController.h"
#import "JCWrapNavigationController.h"
#import "JCNavigationViewController.h"

@interface JCWrapViewController ()

@end

@implementation JCWrapViewController

+ (JCWrapViewController *)wrapViewControllerWithRootController:(UIViewController<JCNavigationControllerCustomBar> *)rootViewController {
    
    JCWrapNavigationController *wrapNavController;
    if ([rootViewController conformsToProtocol:@protocol(JCNavigationControllerCustomBar)]) {
        wrapNavController = [[JCWrapNavigationController alloc] initWithNavigationBarClass:[rootViewController jcNavigationControllerCustomBar] toolbarClass:nil];
    } else {
        wrapNavController = [[JCWrapNavigationController alloc] init];
    }
    wrapNavController.viewControllers = @[rootViewController];
    
    JCWrapViewController *wrapViewController = [[JCWrapViewController alloc] init];
    [wrapViewController.view addSubview:wrapNavController.view];
    [wrapViewController addChildViewController:wrapNavController];
    
    return wrapViewController;
}

-(UIViewController *)currentViewController:(JCWrapViewController *)wrapViewController
{
    if (wrapViewController.childViewControllers.count <= 0) return wrapViewController;
    UIViewController *vc = wrapViewController.childViewControllers[0];
    if ([vc isKindOfClass:[JCWrapNavigationController class]]) {
        return ((JCWrapNavigationController *)vc).viewControllers.firstObject;
    }
    return wrapViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)hidesBottomBarWhenPushed {
    return [self rootViewController].hidesBottomBarWhenPushed;
}

- (UITabBarItem *)tabBarItem {
    return [self rootViewController].tabBarItem;
}

- (NSString *)title {
    return [self rootViewController].title;
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return [self rootViewController];
}

- (UIViewController *)childViewControllerForStatusBarHidden {
    return [self rootViewController];
}

#pragma mark private method

- (UIViewController *)rootViewController {
    JCWrapNavigationController *wrapNavController = [[self childViewControllers] firstObject];
    return wrapNavController.childViewControllers.firstObject;
}

@end
