//
//  JHPublishButton.m
//  YUBODemo
//
//  Created by huguan-mac02 on 2018/2/9.
//  Copyright © 2018年 cjh. All rights reserved.
//

#import "JHPublishButton.h"

@implementation JHPublishButton

-(void)layoutSubviews {
    // 让图片居中在上
    CGFloat width = self.imageView.frame.size.width;
    CGFloat height = self.imageView.frame.size.height;
    CGFloat y = 0;
    CGFloat x = (self.frame.size.width - width) / 2;//图片居中显示
    self.imageView.frame = CGRectMake(x, y, width, height);
    // 让label在图片下面
    self.titleLabel.frame = CGRectMake(0, height + 8, self.frame.size.width, self.titleLabel.frame.size.height);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}
@end
