//
//  Color.m
//  YUBODemo
//
//  Created by cjh on 2018/1/19.
//  Copyright © 2018年 cjh. All rights reserved.
//

#import "Color.h"

@implementation Color
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    // 获得当前上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 填充当前上下文
    CGContextSetFillColorWithColor(context, color.CGColor);
    // 填充渲染区域
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
