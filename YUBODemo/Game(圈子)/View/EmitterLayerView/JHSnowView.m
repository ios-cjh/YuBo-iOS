//
//  JHSnowView.m
//  YUBODemo
//
//  Created by huguan-mac02 on 2018/1/22.
//  Copyright © 2018年 cjh. All rights reserved.
//

#import "JHSnowView.h"

@implementation JHSnowView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 初始化设置
        [self initEmitterLayerProperties];
    }
    return self;
}

-(void)initEmitterLayerProperties {
    self.emitterLayer.masksToBounds   = YES;
    self.emitterLayer.emitterShape    = kCAEmitterLayerLine;
    self.emitterLayer.emitterMode     = kCAEmitterLayerSurface;
    self.emitterLayer.emitterSize     = self.frame.size;
    self.emitterLayer.emitterPosition = CGPointMake(220, -40);
    self.layer.cornerRadius = 7;
    self.layer.masksToBounds = YES;
}

// 实现父类提供的接口方法
- (void)show {
    // 设置粒子
    CAEmitterCell *snowflake  = [CAEmitterCell emitterCell];
    snowflake.birthRate       = 0.5f;
    snowflake.speed           = 10.f;
    snowflake.velocity        = 2.f;
    snowflake.velocityRange   = 10.f;
    snowflake.yAcceleration   = 10.f;
    snowflake.emissionRange   = 2 * M_PI;
    snowflake.spinRange       = 0.25 * M_PI;
    snowflake.contents        = (__bridge id)([UIImage imageNamed:@"luoyu.png"].CGImage);
    snowflake.lifetime        = HUGE;
    snowflake.scale           = 0.5;
    snowflake.scaleRange      = 0.9;
    
    // 将粒子添加到粒子发射器中
    self.emitterLayer.emitterCells = @[snowflake];
}


@end
