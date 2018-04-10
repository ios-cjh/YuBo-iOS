//
//  JHIrregularLabel.m
//  YUBODemo
//
//  Created by huguan-mac02 on 2018/4/3.
//  Copyright © 2018年 cjh. All rights reserved.
//

#import "JHIrregularLabel.h"

@interface JHIrregularLabel()
@property (nonatomic, strong) CAShapeLayer *maskLayer;
@property (nonatomic, strong) UIBezierPath *borderPath;
@end

@implementation JHIrregularLabel

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 创建遮罩
        self.maskLayer = [CAShapeLayer new];
        self.layer.mask = self.maskLayer;
        // 创建路径
        self.borderPath = [UIBezierPath bezierPath];
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    self.maskLayer.frame = self.bounds;
    //起点
    [self.borderPath moveToPoint:CGPointMake(0, 10)];
    //左上圆
    [self.borderPath addQuadCurveToPoint:CGPointMake(10, 0) controlPoint:CGPointMake(0, 0)];
    // 直线到右上角
    [self.borderPath addLineToPoint:CGPointMake(self.bounds.size.width - 10, 0)];
    // 右上圆
    [self.borderPath addQuadCurveToPoint:CGPointMake(self.bounds.size.width, 10) controlPoint:CGPointMake(self.bounds.size.width, 0)];
    // 直线到右下角
    [self.borderPath addLineToPoint:CGPointMake(self.bounds.size.width, self.bounds.size.height)];
    
    //底部小三角形
    [self.borderPath addLineToPoint:CGPointMake(self.bounds.size.width / 2 + 5, self.bounds.size.height)];
    [self.borderPath addLineToPoint:CGPointMake(self.bounds.size.width / 2, self.bounds.size.height - 5)];
    [self.borderPath addLineToPoint:CGPointMake(self.bounds.size.width / 2 - 5, self.bounds.size.height)];
    
    // 左下角
    [self.borderPath addLineToPoint:CGPointMake(0, self.bounds.size.height)];
    // 回到起点
    [self.borderPath addLineToPoint:CGPointMake(0, 10)];
    
    self.maskLayer.path = self.borderPath.CGPath;
}


@end
