//
//  UIColor+GradientLayer.m
//  YUBODemo
//
//  Created by huguan-mac02 on 2018/1/22.
//  Copyright © 2018年 cjh. All rights reserved.
//

#import "UIColor+GradientLayer.h"

@implementation UIColor (GradientLayer)
+(CAGradientLayer *)setGradientLayerInView:(UIView *)view withFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor {
     CAGradientLayer *gradientLayer = [CAGradientLayer layer];
     gradientLayer.frame = view.bounds;
     gradientLayer.colors = @[(__bridge id)fromColor.CGColor,(__bridge id)toColor.CGColor];
     gradientLayer.startPoint = CGPointMake(0.0, 0.0);
     gradientLayer.endPoint= CGPointMake(1.0, 0);
     gradientLayer.locations = @[@0.5,@0.7];
     return gradientLayer;
}


@end
