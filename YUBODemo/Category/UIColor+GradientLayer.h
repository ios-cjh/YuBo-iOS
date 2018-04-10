//
//  UIColor+GradientLayer.h
//  YUBODemo
//
//  Created by huguan-mac02 on 2018/1/22.
//  Copyright © 2018年 cjh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (GradientLayer)
+(CAGradientLayer *)setGradientLayerInView:(UIView *)view withFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor;

@end
