//
//  UIGestureRecognizer+Block.m
//  YUBODemo
//
//  Created by cjj on 2018/4/9.
//  Copyright © 2018年 cjh. All rights reserved.
//

#import "UIGestureRecognizer+Block.h"
#import <objc/runtime.h>

static const int target_key;
@implementation UIGestureRecognizer (Block)

+(instancetype)hh_gestureRecognizerWithActionBlock:(HHGestureBlock)block {
    __typeof(self) weakSelf = self;
    return [[weakSelf alloc] initWithActionBlock:block];
}

-(instancetype)initWithActionBlock:(HHGestureBlock)block {
    self = [self init];
    if (block) {
        objc_setAssociatedObject(self, &target_key, block, OBJC_ASSOCIATION_COPY_NONATOMIC); // 把block存起来
    }
    [self addTarget:self action:@selector(invoke:)];
    return self;
}

-(void)invoke:(id)sender {
   HHGestureBlock block =  objc_getAssociatedObject(self, &target_key); // 取出block
    if (block) {
        block(sender);
    }
}



@end
