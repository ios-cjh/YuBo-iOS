//
//  JHCAEmitterLayerView.m
//  YUBODemo
//
//  Created by huguan-mac02 on 2018/1/22.
//  Copyright © 2018年 cjh. All rights reserved.
//

#import "JHCAEmitterLayerView.h"

@interface JHCAEmitterLayerView() {
    CAEmitterLayer  *_emitterLayer;
}
@end

@implementation JHCAEmitterLayerView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        _emitterLayer = (CAEmitterLayer *)self.layer; // self.layer会调用该方法layerClass
        
    }
    return self;
}

+ (Class)layerClass {

    return [CAEmitterLayer class];
}

// 让子类实现
- (void)show {
    
}

- (void)setEmitterLayer:(CAEmitterLayer *)layer {
    _emitterLayer = layer;
}

- (CAEmitterLayer *)emitterLayer {
    return _emitterLayer;
}


@end
