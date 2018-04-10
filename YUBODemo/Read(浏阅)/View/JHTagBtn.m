//
//  JHTagBtn.m
//  YUBODemo
//
//  Created by huguan-mac02 on 2018/2/6.
//  Copyright © 2018年 cjh. All rights reserved.
//

#import "JHTagBtn.h"

@implementation JHTagBtn

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:153 / 255.0 green:214 / 255.0 blue:93 / 255.0 alpha:1.0];
//        self.layer.cornerRadius = 3;
//        self.layer.masksToBounds = YES;
//        [self.titleLabel sizeToFit];
         self.titleLabel.font = [UIFont systemFontOfSize:16.];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return self;
}


@end
