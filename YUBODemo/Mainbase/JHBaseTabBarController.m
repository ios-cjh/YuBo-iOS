//
//  JHBaseTabBarController.m
//  YUBODemo
//
//  Created by cjh on 2018/1/11.
//  Copyright © 2018年 cjh. All rights reserved.
//

#import "JHBaseTabBarController.h"
#import "JHBaseNavigationController.h"
#import "JHBaseTabBar.h"
#import "JHPrettyViewController.h"
#import "JHReadViewController.h"
#import "JHMineViewController.h"
#import "JHPublishViewController.h"




@interface JHBaseTabBarController ()
@property (nonatomic, strong) JHBaseTabBar *jhTabbar;

@end

@implementation JHBaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    _jhTabbar = [[JHBaseTabBar alloc] init];
    [_jhTabbar.centerBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    _jhTabbar.tintColor = [UIColor colorWithRed:27.0/255.0 green:118.0/255.0 blue:208/255.0 alpha:1];
    //透明设置为NO，显示白色，view的高度到tabbar顶部截止，YES的话到底部
    _jhTabbar.translucent = YES;
    //利用KVC 将自己的tabbar赋给系统tabBar
    [self setValue:_jhTabbar forKeyPath:@"tabBar"];
    [self addChildViewControllers];
    self.view.backgroundColor = [UIColor whiteColor];
   
}

//添加子控制器
- (void)addChildViewControllers{
    //图片大小建议32*32
    [self addChildrenViewController:[[JHPrettyViewController alloc] init] andTitle:@"美图" andImageName:@"tab1_n" andSelectImage:@"tab1_p"];
    [self addChildrenViewController:[[JHLiveViewController alloc] init] andTitle:@"直播" andImageName:@"tab2_n" andSelectImage:@"tab2_p"];
    //中间这个不设置东西，只占位
    [self addChildrenViewController:[[JHPublishViewController alloc] init] andTitle:@"DEMO圈" andImageName:@"" andSelectImage:@""];
    [self addChildrenViewController:[[JHReadViewController alloc] init] andTitle:@"浏阅" andImageName:@"tab3_n" andSelectImage:@"tab3_p"];
    [self addChildrenViewController:[[JHMineViewController alloc] init] andTitle:@"我" andImageName:@"tab4_n" andSelectImage:@"tab4_p"];
}


- (void)addChildrenViewController:(UIViewController *)childVC andTitle:(NSString *)title andImageName:(NSString *)imageName andSelectImage:(NSString *)selectedImage{
    childVC.tabBarItem.image = [UIImage imageNamed:imageName];
    childVC.tabBarItem.selectedImage =  [UIImage imageNamed:selectedImage];
    childVC.title = title;
    
    JHBaseNavigationController *baseNav = [[JHBaseNavigationController alloc] initWithRootViewController:childVC];
    
    [self addChildViewController:baseNav];
}

- (void)buttonAction:(UIButton *)button{
    self.selectedIndex = 2;//关联中间按钮
    [self rotationAnimation];
}


//tabbar选择时的代理
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{

    if (tabBarController.selectedIndex == 2){//选中中间的按钮
        [self rotationAnimation];
    }else {
        [_jhTabbar.centerBtn.layer removeAllAnimations];
    }
}
//旋转动画
- (void)rotationAnimation{
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI*2.0];
    rotationAnimation.duration = 3.0;
    rotationAnimation.repeatCount = HUGE;
    [_jhTabbar.centerBtn.layer addAnimation:rotationAnimation forKey:@"key"];
}


@end
