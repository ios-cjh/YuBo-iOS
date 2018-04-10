//
//  JHRippleView.h
//  YUBODemo
//
//  Created by cjh on 2018/1/23.
//  Copyright © 2018年 cjh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHRippleView : UIView
@property (nonatomic, strong) UIImage   *image;          // 图像
@property (nonatomic, assign) CGSize    imageSize;       // 图像大小，默认为原始图像大小
@property (nonatomic, assign) NSInteger rippleCount;     // 水波纹数量
@property (nonatomic, assign) CGFloat   rippleDuration;  // 水波纹时间
@property (nonatomic, strong) UIColor   *rippleColor;    // 水波纹颜色
@property (nonatomic, strong) UIColor   *borderColor;    // 水波纹边框颜色
@property (nonatomic, assign) CGFloat   borderWidth;     // 水波纹边框宽度

- (instancetype) initMinRadius:(CGFloat)minRadius maxRadius:(CGFloat)maxRadius; // 初始化并设置最小半径和最大半径
- (void)startAnimation; // 执行动画方法

@end
