//
//  JHJumpVcManager.m
//  YUBODemo
//
//  Created by huguan-mac02 on 2018/2/2.
//  Copyright © 2018年 cjh. All rights reserved.
//

#import "JHJumpVcManager.h"
static JHJumpVcManager *jumpManager = nil;
@implementation JHJumpVcManager

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        jumpManager = [super allocWithZone:zone];
    });
    return jumpManager;
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        jumpManager = [[self alloc] init]; // 程序一运行就加载了
    });
}

+(instancetype) shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        jumpManager = [[self alloc] init];
    });
    return jumpManager;
}



-(UINavigationController *)navigationVc {
    if (_navigationVc == nil) {
        UITabBarController *tabbarVc = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
         _navigationVc = (UINavigationController *)tabbarVc.selectedViewController;
    }
    return _navigationVc;
}


@end
