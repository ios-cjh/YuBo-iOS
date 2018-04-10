//
//  JHProgressHUD.h
//  YUBODemo
//
//  Created by cjh on 2018/1/25.
//  Copyright © 2018年 cjh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface JHProgressHUD : NSObject
+(void)showOnlyTextInView:(UIView *)view text:(NSString *)text;
+ (void)hideHUD:(MBProgressHUD *)hud;
+ (MBProgressHUD *)showHUD:(UIView *)view;
@end
