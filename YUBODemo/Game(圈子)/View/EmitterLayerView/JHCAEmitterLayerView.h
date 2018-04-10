//
//  JHCAEmitterLayerView.h
//  YUBODemo
//
//  Created by huguan-mac02 on 2018/1/22.
//  Copyright © 2018年 cjh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHCAEmitterLayerView : UIView
// 给子类暴露接口
- (void)setEmitterLayer:(CAEmitterLayer *)layer;
- (CAEmitterLayer *)emitterLayer;

- (void)show;

@end
