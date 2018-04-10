//
//  UIGestureRecognizer+Block.h
//  YUBODemo
//
//  Created by cjj on 2018/4/9.
//  Copyright © 2018年 cjh. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^HHGestureBlock)(id gestureRecognizer);

@interface UIGestureRecognizer (Block)

+(instancetype)hh_gestureRecognizerWithActionBlock:(HHGestureBlock)block;

@end
