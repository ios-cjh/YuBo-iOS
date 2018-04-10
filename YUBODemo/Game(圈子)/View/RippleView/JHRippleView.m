//
//  JHRippleView.m
//  YUBODemo
//
//  Created by huguan-mac02 on 2018/1/23.
//  Copyright © 2018年 cjh. All rights reserved.
//

#import "JHRippleView.h"

@interface JHRippleView()

@property (nonatomic, assign) CGFloat minRadius;
@property (nonatomic, assign) CGFloat maxRadius;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation JHRippleView
// 初始化并设置最小半径和最大半径
- (instancetype) initMinRadius:(CGFloat)minRadius maxRadius:(CGFloat)maxRadius {
    if (self = [super init]) { // 会触发setFrame方法
        _minRadius = minRadius;
        _maxRadius = maxRadius;
        _rippleCount = 5;
        _rippleDuration = 3;
        
    }
    return self;
}

// 执行动画方法
- (void)startAnimation {
    CALayer * animationLayer = [CALayer layer];
    for (int i = 0; i < self.rippleCount;i++) {
        CALayer *pulsingLayer = [CALayer layer];
        
        pulsingLayer.frame = CGRectMake(0, 0, _maxRadius*2, _maxRadius*2);
        
        pulsingLayer.position = CGPointMake(40, 40);

        if (!_rippleColor) { // 设置默认值
            _rippleColor = [UIColor colorWithWhite:1 alpha:0.7];
        }
        // 设置边框等属性
        pulsingLayer.backgroundColor = [_rippleColor CGColor];
        pulsingLayer.backgroundColor = [UIColor orangeColor].CGColor;
        pulsingLayer.cornerRadius = _maxRadius;
        pulsingLayer.borderColor = [_borderColor CGColor];
        pulsingLayer.borderWidth = _borderWidth;
        
        // 组动画 (图层扩大 + 透明)
        CAMediaTimingFunction * defaultCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
        
        CAAnimationGroup * animationGroup = [CAAnimationGroup animation];
        animationGroup.removedOnCompletion = NO; // 防止app退出程序 动画消失
        animationGroup.fillMode = kCAFillModeBackwards;
        animationGroup.beginTime = CACurrentMediaTime() + i * _rippleDuration / _rippleCount;
        animationGroup.duration = _rippleDuration;
        animationGroup.repeatCount = HUGE;
        animationGroup.timingFunction = defaultCurve;
        
        // 设置水波纹比例
        CABasicAnimation * scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation.fromValue = @(_minRadius / _maxRadius);
        scaleAnimation.toValue = @1.0;

        // 设置水波纹透明度
        CAKeyframeAnimation * opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        opacityAnimation.values = @[@1, @0.9, @0.8, @0.7, @0.6, @0.5, @0.4, @0.3, @0.2, @0.1, @0];
        opacityAnimation.keyTimes = @[@0, @0.1, @0.2, @0.3, @0.4, @0.5, @0.6, @0.7, @0.8, @0.9, @1];
        
        // 将各动画添加到动画组
        animationGroup.animations = @[scaleAnimation, opacityAnimation];
        [pulsingLayer addAnimation:animationGroup forKey:@"plulsing"];

        // 添加每一圈的图层到animati中onLayer图层
        [animationLayer addSublayer:pulsingLayer];
    }
    // 把animationLayer图层添加到我们的视图图层中
    [self.layer addSublayer:animationLayer];
}

- (UIImageView*)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.backgroundColor = self.backgroundColor;
        _imageView.layer.masksToBounds = YES;
    }
    return _imageView;
}

- (void)setImage:(UIImage *)image {
    UIImageView *tmpImgView = [self imageView];
    [tmpImgView setImage:image];
    tmpImgView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    tmpImgView.layer.cornerRadius = image.size.width / 2;
}

- (void)setImageSize:(CGSize)imageSize {
    CGRect newFrame = CGRectMake(0, 0, imageSize.width, imageSize.height);
    UIImageView *tmpImgView = [self imageView];
    tmpImgView.frame = newFrame;
    tmpImgView.layer.cornerRadius = imageSize.width / 2;
}

-(void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    self.layer.cornerRadius = self.bounds.size.width / 2;
}

@end
