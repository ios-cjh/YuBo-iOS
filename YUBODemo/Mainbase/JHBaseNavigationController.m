//
//  JHBaseNavigationController.m
//  YUBODemo
//
//  Created by cjh on 2018/1/11.
//  Copyright © 2018年 cjh. All rights reserved.
//

#import "JHBaseNavigationController.h"

@interface JHBaseNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation JHBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];//153 214 93
    // 全局设置
    [UINavigationBar appearance].barTintColor=[UIColor colorWithRed:153 / 255.0 green:214 / 255.0 blue:93 / 255.0 alpha:1.0];
    [UINavigationBar appearance].titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    
    // 系统的手势
    UIScreenEdgePanGestureRecognizer *gest = self.interactivePopGestureRecognizer;
    // target
    id target = self.interactivePopGestureRecognizer.delegate;
    // 禁止系统的手势
    self.interactivePopGestureRecognizer.enabled = NO;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    [self.view addGestureRecognizer:pan];
        // 监听代理
    pan.delegate = self;
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count >= 1) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

#pragma mark - UIGestureRecognizerDelegate
// 当开始滑动时调用
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    // 当为根控制器是不让移除当前控制器，非根控制器时允许移除
    BOOL open = self.viewControllers.count > 1;
    return open;
}
@end
