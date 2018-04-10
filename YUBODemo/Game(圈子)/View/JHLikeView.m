//
//  JHLikeView.m
//  YUBODemo
//
//  Created by cjh on 2018/3/17.
//  Copyright © 2018年 cjh. All rights reserved.
//

#import "JHLikeView.h"

@interface JHLikeView()
@property (nonatomic, strong) NSMutableArray *icon_arr;
@end

@implementation JHLikeView
-(void)drawRect:(CGRect)rect {
    self.icon_arr = [NSMutableArray new];
    // 添加图片
    for (int i = 1; i < 12; i++) {
        NSString *imageName = [NSString stringWithFormat:@"%03d.png", i];
        UIImage *image = [UIImage imageNamed:imageName];
        [self.icon_arr addObject:image];
    }
    
    // 根据图片个数创建按钮
    for (int i = 0; i < self.icon_arr.count; i++) {
        UIButton *btn = [UIButton new];
        CGFloat width = 20;
        CGFloat height = width;
        
        int a = i % 9;// 0 1,2,3,4,5,6,7,8,9...
        int b = i / 9;//0,0,0,0,0,1 ...
        CGFloat x = a * (width + 5) + 5;
        CGFloat y = b * (width + 5) + 5;
        
        CGRect frame = CGRectMake(x, y, width, height);
        btn.frame = frame;
        [self addSubview:btn];
        
        UIImage *userIcon = self.icon_arr[i];
        [btn setBackgroundImage:userIcon forState:UIControlStateNormal];
        
        NSLog(@"button_height = %.f,  y = %.f", height, y);
        // 计算容器的高度， 将最后一个的y值 + 高度值height
        CGFloat viewHeight = y + height + 5;
        CGRect viewF = self.frame;
        viewF.size.height = viewHeight;
        self.frame = viewF;
        
    }
}

@end
