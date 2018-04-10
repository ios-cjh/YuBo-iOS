//
//  JHProgressHUD.m
//  YUBODemo
//
//  Created by cjh on 2018/1/25.
//  Copyright © 2018年 cjh. All rights reserved.
//

#import "JHProgressHUD.h"


@implementation JHProgressHUD
+(void)showOnlyTextInView:(UIView *)view text:(NSString *)text {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = text;
    hud.offset = CGPointMake(0.f, 0.f);
    hud.label.font = [UIFont systemFontOfSize:13];
    hud.label.numberOfLines = 2;
    [hud hideAnimated:YES afterDelay:2.f];
}

+ (void)hideHUD:(MBProgressHUD *)hud {
    [hud hideAnimated:YES];
}

+ (MBProgressHUD *)showHUD:(UIView *)view {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    return hud;
}


@end
