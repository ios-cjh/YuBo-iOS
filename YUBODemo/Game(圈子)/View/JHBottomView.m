//
//  JHBottomView.m
//  YUBODemo
//
//  Created by cjh on 2018/2/8.
//  Copyright © 2018年 cjh. All rights reserved.
//

#import "JHBottomView.h"
#import "JHPublishButton.h"


#define PIC_WIDTH  70
#define PIC_HEIGHT 70

/**
 视图容器
 */
@implementation JHBottomView


-(void)closeMyVcView:(void(^)(void))complete {
    CGFloat dy = CGRectGetHeight(self.frame) + 70;
    for (int i = 0; i < 6; i++) {
        JHPublishButton *publishBtn = self.subviews[i];
        CGFloat x =  publishBtn.frame.origin.x;
        [UIView animateWithDuration:0.3 delay:6 * 0.03 - i * 0.03 usingSpringWithDamping:0.7 initialSpringVelocity:0.04 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            publishBtn.frame = CGRectMake(x, dy, PIC_WIDTH, PIC_HEIGHT);
        } completion:^(BOOL finished) {
            
            [publishBtn removeFromSuperview];
            complete();
        }];
    }
}
/**
 显示视图
 */

-(void)show {
    int columnCount = self.columnCount?self.columnCount:3;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for (int i = 0; i < 6; i++) {
            int row = i / columnCount;// 行
            int col = i % columnCount;// 列
            // 间距
            CGFloat margin = (self.bounds.size.width - (columnCount * PIC_WIDTH)) / (columnCount + 1); //记得括号括起来
            // pointx
            CGFloat picX = margin + (margin + PIC_WIDTH) * col;
            // pointy
            CGFloat picY = margin + (margin + PIC_HEIGHT) * row;
            
            JHPublishButton *publishBtn = [JHPublishButton new];
            publishBtn.frame = CGRectMake(picX, picY + 615, PIC_WIDTH, PIC_HEIGHT);//让按钮放在底部
            publishBtn.backgroundColor = [UIColor magentaColor];
            [self addSubview:publishBtn];
            
            // 执行动画
            [UIView animateWithDuration:0.5 delay:i * 0.05 usingSpringWithDamping:0.7 initialSpringVelocity:0.05 options:UIViewAnimationOptionAllowUserInteraction animations:^{
                publishBtn.frame = CGRectMake(picX, picY, PIC_WIDTH, PIC_HEIGHT);// 动画执行
            } completion:^(BOOL finished) {
                
            }];
        }
    });
}
@end
