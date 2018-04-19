//
//  AppDelegate.m
//  YUBODemo
//
//  Created by huguan-mac02 on 2018/1/11.
//  Copyright © 2018年 cjh. All rights reserved.
//

#import "AppDelegate.h"
#import "JHBaseTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    JHBaseTabBarController *baseTabC = [JHBaseTabBarController alloc];
    self.window.rootViewController = baseTabC;
    [self.window makeKeyAndVisible];
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {

}


- (void)applicationDidEnterBackground:(UIApplication *)application {

}


- (void)applicationWillEnterForeground:(UIApplication *)application {

}


- (void)applicationDidBecomeActive:(UIApplication *)application {

}


- (void)applicationWillTerminate:(UIApplication *)application {

}


@end
